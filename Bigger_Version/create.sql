-- ENTITY TABLES: (7)
-- CLUB, PLAYER, SEASON, STADIUM, REFEREE, MATCH, MANAGER

-- RELATION TABLES: (17)
-- CLUB_MANAGER, CLUB_ASST_MANAGER, CLUB_STADIUM, CLUB_PLAYER, SEASON_CHART
-- MATCH_IN_SEASON, SEASON_CHAMPION, PLAYING_CLUBS, MOTM, MATCH_REFEREE,
-- GOALS, BOOKING, LINEUP, SUBSTITUTION, CLUB_STATS, PLAYER_STATS, TRANSFER

CREATE TABLE CLUB(
	CLUB_ID INTEGER PRIMARY KEY AUTOINCREMENT,
	ABBR VARCHAR(5) UNIQUE NOT NULL,
	CLUB_NAME VARCHAR(30) NOT NULL UNIQUE,
	CLUB_CITY VARCHAR(30) NOT NULL,
	PRESIDENT VARCHAR(30),
	OWNER VARCHAR(30) NOT NULL,
	TITLES INTEGER
);

CREATE TABLE PLAYER(
	PLAYER_ID INTEGER PRIMARY KEY AUTOINCREMENT,
	NAME VARCHAR(30) NOT NULL,
	NATIONALITY VARCHAR(30), 
	PREF_POSITION VARCHAR(30) NOT NULL,
	DOB DATE	
);

CREATE TABLE SEASON(
	SEASON_ID INTEGER PRIMARY KEY,
	STATUS VARCHAR(10) DEFAULT 'Ongoing',
	CHECK (STATUS IN ('Finished','Ongoing'))
);

CREATE TABLE STADIUM(
	STADIUM_ID INTEGER PRIMARY KEY AUTOINCREMENT,
	STADIUM_NAME VARCHAR(20) NOT NULL,
	CAPACITY INTEGER,
	LOCATION VARCHAR(50)
);

CREATE TABLE REFEREE(
	REFEREE_ID INTEGER PRIMARY KEY AUTOINCREMENT,
	REFEREE_NAME VARCHAR(50) NOT NULL
);

CREATE TABLE MATCH(
	MATCH_ID INTEGER PRIMARY KEY AUTOINCREMENT,
	MATCH_DATE DATE NOT NULL,
	HOME_SCORE INTEGER DEFAULT 0 NOT NULL,
	AWAY_SCORE INTEGER DEFAULT 0 NOT NULL,
	AUDIENCE INTEGER DEFAULT 0 NOT NULL,
	FIRST_HALF_ST INTEGER DEFAULT 0 NOT NULL,
	SECOND_HALF_ST INTEGER DEFAULT 0 NOT NULL,
	WIN INTEGER DEFAULT 0 NOT NULL,
	HOME_FORMATION VARCHAR(10) NOT NULL,
	AWAY_FORMATION VARCHAR(10) NOT NULL,
	STATUS VARCHAR(10) NOT NULL,
	CHECK (STATUS IN ("Upcoming","Ongoing","Finished") )
);


CREATE TABLE MANAGER(
	MANAGER_ID INTEGER PRIMARY KEY AUTOINCREMENT,
	MANAGER_NAME VARCHAR(30) NOT NULL,
	NATIONALITY VARCHAR(20) NOT NULL
);



------------------------------------------------------------------------------------------


CREATE TABLE CLUB_MANAGER(
	MANAGER_ID INTEGER,
	CLUB_ID INTEGER,
	SEASON_ID INTEGER,
	FOREIGN KEY (MANAGER_ID) REFERENCES MANAGER(MANAGER_ID),
	FOREIGN KEY (CLUB_ID) REFERENCES CLUB(CLUB_ID),
	FOREIGN KEY (SEASON_ID) REFERENCES SEASON(SEASON_ID),	
	PRIMARY KEY (CLUB_ID, season_id, MANAGER_ID)
);

CREATE TABLE CLUB_ASST_MANAGER(
	CLUB_ID INTEGER,
	SEASON_ID INTEGER,
	ASST_MANAGER_ID INTEGER,
	FOREIGN KEY (CLUB_ID) REFERENCES CLUB(CLUB_ID),
	FOREIGN KEY (SEASON_ID) REFERENCES SEASON(SEASON_ID),	
	FOREIGN KEY (ASST_MANAGER_ID) REFERENCES MANAGER(MANAGER_ID),
	PRIMARY KEY (CLUB_ID, SEASON_ID, ASST_MANAGER_ID)
);

CREATE TABLE CLUB_STADIUM(
	CLUB_ID INTEGER,
	STADIUM_ID INTEGER,
	FOREIGN KEY (CLUB_ID) REFERENCES CLUB(CLUB_ID),
	FOREIGN KEY (STADIUM_ID) REFERENCES STADIUM(STADIUM_ID),
	PRIMARY KEY (CLUB_ID, STADIUM_ID)
);


CREATE TABLE CLUB_PLAYER(
	PLAYER_ID INTEGER,
	CLUB_ID INTEGER,
	FOREIGN KEY (CLUB_ID) REFERENCES CLUB(CLUB_ID),
	FOREIGN KEY (PLAYER_ID) REFERENCES PLAYER(PLAYER_ID), 
	PRIMARY KEY (PLAYER_ID)
);


CREATE TABLE SEASON_CHART(
	SEASON_ID INTEGER PRIMARY KEY,
	TOP_SCORER INTEGER,
	TOP_ASSISTS INTEGER,
	TOP_CLEAN_SHEETS INTEGER,
	POTS INTEGER,
	TOTAL_GOALS INTEGER DEFAULT 0,
	TOTAL_ASSISTS INTEGER DEFAULT 0,
	TOTAL_CLEAN_SHEETS INTEGER DEFAULT 0,
	FOREIGN KEY (SEASON_ID) REFERENCES SEASON(SEASON_ID),
	FOREIGN KEY (TOP_SCORER) REFERENCES PLAYER(PLAYER_ID), 
	FOREIGN KEY (TOP_ASSISTS) REFERENCES PLAYER(PLAYER_ID), 
	FOREIGN KEY (TOP_CLEAN_SHEETS) REFERENCES PLAYER(PLAYER_ID), 
	FOREIGN KEY (POTS) REFERENCES PLAYER(PLAYER_ID) 
);


CREATE TABLE MATCH_IN_SEASON(
	MATCH_ID INTEGER PRIMARY KEY,
	SEASON_ID INTEGER,
	MATCH_COUNT INTEGER,
	FOREIGN KEY (MATCH_ID) REFERENCES MATCH(MATCH_ID),
	FOREIGN	KEY (SEASON_ID) REFERENCES SEASON(SEASON_ID)
);


CREATE TABLE SEASON_CHAMPION(
	CLUB_ID INTEGER,
	SEASON_ID INTEGER,
	FOREIGN KEY (CLUB_ID) REFERENCES CLUB(CLUB_ID),
	FOREIGN KEY (SEASON_ID) REFERENCES SEASON(SEASON_ID),
	PRIMARY KEY (CLUB_ID, SEASON_ID)
);


CREATE TABLE PLAYING_CLUBS(
	MATCH_ID INTEGER PRIMARY KEY,
	HOME_CLUB INTEGER NOT NULL,
	AWAY_CLUB INTEGER NOT NULL,
	FOREIGN KEY (MATCH_ID) REFERENCES MATCH(MATCH_ID),
	FOREIGN KEY (HOME_CLUB) REFERENCES CLUB(CLUB_ID),
	FOREIGN KEY (AWAY_CLUB) REFERENCES CLUB(CLUB_ID),
	CHECK (HOME_CLUB!=AWAY_CLUB)	
);

CREATE TABLE MOTM(
	MATCH_ID INTEGER PRIMARY KEY,
	MOTM INTEGER NOT NULL,
	FOREIGN KEY (MATCH_ID) REFERENCES MATCH(MATCH_ID),
	FOREIGN KEY (MOTM) REFERENCES PLAYER(PLAYER_ID)
);


CREATE TABLE MATCH_REFEREE(
	MATCH_ID INTEGER PRIMARY KEY,
	MAIN_REFEREE INTEGER NOT NULL,
	ASST1 INTEGER NOT NULL,
	ASST2 INTEGER NOT NULL,
	FOURTH_OFFICIAL INTEGER NOT NULL,
	FOREIGN KEY (MATCH_ID) REFERENCES MATCH(MATCH_ID),
	FOREIGN KEY (MAIN_REFEREE) REFERENCES REFEREE(REFEREE_ID),
	FOREIGN KEY (ASST1) REFERENCES REFEREE(REFEREE_ID),
	FOREIGN KEY (ASST2) REFERENCES REFEREE(REFEREE_ID),
	FOREIGN KEY (FOURTH_OFFICIAL) REFERENCES REFEREE(REFEREE_ID),
	CHECK(MAIN_REFEREE NOT IN (ASST1, ASST2, FOURTH_OFFICIAL) ),
	CHECK(ASST1 NOT IN (ASST2, FOURTH_OFFICIAL) ),
	CHECK(ASST2 != FOURTH_OFFICIAL)
);

CREATE TABLE GOALS(
	GOAL_ID INTEGER PRIMARY KEY AUTOINCREMENT,
	MATCH_ID INTEGER NOT NULL,
	PLAYER_ID INTEGER NOT NULL,
	CLUB_ID INTEGER NOT NULL,
	GOAL_TIME INTEGER NOT NULL,
	EXTRATIME INTEGER,
	ASSIST_BY INTEGER,
	OWN_GOAL BOOLEAN DEFAULT 0,
	FOREIGN KEY (MATCH_ID) REFERENCES MATCH(MATCH_ID),
	FOREIGN KEY (PLAYER_ID) REFERENCES PLAYER(PLAYER_ID),
	FOREIGN KEY (CLUB_ID) REFERENCES CLUB(CLUB_ID),
	FOREIGN KEY (ASSIST_BY) REFERENCES PLAYER(PLAYER_ID),
	CHECK (ASSIST_BY != PLAYER_ID)
);

CREATE TABLE BOOKING(
	BOOKING_ID INTEGER PRIMARY KEY AUTOINCREMENT,
	MATCH_ID INTEGER NOT NULL,
	PLAYER_ID INTEGER NOT NULL,
	BOOKING_TYPE CHAR(1) NOT NULL,
	BOOKING_TIME INTEGER NOT NULL,
	FOREIGN KEY (PLAYER_ID) REFERENCES PLAYER(PLAYER_ID),
	FOREIGN KEY (MATCH_ID) REFERENCES MATCH(MATCH_ID),
	CHECK (BOOKING_TYPE IN ("Y","R"))
);


CREATE TABLE LINEUP(
	CLUB_ID INTEGER NOT NULL,
	MATCH_ID INTEGER NOT NULL,
	PLAYER_ID INTEGER NOT NULL,
	isSUB BOOLEAN DEFAULT 0,
	SUB_PLAYED INTEGER DEFAULT 0,
	POSITION VARCHAR(30) NOT NULL,
	FOREIGN KEY (CLUB_ID) REFERENCES CLUB(CLUB_ID),
	FOREIGN KEY (MATCH_ID) REFERENCES MATCH(MATCH_ID),
	FOREIGN KEY (PLAYER_ID) REFERENCES PLAYER(PLAYER_ID),
	PRIMARY KEY (MATCH_ID,PLAYER_ID)
);

CREATE TABLE SUBSTITUTION(
	SUBSTITUTION_COUNT INTEGER DEFAULT 0 NOT NULL,
	MATCH_ID INTEGER NOT NULL,
	CLUB_ID INTEGER NOT NULL,
	PLAYER_IN INTEGER NOT NULL,
	PLAYER_OUT INTEGER NOT NULL,
	STIME INTEGER NOT NULL,
	PHASE INTEGER NOT NULL,
	FOREIGN KEY (MATCH_ID) REFERENCES MATCH(MATCH_ID),
	FOREIGN KEY (CLUB_ID) REFERENCES CLUB(CLUB_ID),
	FOREIGN KEY (PLAYER_IN) REFERENCES PLAYER(PLAYER_ID),
	FOREIGN KEY (PLAYER_OUT) REFERENCES PLAYER(PLAYER_ID),
	CHECK (SUBSTITUTION_COUNT <= 3),
	CHECK (PHASE >=0 AND PHASE <=3),  
	PRIMARY KEY (MATCH_ID, CLUB_ID, SUBSTITUTION_COUNT)
);

CREATE TABLE CLUB_STATS(
	SEASON_ID INTEGER NOT NULL,
	CLUB_ID INTEGER NOT NULL,
	WON INTEGER DEFAULT 0 NOT NULL,
	LOSE INTEGER DEFAULT 0 NOT NULL,
	DRAW  INTEGER DEFAULT 0 NOT NULL,
	GOAL_FOR INTEGER DEFAULT 0 NOT NULL,
	GOAL_AGAINST INTEGER DEFAULT 0 NOT NULL,
	PLAYED INTEGER DEFAULT 0 NOT NULL,
	POINTS INTEGER DEFAULT 0 NOT NULL,
	FOREIGN KEY (SEASON_ID) REFERENCES SEASON(SEASON_ID),
	FOREIGN KEY (CLUB_ID) REFERENCES CLUB(CLUB_ID),
	PRIMARY KEY (CLUB_ID,SEASON_ID)
);

CREATE TABLE PLAYER_STATS(
	PLAYER_ID INTEGER NOT NULL,
	SEASON_ID INTEGER NOT NULL,
	GOALS_SCORED INTEGER DEFAULT 0 NOT NULL,
	ASSISTS INTEGER DEFAULT 0 NOT NULL,
	CLEAN_SHEET INTEGER DEFAULT 0 NOT NULL,
	YELLOW_COUNT INTEGER DEFAULT 0 NOT NULL,
	RED_COUNT INTEGER DEFAULT 0 NOT NULL,
	MATCHES_PLAYED INTEGER DEFAULT 0 NOT NULL,
	MATCHES_STARTED INTEGER DEFAULT 0 NOT NULL,
	FOREIGN KEY (PLAYER_ID) REFERENCES PLAYER(PLAYER_ID),
	FOREIGN KEY (SEASON_ID) REFERENCES SEASON(SEASON_ID),
	PRIMARY KEY (PLAYER_ID, SEASON_ID)
);

CREATE TABLE TRANSFER(
	PLAYER_ID INTEGER NOT NULL,
	SEASON_ID INTEGER NOT NULL,
	ARRIVING_CLUB INTEGER NOT NULL,
	DEPARTING_CLUB INTEGER,
	TRANSFER_AMOUNT INTEGER,
	TRANSFER_TYPE CHAR(1) NOT NULL,
	CONTRACT_START INTEGER,
	CONTRACT_TILL INTEGER,
	SALARY INTEGER,
	JERSEY_NO INTEGER, 
	BUYOUT_CLAUSE INTEGER,
	FOREIGN KEY (PLAYER_ID) REFERENCES PLAYER(PLAYER_ID),
	FOREIGN KEY (SEASON_ID) REFERENCES SEASON(SEASON_ID),
	PRIMARY KEY (PLAYER_ID, SEASON_ID),
	FOREIGN KEY (ARRIVING_CLUB) REFERENCES CLUB(CLUB_ID),
	FOREIGN KEY (DEPARTING_CLUB) REFERENCES CLUB(CLUB_ID),
	CHECK (TRANSFER_TYPE IN ("L", "B")),
	CHECK( CONTRACT_START < CONTRACT_TILL)
	CHECK (SALARY >= 0) 
);
