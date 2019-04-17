-- Non-trivial queries


-- Find all defenders who scored own goal ( and all the data...)

WITH A(PLAYER_ID,MATCH_ID,CLUB_ID) AS
(SELECT DISTINCT G.PLAYER_ID, G.MATCH_ID, L.CLUB_ID 
	FROM GOALS AS G, LINEUP AS L
WHERE G.MATCH_ID = L.MATCH_ID AND G.PLAYER_ID = L.PLAYER_ID 
AND G.OWN_GOAL = 1 AND L.POSITION IN ('LB','CB','RB'))
SELECT NAME, CLUB_NAME, ((MATCH_ID-1)/6 + 1) AS SEASON, ((MATCH_ID-1)%6+1) AS MATCH_NO
FROM (PLAYER NATURAL JOIN (A NATURAL JOIN CLUB));


-- How many minutes played by each player?


SELECT PLAYER.NAME,(
(SELECT SUM(S2.STIME - LS.STIME)
FROM ((LINEUP AS L) NATURAL JOIN (SUBSTITUTION AS S1) ) AS LS, SUBSTITUTION AS S2
WHERE L.PLAYER_ID=1 AND LS.PLAYER_ID=LS.PLAYER_IN AND LS.PLAYER_ID=S2.PLAYER_OUT
AND LS.MATCH_ID = S2.MATCH_ID
)+
(SELECT SUM(LB.BOOKING_TIME-S.STIME)
FROM (LINEUP NATURAL JOIN BOOKING) AS LB, SUBSTITUTION AS S
WHERE LB.PLAYER_ID = 1 AND LB.PLAYER_ID=S.PLAYER_IN 
AND LB.MATCH_ID = S.MATCH_ID AND LB.SUB_PLAYED=-1 AND LB.isSUB=1
)+
(SELECT SUM(S.STIME) FROM SUBSTITUTION AS S, LINEUP AS L
WHERE L.PLAYER_ID = 1 AND S.PLAYER_OUT=L.PLAYER_ID 
AND S.MATCH_ID=L.MATCH_ID AND isSUB = 0 AND SUB_PLAYED = -1
)+
(SELECT 90*COUNT(PLAYER_ID) FROM LINEUP
WHERE PLAYER_ID = 1 AND SUB_PLAYED = 0 AND isSUB = 0 AND SUB_PLAYED = 0 AND 
MATCH_ID NOT IN (SELECT MATCH_ID FROM BOOKING WHERE BOOKING_TYPE = 'R' AND PLAYER_ID = 1)
))
FROM PLAYER
WHERE PLAYER_ID = 1;



-- Match Timeline

SELECT MATCH_ID AS MATCH_ID,"GOAL" AS TYPE,GOAL_TIME AS TIME, A.NAME AS PLAYER, B.NAME AS ASSISTED_BY, NULL AS PLAYER_IN, NULL AS PLAYER_OUT, NULL AS CARD_TYPE,C.CLUB_NAME AS CLUB
FROM GOALS,PLAYER AS A,PLAYER AS B,CLUB AS C
WHERE MATCH_ID  = 1 AND A.PLAYER_ID = GOALS.PLAYER_ID AND B.PLAYER_ID = GOALS.ASSIST_BY AND  GOALS.CLUB_ID = C.CLUB_ID
UNION
SELECT MATCH_ID AS MATCH_ID,"SUBSTITUTION" AS TYPE,STIME AS TIME, NULL AS PLAYER, NULL AS ASSISTED_BY, A.NAME AS PLAYER_IN, B.NAME AS PLAYER_OUT, NULL AS CARD_TYPE,C.CLUB_NAME AS CLUB
FROM SUBSTITUTION,PLAYER AS A,PLAYER AS B,CLUB AS C
WHERE MATCH_ID  = 1 AND A.PLAYER_ID = SUBSTITUTION.PLAYER_IN AND B.PLAYER_ID = SUBSTITUTION.PLAYER_OUT AND SUBSTITUTION.CLUB_ID = C.CLUB_ID
UNION
SELECT MATCH_ID AS MATCH_ID,"BOOKING" AS TYPE,BOOKING_TIME AS TIME, A.NAME AS PLAYER, NULL AS ASSISTED_BY, NULL AS PLAYER_IN, NULL AS PLAYER_OUT, BOOKING_TYPE AS CARD_TYPE,C.CLUB_NAME AS CLUB
FROM BOOKING,PLAYER AS A,CLUB AS C
WHERE MATCH_ID  = 1 AND A.PLAYER_ID = BOOKING.PLAYER_ID AND  
C.CLUB_ID = ( SELECT CLUB_ID FROM CLUB_PLAYER AS D WHERE D.PLAYER_ID = A.PLAYER_ID)
ORDER BY TIME;


-- Past between 2 clubs

SELECT C1.CLUB_NAME AS HOME_TEAM, C2.CLUB_NAME AS AWAY_TEAM,HOME_SCORE AS HOME_SCORE,AWAY_SCORE AS AWAY_SCORE
FROM CLUB AS C1, CLUB AS C2,MATCH NATURAL JOIN (SELECT * FROM PLAYING_CLUBS WHERE HOME_CLUB=1 AND AWAY_CLUB = 2)
WHERE C1.CLUB_ID = 1 AND C2.CLUB_ID = 2
UNION 
SELECT C1.CLUB_NAME AS HOME_TEAM, C2.CLUB_NAME AS AWAY_TEAM2,HOME_SCORE AS HOME_SCORE,AWAY_SCORE AS AWAY_SCORE
FROM CLUB AS C1, CLUB AS C2,MATCH NATURAL JOIN (SELECT * FROM PLAYING_CLUBS WHERE HOME_CLUB=2 AND AWAY_CLUB = 1)
WHERE C1.CLUB_ID = 2 AND C2.CLUB_ID = 1;