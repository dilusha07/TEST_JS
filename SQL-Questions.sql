/* 
3.1 Create “user” table and Insert the data into the table
*/

CREATE TABLE "user" (
	id int, 
	firstName varchar(255), 
	lastName varchar(255), 
	email varchar(255), 
	cultureID int, 
	deleted bit, 
	country varchar(255), 
	isRevokeAccess bit, 
	created datetime  
);

INSERT INTO "user"
VALUES 
(1, 'Victor', 'Shevchenko', 'vs@ gmail.com', 1033, 1, 'US', 0, '2011-04-05'), 
(2, 'Oleksandr', 'Petrenko', 'op@ gmail.com', 1034, 0, 'UA', 0, '2014-05-01'), 
(3, 'Victor', 'Tarasenko', 'vt@gmail.com', 1033, 1, 'US', 1, '2015-07-03'), 
(4, 'Sergiy', 'Ivanenko', 'sergiy@gmail.com', 1046, 0, 'UA', 1, '2010-02-02'), 
(5, 'Vitalii', 'Danilchenko', 'shumko@ gmail.com', 1031, 0, 'UA', 1, '2014-05-01'), 
(6, 'Joe', 'Dou', 'joe@ gmail.com', 1032, 0, 'US', 1, '2009-01-01'), 
(7, 'Marko', 'Polo', 'marko@gmail.com', 1033, 1, 'UA', 1, '2015-07-03');

/* 
3.1 Create “group” table and Insert the data into the table
*/

CREATE TABLE "group" (
	id int, 
	name varchar(255), 
	created datetime
);

INSERT INTO "group"
VALUES
(10, 'Support', '2010-02-02'), 
(12, 'Dev team', '2010-02-03'), 
(13, 'Apps team', '2011-05-06'), 
(14, 'TEST - dev team', '2013-05-06'), 
(15, 'Guest', '2014-02-02'), 
(16, 'TEST-QA-team', '2014-02-02'), 
(17, 'TEST-team', '2011-01-07');

/* 
3.1 Create “groupMembership” table and Insert the data into the table
*/

CREATE TABLE groupMembership (
	id int, 
 	userID int, 
    groupID int, 
    created datetime
);

INSERT INTO groupMembership
VALUES
(110, 2, 10, '2010-02-02'), 
(112, 3, 15, '2010-02-03'), 
(114, 1, 10, '2014-02-02'), 
(115, 1, 17, '2011-05-02'), 
(117, 4, 12, '2014-07-13'), 
(120, 5, 15, '2014-06-15');


/* 
3.2 Select names of all empty test groups (group name starts with “TEST-”).
*/

SELECT G.name
FROM "group" AS G
LEFT JOIN groupMembership AS GM ON g.id = GM.groupID
WHERE G.name LIKE 'TEST-%' AND GM.userID IS NULL;


/* 
3.3 Select user first names and last names for the users that have Victor as a first name and are not 
members of any test groups (they may be members of other groups or have no membership in 
any groups at all). 
*/


SELECT U.firstName, U.lastName
FROM "user" AS U
WHERE U.firstName = 'Victor'
  AND U.id NOT IN (
      SELECT GM.userID
      FROM groupMembership GM
      INNER JOIN "group" G ON GM.groupID = G.id
      WHERE G.name LIKE 'TEST-%'
  );


/* 
3.4 Select users and groups for which user was created before the group for which he(she) is 
member of. 
*/

SELECT U.firstName, U.lastName, G.name AS GroupName
FROM "user" AS U 
INNER JOIN groupMembership AS GM ON u.id = GM.userID
INNER JOIN "group" AS G ON GM.groupID = GM.id
WHERE U.created < G.created;
