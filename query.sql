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
