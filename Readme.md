# TABLES

DB: epl.db

## ENTITY TABLES: (7)

CLUB</br>

PLAYER, 

SEASON</br>

STADIUM</br>

REFEREE</br>

MATCH</br>

MANAGER

## RELATION TABLES: (17)

CLUB_MANAGER</br>
CLUB_ASST_MANAGER</br>
CLUB_STADIUM</br>
CLUB_PLAYER</br>
SEASON_CHART</br>
MATCH_IN_SEASON</br>
SEASON_CHAMPION</br>
PLAYING_CLUBS</br>
MOTM</br>
MATCH_REFEREE</br>
GOALS</br>
BOOKING, 
LINEUP, 
SUBSTITUTION, 
CLUB_STATS, 
PLAYER_STATS, 
TRANSFER


### Changes/TODO:
Season status set to 'Ongoing' on default</br>
To update club_player insertion

## Order of Insertion:

.read create.sql</br>
.read trigger.sql</br>
.read player.sql</br>
.read club_and_season.sql</br>
.read match.sql </br>
.read club_player.sql </br>
.read stadium.sql </br>
.read club_stadium.sql 		</br>
.read playing_clubs.sql 	</br>
.read lineup.sql  	</br>
.read ref.sql 		</br>
.read add.sql 		</br>
