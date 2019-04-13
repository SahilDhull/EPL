# TABLES

DB: epl.db

## ENTITY TABLES: (7)

CLUB,

PLAYER, 

SEASON,

STADIUM,

REFEREE,

MATCH,

MANAGER

## RELATION TABLES: (17)

CLUB_MANAGER,

CLUB_ASST_MANAGER,

CLUB_STADIUM,

CLUB_PLAYER,

SEASON_CHART,

MATCH_IN_SEASON,

SEASON_CHAMPION,

PLAYING_CLUBS,

MOTM,

MATCH_REFEREE,

GOALS,

BOOKING, 

LINEUP, 

SUBSTITUTION, 

CLUB_STATS, 

PLAYER_STATS, 

TRANSFER


### Changes/TODO:
Season status set to 'Ongoing' on default

To update club_player insertion

## Order of Insertion:

.read create.sql

.read trigger.sql

.read player.sql

.read club_and_season.sql

.read match.sql

.read club_player.sql

.read stadium.sql

.read club_stadium.sql

.read playing_clubs.sql

.read lineup.sql

.read ref.sql

.read add.sql
