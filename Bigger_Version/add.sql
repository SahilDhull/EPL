-- Goals
insert into GOALS(MATCH_ID,PLAYER_ID,CLUB_ID,GOAL_TIME,EXTRATIME,ASSIST_BY,OWN_GOAL)
  values(1,1,1,43,0,2,0);
insert into GOALS(MATCH_ID,PLAYER_ID,CLUB_ID,GOAL_TIME,EXTRATIME,ASSIST_BY,OWN_GOAL)
  values(1,1,1,43,0,2,0);
insert into GOALS(MATCH_ID,PLAYER_ID,CLUB_ID,GOAL_TIME,EXTRATIME,ASSIST_BY,OWN_GOAL)
  values(2,401,18,43,0,2,0);
insert into GOALS(MATCH_ID,PLAYER_ID,CLUB_ID,GOAL_TIME,EXTRATIME,ASSIST_BY,OWN_GOAL)
  values(3,401,18,43,0,2,0);

insert into BOOKING(MATCH_ID,PLAYER_ID,BOOKING_TYPE)
  values(1,1,"Y");

insert into BOOKING(MATCH_ID,PLAYER_ID,BOOKING_TYPE)
  values(1,1,"Y");

insert into BOOKING(MATCH_ID,PLAYER_ID,BOOKING_TYPE)
  values(1,2,"R");

-- insert into SUBSTITUTION(SUBSTITUTION_COUNT,MATCH_ID,CLUB_ID,PLAYER_IN,PLAYER_OUT,STIME,PHASE)
-- 	values (1,1,1,1,2,1,1);

-- insert into TRANSFER(PLAYER_ID,SEASON_ID,ARRIVING_CLUB,DEPARTING_CLUB,
-- 	TRANSFER_AMOUNT,TRANSFER_TYPE,CONTRACT_START,CONTRACT_TILL,SALARY,
-- 	JERSEY_NO,BUYOUT_CLAUSE)
-- 	values (1,1,12,1,50000,"B",1,2,2000,2,1);

