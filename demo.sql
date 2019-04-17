-- Match 6 inserted
.headers on
.mode column
insert into MATCH(MATCH_ID,MATCH_DATE,AUDIENCE,HOME_FORMATION,AWAY_FORMATION,STATUS)
	values(6,'2017/09/15',45802,'3-5-2','5-3-2',"Ongoing");

insert into lineup(CLUB_ID,MATCH_ID,PLAYER_ID,isSUB,SUB_PLAYED,POSITION)values(3,6,38,0,0,"GK");
insert into lineup(CLUB_ID,MATCH_ID,PLAYER_ID,isSUB,SUB_PLAYED,POSITION)values(3,6,39,0,0,"LB");
insert into lineup(CLUB_ID,MATCH_ID,PLAYER_ID,isSUB,SUB_PLAYED,POSITION)values(3,6,40,0,0,"CB");
insert into lineup(CLUB_ID,MATCH_ID,PLAYER_ID,isSUB,SUB_PLAYED,POSITION)values(3,6,41,0,0,"CB");
insert into lineup(CLUB_ID,MATCH_ID,PLAYER_ID,isSUB,SUB_PLAYED,POSITION)values(3,6,42,0,0,"RB");
insert into lineup(CLUB_ID,MATCH_ID,PLAYER_ID,isSUB,SUB_PLAYED,POSITION)values(3,6,43,0,0,"CDM");
insert into lineup(CLUB_ID,MATCH_ID,PLAYER_ID,isSUB,SUB_PLAYED,POSITION)values(3,6,44,0,0,"CM");
insert into lineup(CLUB_ID,MATCH_ID,PLAYER_ID,isSUB,SUB_PLAYED,POSITION)values(3,6,45,0,0,"CM");
insert into lineup(CLUB_ID,MATCH_ID,PLAYER_ID,isSUB,SUB_PLAYED,POSITION)values(3,6,46,0,0,"LM");
insert into lineup(CLUB_ID,MATCH_ID,PLAYER_ID,isSUB,SUB_PLAYED,POSITION)values(3,6,47,0,0,"RM");
insert into lineup(CLUB_ID,MATCH_ID,PLAYER_ID,isSUB,SUB_PLAYED,POSITION)values(3,6,48,0,0,"ST");
insert into lineup(CLUB_ID,MATCH_ID,PLAYER_ID,isSUB,SUB_PLAYED,POSITION)values(3,6,49,1,0,"ST");
insert into lineup(CLUB_ID,MATCH_ID,PLAYER_ID,isSUB,SUB_PLAYED,POSITION)values(3,6,50,1,0,"ST");
insert into lineup(CLUB_ID,MATCH_ID,PLAYER_ID,isSUB,SUB_PLAYED,POSITION)values(3,6,51,1,1,"ST");
insert into lineup(CLUB_ID,MATCH_ID,PLAYER_ID,isSUB,SUB_PLAYED,POSITION)values(3,6,52,1,0,"ST");
insert into lineup(CLUB_ID,MATCH_ID,PLAYER_ID,isSUB,SUB_PLAYED,POSITION)values(3,6,53,1,0,"ST");
insert into lineup(CLUB_ID,MATCH_ID,PLAYER_ID,isSUB,SUB_PLAYED,POSITION)values(3,6,54,1,1,"ST");
insert into lineup(CLUB_ID,MATCH_ID,PLAYER_ID,isSUB,SUB_PLAYED,POSITION)values(3,6,55,1,1,"ST");

insert into lineup(CLUB_ID,MATCH_ID,PLAYER_ID,isSUB,SUB_PLAYED,POSITION)values(2,6,19,0,0,"GK");
insert into lineup(CLUB_ID,MATCH_ID,PLAYER_ID,isSUB,SUB_PLAYED,POSITION)values(2,6,20,0,0,"LB");
insert into lineup(CLUB_ID,MATCH_ID,PLAYER_ID,isSUB,SUB_PLAYED,POSITION)values(2,6,21,0,0,"CB");
insert into lineup(CLUB_ID,MATCH_ID,PLAYER_ID,isSUB,SUB_PLAYED,POSITION)values(2,6,22,0,0,"CB");
insert into lineup(CLUB_ID,MATCH_ID,PLAYER_ID,isSUB,SUB_PLAYED,POSITION)values(2,6,23,0,0,"RB");
insert into lineup(CLUB_ID,MATCH_ID,PLAYER_ID,isSUB,SUB_PLAYED,POSITION)values(2,6,24,0,0,"CDM");
insert into lineup(CLUB_ID,MATCH_ID,PLAYER_ID,isSUB,SUB_PLAYED,POSITION)values(2,6,25,0,0,"CM");
insert into lineup(CLUB_ID,MATCH_ID,PLAYER_ID,isSUB,SUB_PLAYED,POSITION)values(2,6,26,0,0,"CM");
insert into lineup(CLUB_ID,MATCH_ID,PLAYER_ID,isSUB,SUB_PLAYED,POSITION)values(2,6,27,0,0,"LM");
insert into lineup(CLUB_ID,MATCH_ID,PLAYER_ID,isSUB,SUB_PLAYED,POSITION)values(2,6,29,0,0,"RM");
insert into lineup(CLUB_ID,MATCH_ID,PLAYER_ID,isSUB,SUB_PLAYED,POSITION)values(2,6,30,0,0,"ST");
insert into lineup(CLUB_ID,MATCH_ID,PLAYER_ID,isSUB,SUB_PLAYED,POSITION)values(2,6,31,1,0,"ST");
insert into lineup(CLUB_ID,MATCH_ID,PLAYER_ID,isSUB,SUB_PLAYED,POSITION)values(2,6,32,1,0,"ST");
insert into lineup(CLUB_ID,MATCH_ID,PLAYER_ID,isSUB,SUB_PLAYED,POSITION)values(2,6,33,1,1,"ST");
insert into lineup(CLUB_ID,MATCH_ID,PLAYER_ID,isSUB,SUB_PLAYED,POSITION)values(2,6,34,1,0,"ST");
insert into lineup(CLUB_ID,MATCH_ID,PLAYER_ID,isSUB,SUB_PLAYED,POSITION)values(2,6,35,1,1,"ST");
insert into lineup(CLUB_ID,MATCH_ID,PLAYER_ID,isSUB,SUB_PLAYED,POSITION)values(2,6,36,1,0,"ST");
insert into lineup(CLUB_ID,MATCH_ID,PLAYER_ID,isSUB,SUB_PLAYED,POSITION)values(2,6,37,1,0,"ST");

insert into PLAYING_CLUBS(MATCH_ID,HOME_CLUB,AWAY_CLUB)
	values(6,3,2);

insert into MATCH_REFEREE(MATCH_ID,MAIN_REFEREE,ASST1,ASST2,FOURTH_OFFICIAL) 
	values(6,2,3,7,5);

select "Match 6 just started";
select * from MATCH where MATCH_ID=6;

select "Player Stats:";
select * from player_stats where PLAYER_ID in (31,28,29,30,19,38);

insert into GOALS
	(MATCH_ID,PLAYER_ID,CLUB_ID,GOAL_TIME,EXTRATIME,ASSIST_BY,OWN_GOAL)
  values
  (6,31,2,1,0,null,0),
  (6,28,2,10,0,29,0);

select "Match 6 Goal Update";
select * from MATCH where MATCH_ID=6;

select "Player Stats:";
select * from player_stats where PLAYER_ID in (31,28,29,30);

insert into booking(MATCH_ID,PLAYER_ID,BOOKING_TYPE,BOOKING_TIME)
	values
	(6,30,'Y',7),
	(6,30,'Y',15);

select "Player Stats after 2 yellow cards:";
select * from player_stats where PLAYER_ID in (31,28,29,30);



insert into substitution(SUBSTITUTION_COUNT,MATCH_ID,CLUB_ID,PLAYER_IN,PLAYER_OUT,STIME,PHASE)
	values(1,6,2,21,35,79,2);
insert into substitution(SUBSTITUTION_COUNT,MATCH_ID,CLUB_ID,PLAYER_IN,PLAYER_OUT,STIME,PHASE)
	values(1,6,3,42,51,55,2);

select "Current lineup : ";
select * from lineup where PLAYER_ID in (42,51) and MATCH_ID=6;

select "Club Stats : ";
select * from club_stats;


select "<--------------- Match 6 Complete ---------------->";
update match set STATUS = 'Finished' where STATUS = 'Ongoing';

select "Season Charts";
select * from season_chart;

select "Player Stats (Clean sheets for goalkeepers :";
select * from player_stats where PLAYER_ID in (19,38);

select "Club Stats : ";
select * from club_stats;

select "Season Champion : ";
select * from season_champion;

select "Entering New Season ";
insert into season(season_id,status) values(2,"Ongoing");

select "Players in Season 2 : ";
select * from player_stats where season_id = 2 and PLAYER_ID = 35;

insert into transfer(PLAYER_ID,SEASON_ID,ARRIVING_CLUB,DEPARTING_CLUB,TRANSFER_AMOUNT,TRANSFER_TYPE,CONTRACT_START,CONTRACT_TILL,SALARY,JERSEY_NO,BUYOUT_CLAUSE)
	values(35,2,1,3,5000000,'B',2,5,100000,10,2000000);

select * from club_player where PLAYER_ID = 35;