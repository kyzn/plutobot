Pluto Bot
===============

It's a simple Twitter bot that searches Twitter for "has heart" tweets, and replies with a "reminder that Pluto also has heart". In order to avoid being offensive to medical tweets, I have used following line as search query:
```
"has heart" -surgery -condition -conditions -attack -disease -problem -problems -congestion -situation -issues
```
That is, it will not reply to any tweets that contain at least one of the words that begin with a minus sign. Actually, you cannot do that on Twitter stream, so I will search for "has heart" and do some post-processing to simulate that behaviour.

This script is heavily based on one of my previous projects, twitter-voting. You can find that one on GitHub too.

#Requirements

You will obviously need Perl installed on your system. Most probably it's installed by default.

MySQL will be utilized too, but you will need at least v5.5.3. This is because we will have `utf8mb4` encoding, and prior versions will not support.
We need several CPAN modules too. You can install all dependencies by running following code block on your terminal/shell.

```bash
sudo cpanm Net::SSLeay Net::OAuth AnyEvent::Twitter::Stream DBD::mysql DateTime::Format::Strptime DateTime::Format::DBI DateTime::Format::MySQL Net::Twitter
```

#Setup
1. You have to setup your database. Run setup.sql on your MySQL.
2. Rename TwitAuth_sample.pm as TwitAuth.pm
3. Write your db credentials into TwitAuth.pm
4. You need to create a Twitter application at [Twitter Apps](http://apps.twitter.com).
5. Copy Twitter tokens to TwitAuth.pm as well.


#How to Use
The easiest way to run it would be to open tmux in a cloud machine. In one window, run stream.pl, and reply.pl in another. That's pretty much it.


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