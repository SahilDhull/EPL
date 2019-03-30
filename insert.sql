.headers on
.mode column

PRAGMA foreign_keys=ON;

insert into club(ABBR,CLUB_NAME,CLUB_CITY,OWNER,MANAGER)
	values("LIV","Liverpool","Liverpool","Ankit","Bismay");

insert into match(MATCH_DATE,HOME_CLUB_ID,AWAY_CLUB_ID)
	values('2019-03-30',1,1);