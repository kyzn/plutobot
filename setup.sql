--Copyright (C) 2016 Kivanc Yazan
--See LICENSE file for more details about GNU General Public License.


CREATE DATABASE IF NOT EXISTS plutobot 
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

USE plutobot;

CREATE TABLE IF NOT EXISTS `tweets` (
  `TweetID` bigint(20) NOT NULL PRIMARY KEY,
  `TweetText` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `TweetDT` datetime NOT NULL,
  `UserID` bigint(20) NOT NULL,
  `UserName` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `Replied` boolean NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `replies` (
  `ReplyID` int NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `ReplyText` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `nohandletweets` (
  `NoHandleId` int NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `NoHandleText` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO replies (ReplyText) VALUES
  (", you know who else has heart? Pluto, that's who! #plutohasheart "),
  (", Pluto has heart too! #plutohas♥ #realninthplanet"),
  ("! Ehm, not to be that guy, but Pluto has heart too! #dontforgetpluto #plutohasheart"),
  ("! Guess who else has heart? Pluto! #dontforgetpluto #plutohas♥"),
  (", I would love to kindly remind you that Former Planet Pluto is also in possession of a heart. #plutolovesyou"),
  (", that and pluto has heart too! #realninthplanet "),
  (", you know who else has ♥? Pluto, that's who! #dontforgetpluto"),
  (", Pluto has ♥ too! #thankyouearthlings"),
  ("! Ehm, not to be that guy, but Pluto has ♥ too! #plutohas♥"),
  ("! Guess who else has ♥? Pluto! #dontforgetpluto #realninthplanet"),
  (", I would love to kindly remind you that Former Planet Pluto is also in possession of a ♥. #plutohasheart"),
  (", that and #plutohasheart ♥ ");

INSERT INTO nohandletweets (NoHandleText) VALUES
  ("We might send a exploratory spaceship to you, and it might be there in 10 years, we have no idea."),
  ("It's a rainy day at Pluto arterys. #firstplutoproblems"),
  ("Jerry Smith thinks we are a planet! #freericksanchez"),
  ("Being from Pluto is better than billiard."),
  ("We have great food in New Netherlands! (See xkcd)"),
  ("Some say Pluto never should have been a planet. And they break our hearts.."),
  ("We are still orbiting the same star as you guys! How come you forget us :("),
  ("We have a very fun country called heart, ya'know"),
  ("Earthlings sound adorable when they speak plutonian <3"),
  ("I was discovered in 1930, I'm older than most of you here. Respect for elderly."),
  ("We have 5 moons here! Imagine yakamoz*5 (do you know what that means?)"),
  ("We have been named after ancient Roman god of the underworld. We have a statue of him here. Come visit us maybe?"),
  ("Our one year is your 248 years."),
  ("Venus rotates slower than us, hah!"),
  ("Sky is dark here! You can see stars even during days! Can you imagine how great that is? #visitpluto"),
  ("Apparently this: ♇ is the symbol for pluto. If you can't see it, It's a P with a tail (like L)"),
  ("We were closer to Sun than Neptune around 1980s! How come we're not a planet :("),
  ("Umm.. We have a heart?"),
  ("We missed New Horizons.."),
  ("They make planetary fun of us :( Put poor pluto into a search engine.");