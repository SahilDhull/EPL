
--  -------------------------  TRIGGERS  ------------------------------------

CREATE TRIGGER ADD_MATCH_IN_SEASON
AFTER INSERT ON MATCH
BEGIN
	INSERT INTO MATCH_IN_SEASON
	VALUES (NEW.MATCH_ID,NEW.MATCH_ID/380+1,NEW.MATCH_ID%380);
END;


-- Updating Match on Goal
CREATE TRIGGER GOAL_IS_SCORED
AFTER INSERT ON GOALS
BEGIN
	UPDATE MATCH
	SET HOME_SCORE = 
	CASE
		WHEN NEW.CLUB_ID = (SELECT DISTINCT HOME_CLUB
	FROM ( (SELECT * FROM MATCH WHERE MATCH_ID = NEW.MATCH_ID)
		NATURAL JOIN PLAYING_CLUBS )) THEN (
			HOME_SCORE + 1
			)
		ELSE HOME_SCORE
	END,
	AWAY_SCORE = 
	CASE
		WHEN NEW.CLUB_ID = (SELECT DISTINCT AWAY_CLUB 
	FROM ( (SELECT * FROM MATCH WHERE MATCH_ID = NEW.MATCH_ID)
		NATURAL JOIN PLAYING_CLUBS )) THEN (
			AWAY_SCORE + 1
			)
		ELSE AWAY_SCORE
	END
	WHERE NEW.MATCH_ID = MATCH.MATCH_ID;
	UPDATE PLAYER_STATS 
	SET ASSISTS = 1 + ASSISTS
	where new.ASSIST_BY = PLAYER_ID and SEASON_ID = NEW.MATCH_ID/380 +1;
	UPDATE PLAYER_STATS 
	SET GOALS_SCORED = 1 + GOALS_SCORED
	where NEW.PLAYER_ID = PLAYER_ID and SEASON_ID = NEW.MATCH_ID/380 +1;
END;

-- Updating Season Charts after updating player stats
CREATE TRIGGER UPDATING_SEASON_CHARTS
AFTER UPDATE ON PLAYER_STATS
BEGIN
	UPDATE SEASON_CHART
	SET TOP_SCORER = 
	CASE
		WHEN NEW.GOALS_SCORED>SEASON_CHART.TOTAL_GOALS THEN (NEW.PLAYER_ID)
		ELSE (TOP_SCORER)
	END,
	TOTAL_GOALS = 
	CASE
		WHEN NEW.GOALS_SCORED>SEASON_CHART.TOTAL_GOALS THEN (NEW.GOALS_SCORED)
		ELSE (TOTAL_GOALS)
	END,
	TOP_ASSISTS = 
	CASE
		WHEN NEW.ASSISTS>SEASON_CHART.TOTAL_ASSISTS THEN (NEW.PLAYER_ID)
		ELSE (TOP_ASSISTS)
	END,
	TOTAL_ASSISTS = 
	CASE
		WHEN NEW.ASSISTS>SEASON_CHART.TOTAL_ASSISTS THEN (NEW.ASSISTS)
		ELSE (TOTAL_ASSISTS)
	END,
	TOP_CLEAN_SHEETS = 
	CASE
		WHEN NEW.CLEAN_SHEET>SEASON_CHART.TOTAL_CLEAN_SHEETS THEN (NEW.PLAYER_ID)
		ELSE (TOP_CLEAN_SHEETS)
	END,
	TOTAL_CLEAN_SHEETS = 
	CASE
		WHEN NEW.CLEAN_SHEET>SEASON_CHART.TOTAL_CLEAN_SHEETS THEN (NEW.CLEAN_SHEET)
		ELSE (TOTAL_CLEAN_SHEETS)
	END
	WHERE NEW.SEASON_ID = SEASON_CHART.SEASON_ID;
END;


-- Change Player Club on transfer
CREATE TRIGGER PLAYER_CLUB_TRANSFER
AFTER INSERT ON TRANSFER
BEGIN
	UPDATE CLUB_PLAYER
	SET CLUB_ID = NEW.ARRIVING_CLUB
	WHERE CLUB_PLAYER.PLAYER_ID = NEW.PLAYER_ID AND CLUB_PLAYER.CLUB_ID = NEW.DEPARTING_CLUB 
	AND NEW.SEASON_ID = (SELECT DISTINCT SEASON_ID FROM SEASON WHERE STATUS = 'Ongoing');
END;

-- Entering into Season Champion
CREATE TRIGGER UPDATING_SEASON_CHAMPION
AFTER UPDATE ON SEASON
WHEN NEW.STATUS='Finished' AND OLD.STATUS='Ongoing'
BEGIN
INSERT INTO SEASON_CHAMPION
SELECT NEW.SEASON_ID, CLUB_ID
FROM CLUB_STATS
WHERE POINTS = (SELECT MAX(POINTS) FROM CLUB_STATS WHERE SEASON_ID = NEW.SEASON_ID)
	AND (GOAL_FOR-GOAL_AGAINST) = (SELECT MAX(GOAL_FOR-GOAL_AGAINST) FROM CLUB_STATS WHERE SEASON_ID = NEW.SEASON_ID);
END;

CREATE TRIGGER UPDATE_TITLES
AFTER INSERT ON SEASON_CHAMPION
BEGIN
UPDATE CLUB
SET TITLES = TITLES + 1
WHERE CLUB_ID = NEW.CLUB_ID;
END;

CREATE TRIGGER MATCH_WINNER_UPDATE
AFTER UPDATE ON MATCH
WHEN NEW.STATUS='Finished' AND OLD.STATUS='Ongoing'
BEGIN
	UPDATE MATCH
	SET WIN = 
	CASE
		WHEN NEW.HOME_SCORE>NEW.AWAY_SCORE THEN (1)
		WHEN NEW.HOME_SCORE<NEW.AWAY_SCORE THEN (-1)
		ELSE 0
	END;
END;

-- ANKIT KUMAR
CREATE TRIGGER MATCH_FINISHED
AFTER UPDATE ON MATCH
WHEN OLD.STATUS='Finished'
BEGIN
	UPDATE CLUB_STATS
	SET PLAYED = PLAYED + 1,
	WON =
	CASE
		WHEN NEW.WIN = 1 AND CLUB_STATS.CLUB_ID = (SELECT HOME_CLUB FROM ( SELECT * FROM MATCH WHERE MATCH_ID=NEW.MATCH_ID) NATURAL JOIN PLAYING_CLUBS)  THEN (
			WON + 1
		)
		WHEN NEW.WIN = -1 AND CLUB_STATS.CLUB_ID = (SELECT AWAY_CLUB FROM ( SELECT * FROM MATCH WHERE MATCH_ID=NEW.MATCH_ID) NATURAL JOIN PLAYING_CLUBS)  THEN (
			WON + 1
		)
		ELSE WON
	END,
	LOSE =
	CASE
		WHEN NEW.WIN = 1 AND CLUB_STATS.CLUB_ID = (SELECT AWAY_CLUB FROM ( SELECT * FROM MATCH WHERE MATCH_ID=NEW.MATCH_ID) NATURAL JOIN PLAYING_CLUBS)  THEN (
			LOSE + 1
		)
		WHEN NEW.WIN = -1 AND CLUB_STATS.CLUB_ID = (SELECT HOME_CLUB FROM ( SELECT * FROM MATCH WHERE MATCH_ID=NEW.MATCH_ID) NATURAL JOIN PLAYING_CLUBS) THEN (
			LOSE + 1
		)
		ELSE LOSE
	END,
	DRAW =
	CASE
		WHEN NEW.WIN = 0 THEN (
			DRAW + 1
		)
		ELSE DRAW
	END,
	GOAL_FOR =
	CASE
		WHEN CLUB_STATS.CLUB_ID = (SELECT AWAY_CLUB FROM ( SELECT * FROM MATCH WHERE MATCH_ID=NEW.MATCH_ID) NATURAL JOIN PLAYING_CLUBS)  THEN (
			GOAL_FOR + NEW.AWAY_SCORE
		)
		WHEN CLUB_STATS.CLUB_ID = (SELECT HOME_CLUB FROM ( SELECT * FROM MATCH WHERE MATCH_ID=NEW.MATCH_ID) NATURAL JOIN PLAYING_CLUBS)  THEN (
			GOAL_FOR + NEW.HOME_SCORE
		)
	END,
	GOAL_AGAINST =
	CASE
		WHEN CLUB_STATS.CLUB_ID = (SELECT AWAY_CLUB FROM ( SELECT * FROM MATCH WHERE MATCH_ID=NEW.MATCH_ID) NATURAL JOIN PLAYING_CLUBS)  THEN (
			GOAL_AGAINST + NEW.HOME_SCORE
		)
		WHEN CLUB_STATS.CLUB_ID = (SELECT HOME_CLUB FROM ( SELECT * FROM MATCH WHERE MATCH_ID=NEW.MATCH_ID) NATURAL JOIN PLAYING_CLUBS) THEN (
			GOAL_AGAINST + NEW.AWAY_SCORE
		)
	END,
	POINTS =
	CASE
		WHEN NEW.WIN=1 AND CLUB_STATS.CLUB_ID = (SELECT HOME_CLUB FROM ( SELECT * FROM MATCH WHERE MATCH_ID=NEW.MATCH_ID) NATURAL JOIN PLAYING_CLUBS)  THEN (
			POINTS + 3
		)
		WHEN NEW.WIN=-1 AND CLUB_STATS.CLUB_ID = (SELECT AWAY_CLUB FROM ( SELECT * FROM MATCH WHERE MATCH_ID=NEW.MATCH_ID) NATURAL JOIN PLAYING_CLUBS) THEN (
			POINTS + 3
		)
		WHEN NEW.WIN = 0 THEN (
			POINTS + 1
			)
		ELSE POINTS
	END
	WHERE CLUB_STATS.SEASON_ID = (NEW.MATCH_ID / 380 + 1) AND (CLUB_STATS.CLUB_ID = (SELECT HOME_CLUB FROM ( SELECT * FROM MATCH WHERE MATCH_ID=NEW.MATCH_ID) NATURAL JOIN PLAYING_CLUBS) OR CLUB_STATS.CLUB_ID = (SELECT AWAY_CLUB FROM ( SELECT * FROM MATCH WHERE MATCH_ID=NEW.MATCH_ID) NATURAL JOIN PLAYING_CLUBS));
END;

-- Shubham

CREATE TRIGGER BOOKING
AFTER INSERT
ON BOOKING
BEGIN
UPDATE PLAYER_STATS
SET RED_COUNT = 
	case
		when new.BOOKING_TYPE = 'R' then RED_COUNT + 1
		when new.BOOKING_TYPE = 'Y' and 2 == 	(
													select count(*)
													from BOOKING as A
													where 	A.MATCH_ID = new.MATCH_ID 
															and A.PLAYER_ID = new.PLAYER_ID
															and A.BOOKING_TYPE = 'Y'
												) 	then RED_COUNT + 1
		else RED_COUNT
	end,
	YELLOW_COUNT = 
	case
		when new.BOOKING_TYPE = 'Y' then YELLOW_COUNT + 1
		else YELLOW_COUNT
	end
where new.PLAYER_ID = PLAYER_ID and SEASON_ID = new.MATCH_ID/380 + 1;
END;


CREATE TRIGGER GIVE_CLEAN_SHEET
AFTER UPDATE
ON MATCH
when OLD.STATUS = 'Ongoing' and NEW.STATUS='Finished'
BEGIN
UPDATE PLAYER_STATS
SET CLEAN_SHEET = CLEAN_SHEET + 1
where 	
		((new.HOME_SCORE = 0
		and PLAYER_ID = 
						(
							select B.PLAYER_ID
							from LINEUP as B
							where B.POSITION = 'GK' AND (B.CLUB_ID,B.MATCH_ID) IN 	(
																						select A.AWAY_CLUB,A.MATCH_ID
																						from (MATCH natural join PLAYING_CLUBS) as A
																						where	A.MATCH_ID = new.MATCH_ID
																				)
						)
		)
		or
		(new.AWAY_SCORE = 0
		and PLAYER_ID = 
						(
							select B.PLAYER_ID
							from LINEUP as B
							where B.POSITION = 'GK' AND (B.CLUB_ID,B.MATCH_ID) IN 	(
																						select A.HOME_CLUB,A.MATCH_ID
																						from (MATCH natural join PLAYING_CLUBS) as A
																						where	A.MATCH_ID = new.MATCH_ID
																				)
						)
		)) and SEASON_ID = new.MATCH_ID/380 + 1; 
END;

CREATE TRIGGER SUBSTITUTION_PLAYER_OUT
AFTER INSERT
ON SUBSTITUTION
BEGIN
UPDATE LINEUP
SET isSUB = 1,
	SUB_PLAYED = -1
where PLAYER_ID = new.PLAYER_OUT and MATCH_ID = new.MATCH_ID;
END;

CREATE TRIGGER SUBSTITUTION_PLAYER_IN
AFTER INSERT
ON SUBSTITUTION
BEGIN
UPDATE LINEUP
SET isSUB = 0,
	SUB_PLAYED = 1
where PLAYER_ID = new.PLAYER_IN and MATCH_ID = new.MATCH_ID;
END;

CREATE TRIGGER MATCHES_PLAYED
AFTER INSERT
ON LINEUP
BEGIN
UPDATE PLAYER_STATS
SET MATCHES_PLAYED = MATCHES_PLAYED + 1
where PLAYER_ID = new.PLAYER_ID and new.isSUB = 0 and SEASON_ID = new.MATCH_ID/380 + 1;
END;

CREATE TRIGGER MATCHES_PLAYED_BY_SUB
AFTER UPDATE
ON LINEUP
when  old.isSUB = 1 and new.isSUB = 0
BEGIN
UPDATE PLAYER_STATS
SET MATCHES_PLAYED = MATCHES_PLAYED + 1
where PLAYER_ID = new.PLAYER_ID and SEASON_ID = new.MATCH_ID/380 + 1;
END;

CREATE TRIGGER MATCHES_STARTED
AFTER INSERT
ON LINEUP
BEGIN
UPDATE PLAYER_STATS
SET MATCHES_STARTED = MATCHES_STARTED + 1
where PLAYER_ID = new.PLAYER_ID and new.isSUB = 0 and SEASON_ID = new.MATCH_ID/380 + 1;
END;


CREATE TRIGGER INSERT_INTO_PLAYER_AND_CLUB_STATS
AFTER INSERT ON SEASON
BEGIN
INSERT INTO PLAYER_STATS(PLAYER_ID,SEASON_ID)
SELECT PLAYER_ID, NEW.SEASON_ID FROM PLAYER;
INSERT INTO CLUB_STATS(CLUB_ID,SEASON_ID)
SELECT CLUB_ID, NEW.SEASON_ID FROM CLUB;
INSERT INTO SEASON_CHART(SEASON_ID)
VALUES (NEW.SEASON_ID);
END;
