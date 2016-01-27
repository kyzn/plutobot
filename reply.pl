#!/usr/bin/perl

#Copyright (C) 2016 Kivanc Yazan
#See LICENSE file for more details about GNU General Public License.

#Refer to readme.md file to understand how this script works.
#You can always reach/contribute to this open-source code at github.com/kyzn/twitter-voting

use utf8;
use warnings;
use strict;
use Net::Twitter; #to reply tweets
use DBI(); #mysql connection, db has to be ut8mb4! (refer to setup.sql)

our $VERSION=0.1;

#Upon exiting with ctrl+c, close connections properly.
$SIG{INT}  = \&disconnect;


#Printing introduction
print "
-------------------------------------------------------------------------------
plutobot (replier) version $VERSION Copyright (C) 2016 Kivanc Yazan

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


#Connection settings to Twitter
my $nt = Net::Twitter->new(
    traits   => [qw/API::RESTv1_1/],
    consumer_key        => $twa{consumer_key},
    consumer_secret     => $twa{consumer_secret},
    access_token        => $twa{token},
    access_token_secret => $twa{token_secret},
);


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


print "

Replying to Twitter:
";

while(1){

    #Send reply 50% of time, and a tweet with no handle rest of time.
    if(rand()<0.50){

        #Grab earliest tweet with no reply and a random reply.
        my $sth_get_tweet = $dbh->prepare("SELECT TweetID, UserName FROM `tweets` WHERE Replied=0 ORDER BY TweetDT ASC LIMIT 1;");
        my $sth_get_reply = $dbh->prepare("SELECT ReplyText FROM `replies` ORDER BY RAND() LIMIT 1;");
           $sth_get_tweet->execute();
           $sth_get_reply->execute();
        my $ref_get_tweet = $sth_get_tweet->fetchrow_hashref();
        my $ref_get_reply = $sth_get_reply->fetchrow_hashref();
        my $twid  = $ref_get_tweet->{'TweetID'};
        my $uname = $ref_get_tweet->{'UserName'};
        my $reply = $ref_get_reply->{'ReplyText'};
        $sth_get_tweet->finish();
        $sth_get_reply->finish();

        #Continue if there was actually such a tweet in the database
        if($twid){

            #Prepare the tweet
            my $tweet = "\@$uname$reply";
            print "$tweet\n";

            #Send the tweet
            $nt->update({ status => $tweet, in_reply_to_status_id => $twid });

            #Mark the grabbed tweet as replied.
            $dbh->do("UPDATE `tweets` SET `Replied`=1 WHERE TweetID=?", undef, $twid);
                    
        }else{
            print "no more tweets :(\n";
        }
    
    }else{

        #Grab a random nohandle tweet.
        my $sth_get_nohandle = $dbh->prepare("SELECT NoHandleText FROM `nohandletweets` ORDER BY RAND() LIMIT 1;");
           $sth_get_nohandle->execute();
        my $ref_get_nohandle = $sth_get_nohandle->fetchrow_hashref();
        my $nohandle = $ref_get_nohandle->{'NoHandleText'};
        $sth_get_nohandle->finish();

        #Prepare the tweet
        my $funfact= random(1000)*1000+random(1000);
        my $tweet = "Pluto funfact $funfact: $nohandle";

        #Send it

        print "$tweet\n";
        $nt->update({ status => $tweet });
                
    }

    #Don't break limits, do one in 15 minutes.
    sleep(15*60);
}






#subroutine to be called when an error occurs
sub error{
    my $error = shift;
    warn "ERROR: $error";
}

#subroutine to be called on exiting through sigint (ctrl+c)
sub disconnect(){

    #Just exit in peace.
    print "\nDisconnecting..";
    $dbh->disconnect();
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
