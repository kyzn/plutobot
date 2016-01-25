#Copyright (C) 2015 Kivanc Yazan
#See LICENSE file for more details about GNU General Public License.

package PlutoAuth;
require Exporter;
use strict;

our @ISA                = qw(Exporter);
our @EXPORT             = qw(getPlutoAuth); 

my %PlutoAuth = ( 

	#username for database connection
	db_user	=>"",

	#password for database connection
	db_pass	=>"",

	#host for database connection, if you're working on local keep localhost
	db_host	=>"localhost",

	#database name. not the table name, but the name for db that has the table you want to work on
	#if you used setup.sql to create the table, leave it as it is
	db_name	=>"plutobot",

	#these are related to your twitter application. go to apps.twitter.com to learn more 
	consumer_key	=>"",
	consumer_secret	=>"",
	token	=> "",
	token_secret	=> "",

    );

sub getPlutoAuth {
 return  %PlutoAuth;
 }

1;