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

INSERT INTO replies (ReplyText) VALUES
  (", you know who else has heart? Pluto, that's who! #plutohasheart #dontforgetpluto"),
  (", Pluto has heart too! #plutohasheart #dontforgetpluto #realninthplanet"),
  ("! Ehm, not to be that guy, but Pluto has heart too! #dontforgetpluto #plutohasheart"),
  ("! Guess who else has heart? Pluto! #dontforgetpluto #plutohasheart #realninthplanet"),
  (", I would love to kindly remind you that Former Planet Pluto is also in possession of a heart. #plutohasheart"),
  (", that and #plutohasheart! #realninthplanet #dontforgetpluto"),
  (", you know who else has ♥? Pluto, that's who! #plutohasheart #dontforgetpluto"),
  (", Pluto has ♥ too! #plutohasheart #dontforgetpluto #realninthplanet"),
  ("! Ehm, not to be that guy, but Pluto has ♥ too! #dontforgetpluto #plutohasheart"),
  ("! Guess who else has ♥? Pluto! #dontforgetpluto #plutohasheart #realninthplanet"),
  (", I would love to kindly remind you that Former Planet Pluto is also in possession of a ♥. #plutohasheart"),
  (", that and #plutohasheart ♥ #realninthplanet #dontforgetpluto");