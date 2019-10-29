/*
	Course: INFS1200 Assignment 2
    Semester 2, 2018
    Author: Minh Anh BUI, 45041899
*/

#use sys;
#The previous line is only used in MySQL

#The constructed tables start here
#Please find below each table creation is the inserted values
SET FOREIGN_KEY_CHECKS=0; 

drop table if exists COUNTRY;
drop table if exists TOURNAMENT;
drop table if exists TEAM;
drop table if exists MEMBER;
drop table if exists HOMECLUB;
drop table if exists SUPPORTSTAFF;
drop table if exists PLAYER;
drop table if exists TEAMMEMBER;
drop table if exists `MATCH`;
drop table if exists POOLGAME;
drop table if exists ELIMINATIONGAME;
drop table if exists GOALS;
drop table if exists SAVES;
drop table if exists CUSTOMER;
drop table if exists TICKET;

create table COUNTRY(
`Name` varchar(100) NOT NULL,
`Population` int NOT NULL,
primary key(`Name`)
);
 
insert into COUNTRY values("Australia", 989264);
insert into COUNTRY values("Korea", 6552356);
insert into COUNTRY values("England", 98956);
insert into COUNTRY values("Iceland", 6566);
insert into COUNTRY values("Japan", 656232);
insert into COUNTRY values("Vietnam", 9597975);
insert into COUNTRY values("Laos", 889563);

create table TOURNAMENT(
`Year` year NOT NULL,
`Country` varchar(100) NOT NULL,
primary key(`Year`),
foreign key(`Country`) references COUNTRY(Name),
check (MOD((`Year`-1930),4) = 0 and `Year` != 1942 and `Year`!= 1946)
);

insert into TOURNAMENT values(2006, "Japan");
insert into TOURNAMENT values(2014, "England");
insert into TOURNAMENT values(1930, "Korea");
insert into TOURNAMENT values(2018, "Australia");
insert into TOURNAMENT values(2010, "Iceland");


create table TEAM(
`Year` year NOT NULL,
`ID` int NOT NULL,
`Country` varchar(100) NOT NULL,
foreign key(`Year`) references TOURNAMENT(`Year`)
on delete restrict,
primary key(`Year`, `ID`),
foreign key(`Country`) references COUNTRY(`Name`)
);

#2010
insert into TEAM values(2010,5, "Japan");
insert into TEAM values(2010,0, "Iceland");
insert into TEAM values(2010,1, "England");
insert into TEAM values(2010,2, "Iceland");
#2018
insert into TEAM values(2018,2, "Iceland");
insert into TEAM values(2018,3, "Korea");
insert into TEAM values(2018,4, "Australia");
insert into TEAM values(2018,5, "Korea");
insert into TEAM values(2018,6, "Japan");

create table MEMBER(
`ID` int NOT NULL,
`Name` varchar(100) NOT NULL,
primary key(`ID`)
);

insert into MEMBER values(0, "Allan Cano");
insert into MEMBER values(1, "Ada Finley");
insert into MEMBER values(2, "Grayson Knox");
insert into MEMBER values(3, "Ed Gale");
insert into MEMBER values(4, "Gabriel Galindo");
insert into MEMBER values(5, "Trevor Lindsey");
insert into MEMBER values(6, "Cassius Stephens");
insert into MEMBER values(7, "Dustin Feeney");
insert into MEMBER values(8, "Princess Mononoke");
insert into MEMBER values(9, "Rodney Perkins
");

create table HOMECLUB(
`Name` varchar(100) NOT NULL,
`Country` varchar(100) NOT NULL,
primary key(`Name`),
foreign key(`Country`) references COUNTRY(`Name`)
);

insert into HOMECLUB values("Awful Opossums", "Australia");
insert into HOMECLUB values("Optimistic Resistance", "Japan");
insert into HOMECLUB values("Day Champs", "Korea");
insert into HOMECLUB values("Savage Turtle", "England");
insert into HOMECLUB values("Viral Queens", "Iceland");

create table SUPPORTSTAFF(
`ID` int NOT NULL,
`Role` varchar(50) NULL,
foreign key(`ID`) references MEMBER(`ID`),
primary key(`ID`),
check (`ID` != PLAYER.`ID`)
);

insert into SUPPORTSTAFF values(5, "Caretaker");
insert into SUPPORTSTAFF values(6, "Supervisor");
insert into SUPPORTSTAFF values(7, "Bodyguard");
insert into SUPPORTSTAFF values(8, "Manager");
insert into SUPPORTSTAFF values(9, "Assistant");

create table PLAYER(
`ID` int NOT NULL,
`Position` varchar(50) NULL,
`HomeClubName` varchar(100) NOT NULL,
foreign key(`HomeClubName`) references HOMECLUB(`Name`),
foreign key(`ID`) references MEMBER(`ID`),
primary key(`ID`)
);

insert into PLAYER values(0, "Defender", "Awful Opossums");
insert into PLAYER values(1, "Goal keeper", "Optimistic Resistance");
insert into PLAYER values(2, "Striker","Day Champs");
insert into PLAYER values(3, "Stopper", "Savage Turtle");
insert into PLAYER values(4, "Midfielder", "Viral Queens");

create table TEAMMEMBER(
`Year` year NOT NULL,
`TeamID` int NOT NULL,
`MemberID` int NOT NULL,
foreign key(`MemberID`) references MEMBER(`ID`),
foreign key(`Year`, `TeamID`) references TEAM(`Year`,`ID`),
primary key(`Year`, `TeamID`, `MemberID`)
);

#player
#2010
insert into TEAMMEMBER values(2010,0,0);
insert into TEAMMEMBER values(2010,1,1);
insert into TEAMMEMBER values(2010,2,2);
#2018
insert into TEAMMEMBER values(2018,2,3);
insert into TEAMMEMBER values(2018,3,4);
insert into TEAMMEMBER values(2018,4,4);
#support staff
insert into TEAMMEMBER values(2018,4,5);
insert into TEAMMEMBER values(2018,4,8);
insert into TEAMMEMBER values(2018,5,5);
insert into TEAMMEMBER values(2018,5,6);
insert into TEAMMEMBER values(2018,5,7);
insert into TEAMMEMBER values(2018,6,8);


create table `MATCH`(
`ID` int NOT NULL,
`Date` date NULL,
`Time` time NULL,
`Stadium` varchar(50) NULL,
`HomeYear` year NOT NULL,
`HomeTeamID` int NOT NULL,
`AwayYear` year NOT NULL,
`AwayTeamID` int NOT NULL,
primary key(`ID`),
foreign key(`HomeYear`, `HomeTeamID`) references TEAM(`Year`, `ID`),
foreign key(`AwayYear`, `AwayTeamID`) references TEAM(`Year`, `ID`)
);

insert into `MATCH` values(0, "2010-01-12", '9:30:00', "Borg El Arab Stadium", 2010, 0, 2010, 1);
insert into `MATCH` values(1, "2010-02-15", '8:25:00', "Bukit Jalil National Stadium", 2010, 0, 2018, 2);
insert into `MATCH` values(2, "2010-03-23", '7:20:00', "Gelora Bung Karno Stadium", 2010, 1, 2010, 2);
insert into `MATCH` values(3, "2010-04-02", '6:10:00', "Wembley Stadium", 2018, 2, 2018, 4);
insert into `MATCH` values(4, "2010-09-09", '12:00:00', "The Rose Bowl", 2018, 3, 2018, 4);
insert into `MATCH` values(5, "2018-05-04", '6:10:00', "FNB Stadium", 2018, 2, 2018, 4);
insert into `MATCH` values(6, "2018-09-17", '12:00:00', "Azadi Stadium", 2018, 3, 2018, 4);
insert into `MATCH` values(7, "2018-11-23", '6:10:00', "Estadio Azteca", 2018, 2, 2018, 4);
insert into `MATCH` values(8, "2018-05-09", '12:00:00', "Camp Nou", 2018, 3, 2018, 4);
insert into `MATCH` values(9, "2018-12-31", '6:10:00', "Rungrado May Day Stadium", 2018, 2, 2018, 4);

create table POOLGAME(
`ID` int NOT NULL,
foreign key(`ID`) references `MATCH`(`ID`),
primary key(`ID`)
);

insert into POOLGAME values(0);
insert into POOLGAME values(1);
insert into POOLGAME values(7);
insert into POOLGAME values(8);
insert into POOLGAME values(9);

create table ELIMINATIONGAME(
`ID` int NOT NULL,
`Stage` varchar(50) Null,
`HomePenalties` int not null,
`AwayPenalties` int not null,
foreign key(`ID`) references `MATCH`(`ID`),
primary key(`ID`),
check(`ID` != POOLGAME(`ID`))
);

insert into ELIMINATIONGAME values(0, null, 2,3);
insert into ELIMINATIONGAME values(1, null, 6,4);
insert into ELIMINATIONGAME values(2, null, 3,7);
insert into ELIMINATIONGAME values(5, null, 1,3);
insert into ELIMINATIONGAME values(6, null, 4,5);

create table GOALS(
`PlayerID` int NOT NULL,
`MatchID` int NOT NULL,
`Count` int Not NULL,
foreign key(`PlayerID`) references PLAYER(`ID`),
foreign key(`MatchID`) references `MATCH`(`ID`),
primary key(`PlayerID`, `MatchID`)
);

insert into GOALS values(0,0, 2);
insert into GOALS values(0,1, 5);
insert into GOALS values(1,2, 3);
insert into GOALS values(3,3, 4);
insert into GOALS values(4,4, 1);

create table SAVES(
`PlayerID` int NOT NULL,
`MatchID` int NOT NULL,
`Count` int not NULL,
foreign key(`PlayerID`) references PLAYER(`ID`),
foreign key(`MatchID`) references `MATCH`(`ID`),
primary key(`PlayerID`, `MatchID`)
);

insert into SAVES values(0,0, 2);
insert into SAVES values(1,1, 3);
insert into SAVES values(2,2, 4);
insert into SAVES values(3,3, 2);

create table CUSTOMER(
`ID` int NOT NULL, 
`Name` varchar(100) NOT NULL,
`Email` varchar(200) NOT NULL,
`CountryName` varchar(100) NOT NULL,
primary key(`ID`),
foreign key(`CountryName`) references COUNTRY(`Name`)
);

insert into CUSTOMER values(0, "Bodhi Bauer", "a.gmail", "Australia");
insert into CUSTOMER values(1, "Tate Richardson", "b.gmail", "England");
insert into CUSTOMER values(2, "Jody Park", "c.gmail", "Korea");
insert into CUSTOMER values(3, "Ayub Johnson", "d.gmail", "Japan");
insert into CUSTOMER values(4, "Kaine Abbott", "e.gmail", "Iceland");

create table TICKET(
`MatchID` int NOT NULL,
`Ticket#` int NOT NULL,
`CustomerID` int NOT NULL,
`Price` int NULL,
foreign key(`CustomerID`) references CUSTOMER(`ID`)
on delete cascade,
foreign key(`MatchID`) references `MATCH`(`ID`)
on delete cascade,
primary key(`MatchID`, `Ticket#`)
);

insert into TICKET values(0,0,0,20);
insert into TICKET values(1,1,1,60);
insert into TICKET values(2,2,2,70);
insert into TICKET values(2,3,2,70);
insert into TICKET values(4,3,3,100);
insert into TICKET values(4,4,4,90);
insert into TICKET values(4,5,4,90);



#The views constructed starts here
#1. Find all the Australian Players that played in the 2018 World Cup

drop view if exists Q1;
create view Q1(`ID`, `Name`) as
select p.`ID`, m.`Name`
from PLAYER p, MEMBER m, TEAM t, TEAMMEMBER tm
where t.`Country`="Australia" 
and tm.`Year`=2018
and tm.`TeamID`=t.`ID`
and tm.`MemberID`=m.`ID`
and p.`ID`=m.`ID`;

select * from Q1;

#2. Find the players that have never scored a goal

drop view if exists Q2;
create view Q2 as
select  p.`ID`, m.`Name`
from PLAYER p, MEMBER m
where p.`ID` = m.`ID`
and p.`ID` not in(
	select `PlayerID`
    from GOALS);

select * from Q2;

#3. Find all the pool games played by host countries

drop view if exists Q3;
create view Q3 as
select tnm.`Country`, m.*
from POOLGAME pg, `MATCH` m, TOURNAMENT tnm, TEAM t
where pg.`ID`=m.`ID`
and t.`Country`=tnm.`Country`
and m.`HomeYear`=t.`Year`
and t.`Year`=tnm.`Year` 
and m.`HomeTeamID`=t.`ID`
union
select tnm.`Country`, m.*
from POOLGAME pg, `MATCH` m, TOURNAMENT tnm, TEAM t
where pg.`ID`=m.`ID`
and t.`Country`=tnm.`Country`
and m.`AwayYear`=t.`Year`
and t.`Year`=tnm.`Year`
and m.`AwayTeamID`=t.`ID`;

select * from Q3;


#4. Find all the australian players linked to an English club team

drop view if exists Q4;
create view Q4 as
select p.`ID`, m.`Name`, p.`Position`, p.`HomeClubName`, hc.`Country`
from PLAYER p, MEMBER m, HOMECLUB hc
where p.`ID` = m.`ID`
and p.`HomeClubName` = hc.`Name`
and hc.`Country` = "England";

select * from Q4;

#5. Rank the teams by the number of supportstaff attending the 2018 World Cup

drop view if exists Q5;
create view Q5 as
select t.`Year`, t.`ID`, t.`Country`, Count(ss.`ID`) as `Number of support staffs`
from TEAM t, SUPPORTSTAFF ss, TEAMMEMBER tm
where ss.`ID` = tm.`MemberID`
and t.`ID`=tm.`TeamID`
and t.`Year`=2018
group by t.`ID`;

select * from Q5;

#6. Find the names & number of goals saved by all players

drop view if exists Q6;
create view Q6 as
select m.`Name`, sum(s.`Count`) as `Number of goals saved`
from PLAYER p, MEMBER m, SAVES s
where p.`ID`=m.`ID`
and p.`ID`= s.`PlayerID`
group by m.`Name`
union
select m.`Name`, 0 as `Number of goals saved`
from PLAYER p, MEMBER m
where p.`ID`=m.`ID`
and p.`ID` not in (
	select `PlayerID` 
    from SAVES);
    
select * from Q6;

#7. Find the game that sold the most tickets

drop view if exists Q7;
create view Q7 as
select m.*, count(t.`Ticket#`) as `Number of tickets sold`
from `MATCH` m, TICKET t
where m.`ID`=t.`MatchID`
group by m.`ID`
having count(t.`Ticket#`) >= all (
	(select count(t.`Ticket#`)
    from TICKET t
    group by `MatchID`))
;

select * from Q7;

#8. Find the player who scored the most goals in elimination games

drop view if exists Q8;
create view Q8 as
select p.`ID`, m.`Name`, sum(g.`Count`) as `Number of goals scored`
from PLAYER p, MEMBER m, GOALS g, ELIMINATIONGAME eg
where p.`ID`=m.`ID`
and p.`ID`=g.`PlayerID`
and g.`MatchID` = eg.`ID`
group by `PlayerID`
having sum(g.`Count`) >= all(
	(select sum(`Count`)
    from GOALS
    group by `PlayerID`));
    
select * from Q8;

#9. Find countries that have played in all World Cups

drop view if exists Q9;
create view Q9 as
select distinct c.*
from COUNTRY c, TEAM t 
where c.`Name`=t.`Country`
and not exists(
	select *
    from TEAM 
    where `Year` not in(
		select `Year`
        from TOURNAMENT));

select * from Q9;

#10. Find players who have scored in all of Iceland’s games

drop view if exists Q10;
create view Q10 as
select p.`ID`, m.`Name`, sum(g.`Count`) as `Number of goals scored`
from PLAYER p, MEMBER m, GOALS g
where p.`ID`=m.`ID`
and p.`ID`=g.`PlayerID`
and g.`MatchID` in(
	select a.`ID`
    from `MATCH` a, TEAM b
    where a.`HomeTeamID`=b.`ID`
    and a.`HomeYear`=b.`Year`
    and b.`Country`="Iceland"
    union
	select a.`ID`
    from `MATCH` a, TEAM b
    where a.`AwayTeamID`=b.`ID`
    and a.`AwayYear`=b.`Year`
    and b.`Country`="Iceland")
group by p.`ID`
;

select * from Q10;

