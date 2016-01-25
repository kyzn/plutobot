#!/usr/bin/perl

#Copyright (C) 2016 Kivanc Yazan
#See LICENSE file for more details about GNU General Public License.

#Refer to readme.md file to understand how this script works.
#You can always reach/contribute to this open-source code at github.com/kyzn/twitter-voting

use utf8;
use warnings;
use strict;
use AnyEvent::Twitter::Stream 0.27; #capture twitter stream
use DateTime::Format::Strptime; #convert twitter time to perl time
use DateTime::Format::DBI; #convert perl time to mysql time
use DBI(); #mysql connection, db has to be ut8mb4! (refer to setup.sql)

our $VERSION=0.1;

#Upon exiting with ctrl+c, close connections properly.
$SIG{INT}  = \&disconnect;

#Printing introduction
print "
-------------------------------------------------------------------------------
plutobot (streamer) version $VERSION Copyright (C) 2016 Kivanc Yazan

plutobot comes with ABSOLUTELY NO WARRANTY; for details see LICENSE file.
This is free software, and you are welcome to redistribute it
under certain conditions; see LICENSE file for details.
-------------------------------------------------------------------------------

";

#Importing authentication variables from "TwitAuth.pm" file
#This is to have a working db connection and twitter stream. 
#Please check TwitAuth_sample.pm for an example.
use PlutoAuth;

#This hash will store authentication details.
my %twa=getPlutoAuth();

#Words to be skipped
my @dropwords = qw/
operation
surgery
condition
attack
disease
hospital
sick
ill
problem
congestion
situation
issue
/;


#Connect to the db.
my $dbh = DBI->connect("DBI:mysql:database=$twa{db_name};host=$twa{db_host}",
    $twa{db_user},$twa{db_pass},
    {'RaiseError' => 1, 
    mysql_enable_utf8 => 1,
    Callbacks => {
        connected => sub {
            $_[0]->do('SET NAMES utf8mb4');
            return;
            }
        }
    });



#strp and db_parser are variables used to convert time formats
#convert twitter time to perl datetime
my $strp = DateTime::Format::Strptime->new(pattern => '%a %b %d %T %z %Y');
#convert perl datetime to twitter time
my $db_parser = DateTime::Format::DBI->new($dbh);

#done and listener are variables related to twitter streamer.
#when a tweet is received "incoming" is called.
my $done = AnyEvent->condvar;
my $listener = AnyEvent::Twitter::Stream->new(
    consumer_key    => $twa{consumer_key},
    consumer_secret => $twa{consumer_secret},
    token           => $twa{token},
    token_secret    => $twa{token_secret},
    method          => "filter",
    track           => "has heart",
    on_tweet        => \&incoming,
    on_error => \&error,
    timeout  => 60
);

print "

Listening to Twitter.
Username\tTweet
";

$done->recv;
#next line will be run on timeout errors
$dbh->disconnect();

#subroutine to be called when a tweet is received
#a tweet is to be inserted into the database.
sub incoming{

    #pick the tweet
    my $tweet = shift;

    #if there is a problem with the tweet, don't deal with it
    #this prevents script to stop working when a message comes from twitter
    # such as deletion notice, limit notice etc.
    return unless ($tweet->{id});
    
    #if it catches tweet by itself, then skip and return
    return if ($tweet->{user}{id} == 4805083567);

    #stop if what we got was a retweet
    return if ($tweet->{text} =~ /^RT @/);

    #stop if the tweet might be sensitive
    my $sensitive= 0;
    foreach my $dropword (@dropwords){
        if ($tweet->{text} =~ $dropword){
            $sensitive=1;
        }
    }
    return if ($sensitive);

    #stop if the original content do not have "heart"
    return unless (lc($tweet->{text})=~/heart/);

    #insert tweet into db
    $dbh->do("INSERT INTO tweets (TweetID,TweetText,TweetDT,UserID,UserName,Replied) 
        VALUES (?,?,?,?,?,?);", 
    undef, 
    $tweet->{id}, #id of tweet, bigint
    unicodefix($tweet->{text}),
    $db_parser->format_datetime($strp->parse_datetime($tweet->{created_at})),
    $tweet->{user}{id},
    unicodefix($tweet->{user}{screen_name}),
    0
    );

    #Watching incoming tweets can be fun.
    print "\@$tweet->{user}{screen_name}\t$tweet->{text}\n";

}

#subroutine to be called when an error occurs
sub error{
    my $error = shift;
    warn "ERROR: $error";
    $done->send;
}

#subroutine to be called on exiting through sigint (ctrl+c)
sub disconnect(){

    #Just exit in peace.
    print "\nDisconnecting..";
    $dbh->disconnect();
    $done->send;
    print ".\n";
}


#subroutine to fix ascii smilies
sub unicodefix(){
    my ($tweet) = @_;
    #Unicode reserved blocks are
    #d800-dfff surrogate pairs
    #fe00-fe0f variation selector

    #single unicode characters without a starting d
    $tweet=~s/\\u([0-9abcABCefEF].{3})/chr(eval("0x$1"))/eg;

    #single unicode characters with a starting d (not in the reserved zone)
    $tweet=~s/\\u([dD][0-7].{2})/chr(eval("0x$1"))/eg;

    #unicode surrogate pairs (reserved zone)
    $tweet=~s/\\u([dD][89a-fA-F].{2})\\u([dD][89a-fA-F].{2})/
        chr(eval(hex("0x10000") + (hex($1) - hex("0xD800"))* 
        hex("0x400")+ (hex($2) - hex("0xDC00"))->as_hex))/eg;

    return $tweet;
}