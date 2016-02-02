Pluto Bot
===============

#DISCLAIMER
What this software does might be against Twitter Terms and Rules, so you might want to make sure you are obeying Twitter rules. Clearly, it's your own responsibility to not to do something 'bad'.

It's a simple Twitter bot that searches Twitter for tweets with "has heart", and replies with a "reminder that Pluto also has heart". It also posts fun facts or puns about Pluto once in a while.


In order to avoid being offensive to medical condition tweets, regular expressions are utilized to not to reply to tweets that has some special keywords.

This script is heavily based on one of my previous projects, [twitter-voting](https://github.com/kyzn/twitter-voting).

#Requirements

You will obviously need Perl installed on your system. Most probably it's installed by default.

MySQL will be utilized too, but you will need at least v5.5.3. This is because we will have `utf8mb4` encoding, and prior versions will not support.
We need several CPAN modules too. You can install all dependencies by running following code block on your terminal/shell.

```bash
sudo cpanm Net::SSLeay Net::OAuth AnyEvent::Twitter::Stream DBD::mysql DateTime::Format::Strptime DateTime::Format::DBI DateTime::Format::MySQL Net::Twitter
```

#Setup
1. Run setup.sql on your MySQL
2. Rename PlutoAuth_sample.pm as PlutoAuth.pm
3. Write your db credentials into TwitAuth.pm
4. Create a Twitter application [here](http://apps.twitter.com).
5. Copy your Twitter tokens to PlutoAuth.pm as well.


#How to Use
The easiest way to run would be to open tmux in a cloud machine. Run stream.pl in one windows, and reply.pl in another.


##Known Issues

Please report any through GitHub issues.

##Copyright and Licence

Copyright (C) 2016 Kivanc Yazan

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy (see LICENSE file) of the GNU General Public License
along with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
