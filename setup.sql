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
  ("A good day here at Pluto. How you guys doing down there?"),
  ("We will send a exploratory spaceship to you, it might be there in 10 years we have no idea."),
  ("Uh, come on, rainy day at Pluto arterys. There will be traffic again on the air #firstplutoproblems"),
  ("Some say Pluto is not a planet anymore. Jerry Smith was with us! #freericksanchez"),
  ("Maybe billiard? Nope, being from Pluto is better."),
  ("Have you ever visited New Netherlands in Pluto? They have great food! (See relevant xkcd)"),
  ("Pluto never should have been a planet, they say. They break my heart."),
  ("Did you know we are still orbiting the same star as you guys? How come you forget us :("),
  ("Send me some Pluto puns if you have any, I'll add them to my plutobase"),
  ("We have a very fun country called heart, ya'know"),
  ("Did you hear an earthling speak plutonian before? It's adorable <3"),
  ("Hello, hello, is there anybody in there? Just not if you can hear me, is there anyone at home?"),
  ("I was discovered in 1930, I'm older than most of you here. Respect for elderly."),
  ("Pluto Fun Fact: We have 5 moons here! Imagine yakamoz*5 (do you know what that means?)"),
  ("Pluto Fun Fact: We have been named after ancient Roman god of the underworld. We have a statue of him here. Come visit us maybe?"),
  ("Pluto Fun Fact: Our one year is your 248 years."),
  ("Pluto Fun Fact: Venus rotates slower than us, hah!"),
  ("Pluto Fun Fact: Sky is dark here! You can see stars even during days! Can you imagine how great that is? #visitpluto"),
  ("Pluto Fun Fact: Apparently this: ♇ is the symbol for pluto. If you can't see it, It's a P with a tail (like L)"),
  ("Pluto Fun Fact: We were closer to Sun than Neptune around 1980s! How come we're not a planet :("),
  ("Pluto Fun Fact: Umm.. We have a heart?"),
  ("I missed New Horizons.."),
  ("Put poor pluto into a search engine. They make planetary fun of us :(");