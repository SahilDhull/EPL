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

select * from club_player where player_id=1;

select * from match where match_id=1;
select * from player_stats where player_id in (1,2);

select * from season_chart;

update match set status='Finished' where match_id = 1;
select * from player_stats where clean_sheet>0;
update match set status='Finished' where match_id = 2;
update match set status='Finished' where match_id = 3;
select * from match where match_id in (1,2);

-- select * from club_stats;
-- update season set status='Finished' where season_id = 1;

select * from season_champion;

select * from player_stats where clean_sheet>0;




select B.PLAYER_ID from LINEUP as B where B.POSITION = 'GK' AND (B.CLUB_ID,B.MATCH_ID) IN 	( select A.AWAY_CLUB,A.MATCH_ID from (MATCH natural join PLAYING_CLUBS) as A where	A.MATCH_ID = 2);