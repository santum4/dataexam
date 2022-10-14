

/* HW3_Mukherjee_Santanu*/

/* This is the SQl Query file for HW3 */

/* Problem 65.	Write the SQL code to create the table structures for the entities shown in Figure P7.65.*/
/* Problem 66.	Write the INSERT commands necessary to place the following data in the tables that were created in Problem 65.*/

/* The following statements drops the tables that will be used to later create and run queries */

DROP TABLE DETAILRENTAL;
DROP TABLE RENTAL;
DROP TABLE VIDEO;
DROP TABLE MOVIE;
DROP TABLE PRICE;
DROP TABLE MEMBERSHIP;


-- The folowing statement creates the parent table (Membership table)


CREATE TABLE MEMBERSHIP (
 MEM_NUM     	INTEGER     	PRIMARY KEY,
 MEM_FNAME     	VARCHAR(35) 	NOT NULL,
 MEM_LNAME     	VARCHAR(35) 	NOT NULL,
 MEM_STREET  	VARCHAR(50) 	NOT NULL,
 MEM_CITY	  	VARCHAR(35) 	NOT NULL,
 MEM_STATE    	CHAR(2)     	NOT NULL,
 MEM_ZIP	 	CHAR(5)     	NOT NULL,
 MEM_BALANCE   	NUMERIC(10,2)  	NOT NULL);
 


 -- Inserting data into the MEMBERSHIP table

INSERT INTO MEMBERSHIP VALUES (102, 'TAMI', 'DAWSON', '2632 TAKLI CIRCLE', 'NORENE', 'TN', '37136', 11);
INSERT INTO MEMBERSHIP VALUES (103, 'CURT', 'KNIGHT', '4025 CORNELL COURT', 'FLATGAP', 'KY', '41219', 6);
INSERT INTO MEMBERSHIP VALUES (104, 'JAMAL', 'MELENDEZ', '788 EAST 145TH AVENUE', 'QUEBECK', 'TN', '38579', 0);
INSERT INTO MEMBERSHIP VALUES (105, 'IVA', 'MCCLAIN', '6045 MUSKET BALL CIRCLE', 'SUMMIT', 'KY', '42783', 15);
INSERT INTO MEMBERSHIP VALUES (106, 'MIRANDA', 'PARKS', '4469 MAXWELL PLACE', 'GERMANTOWN', 'TN', '38183', 0);
INSERT INTO MEMBERSHIP VALUES (107, 'ROSARIO', 'ELLIOTT', '7578 DANNER AVENUE', 'COLUMBIA', 'TN', '38402', 5);
INSERT INTO MEMBERSHIP VALUES (108, 'MATTIE', 'GUY', '4390 EVERGREEN STREET', 'LILY', 'KY', '40740', 0);
INSERT INTO MEMBERSHIP VALUES (109, 'CLINT', 'OCHOA', '1711 ELM STREET', 'GREENEVILLE', 'TN', '37745', 10);
INSERT INTO MEMBERSHIP VALUES (110, 'LEWIS', 'ROSALES', '4524 SOUTHWIND CIRCLE', 'COUNCE', 'TN', '38326', 0);
INSERT INTO MEMBERSHIP VALUES (111, 'STACY', 'MANN', '2789 EAST COOK AVENUE', 'MURFREESBORO', 'TN', '37132', 8);
INSERT INTO MEMBERSHIP VALUES (112, 'LUIS', 'TRUJILLO', '7267 MELVIN AVENUE', 'HEISKELL', 'TN', '37754', 3);
INSERT INTO MEMBERSHIP VALUES (113, 'MINNIE', 'GONZALES', '6430 VASILI DRIVE', 'WILLISTON', 'TN', '38076', 0);

SELECT * FROM MEMBERSHIP;






-- The folowing statement creates another parent table (PRICE table)


CREATE TABLE PRICE (
PRICE_CODE       	INTEGER PRIMARY KEY,
PRICE_DESCRIPTION  	VARCHAR(25) NOT NULL,
PRICE_RENTFEE       NUMERIC(3,1) NOT NULL,
PRICE_DAILYLATEFEE 	NUMERIC(3,1) NOT NULL);

-- Inserting data into the PRICE table

INSERT INTO PRICE VALUES (1, 'Standard', 2, 1);
INSERT INTO PRICE VALUES (2, 'New Release', 3.5, 3);
INSERT INTO PRICE VALUES (3, 'Discount', 1.5, 1);
INSERT INTO PRICE VALUES (4, 'Weekly Special', 1, .5);

SELECT * FROM PRICE;


-- The folowing statement creates another table (RENTAL table)


 CREATE TABLE RENTAL (
 RENT_NUM    	INTEGER 	PRIMARY KEY ,
 RENT_DATE 		DATE NOT NULL,
 MEM_NUM      	INTEGER NOT NULL,
 FOREIGN KEY (MEM_NUM) REFERENCES MEMBERSHIP ON UPDATE CASCADE);

-- Inserting data into the RENTAL table

INSERT INTO RENTAL VALUES (1001, '01-MAR-13', 103);
INSERT INTO RENTAL VALUES (1002, '01-MAR-13', 105);
INSERT INTO RENTAL VALUES (1003, '02-MAR-13', 102);
INSERT INTO RENTAL VALUES (1004, '02-MAR-13', 110);
INSERT INTO RENTAL VALUES (1005, '02-MAR-13', 111);
INSERT INTO RENTAL VALUES (1006, '02-MAR-13', 107);
INSERT INTO RENTAL VALUES (1007, '02-MAR-13', 104);
INSERT INTO RENTAL VALUES (1008, '03-MAR-13', 105);
INSERT INTO RENTAL VALUES (1009, '03-MAR-13', 111);


SELECT * FROM RENTAL;


-- The folowing statement creates another table (MOVIE table)


 CREATE TABLE MOVIE (
 MOVIE_NUM    	INTEGER 	PRIMARY KEY ,
 MOVIE_TITLE   	VARCHAR(75) 	NOT NULL,
 MOVIE_YEAR		INTEGER NOT NULL,
 MOVIE_COST     NUMERIC(7,2) NOT NULL,
 MOVIE_GENRE   	VARCHAR(35) NOT NULL,
 PRICE_CODE    	INTEGER ,
 FOREIGN KEY (PRICE_CODE) REFERENCES PRICE ON UPDATE CASCADE);


 -- Inserting data into the MOVIE table


INSERT INTO MOVIE VALUES (1234, 'The Cesar Family Christmas', 2011, 39.95, 'FAMILY', 2);
INSERT INTO MOVIE VALUES (1235, 'Smokey Mountain Wildlife', 2008, 59.95, 'ACTION', 1);
INSERT INTO MOVIE VALUES (1236, 'Richard Goodhope', 2012, 59.95, 'DRAMA', 2);
INSERT INTO MOVIE VALUES (1237, 'Beatnik Fever', 2011, 29.95, 'COMEDY', 2);
INSERT INTO MOVIE VALUES (1238, 'Constant Companion', 2012, 89.95, 'DRAMA', NULL);
INSERT INTO MOVIE VALUES (1239, 'Where Hope Dies', 2002, 25.49, 'DRAMA', 3);
INSERT INTO MOVIE VALUES (1245, 'Time to Burn', 2009, 45.49, 'ACTION', 1);
INSERT INTO MOVIE VALUES (1246, 'What He Doesn''t Know', 2010, 58.29, 'COMEDY', 1);

SELECT * FROM MOVIE;



-- The folowing statement creates another table (VIDEO table)


CREATE TABLE VIDEO (
 VID_NUM    	INTEGER 	PRIMARY KEY ,
 VID_INDATE		DATE NOT NULL,
 MOVIE_NUM    	INTEGER NOT NULL,
 FOREIGN KEY (MOVIE_NUM) REFERENCES MOVIE ON UPDATE CASCADE);

 -- Inserting data into the VIDEO table

INSERT INTO VIDEO VALUES (34341, '22-JAN-11', 1235);
INSERT INTO VIDEO VALUES (34342, '22-JAN-11', 1235);
INSERT INTO VIDEO VALUES (34366, '02-MAR-13', 1236);
INSERT INTO VIDEO VALUES (34367, '02-MAR-13', 1236);
INSERT INTO VIDEO VALUES (34368, '02-MAR-13', 1236);
INSERT INTO VIDEO VALUES (34369, '02-MAR-13', 1236);
INSERT INTO VIDEO VALUES (44392, '21-OCT-12', 1237);
INSERT INTO VIDEO VALUES (44397, '21-OCT-12', 1237);
INSERT INTO VIDEO VALUES (54321, '18-JUN-12', 1234);
INSERT INTO VIDEO VALUES (54324, '18-JUN-12', 1234);
INSERT INTO VIDEO VALUES (54325, '18-JUN-12', 1234);
INSERT INTO VIDEO VALUES (59237, '14-FEB-13', 1237);
INSERT INTO VIDEO VALUES (61353, '28-JAN-10', 1245);
INSERT INTO VIDEO VALUES (61354, '28-JAN-10', 1245);
INSERT INTO VIDEO VALUES (61367, '30-JUL-12', 1246);
INSERT INTO VIDEO VALUES (61369, '30-JUL-12', 1246);
INSERT INTO VIDEO VALUES (61388, '25-JAN-11', 1239);


SELECT * FROM VIDEO;


-- The folowing statement creates another table (DETAILRENTAL table)


 CREATE TABLE DETAILRENTAL (
 RENT_NUM    			INTEGER 	NOT NULL,
 VID_NUM    			INTEGER 	NOT NULL,
 DETAIL_FEE				NUMERIC(4,1) DEFAULT 0 NOT NULL,
 DETAIL_DUEDATE			DATE NOT NULL,
 DETAIL_RETURNDATE		DATE ,
 DETAIL_DAILYLATEFEE	NUMERIC(4,1),
 PRIMARY KEY (RENT_NUM,VID_NUM),
 FOREIGN KEY (RENT_NUM) REFERENCES RENTAL ON DELETE CASCADE,
 FOREIGN KEY (VID_NUM) REFERENCES VIDEO ON DELETE CASCADE);
 

 -- Inserting data into the DETAILRENTAL table


INSERT INTO DETAILRENTAL VALUES (1001, 34342, 2, '04-MAR-13', '02-MAR-13', NULL);
INSERT INTO DETAILRENTAL VALUES (1001, 34366, 3.5, '04-MAR-13', '02-MAR-13', 3);
INSERT INTO DETAILRENTAL VALUES (1001, 61353, 2, '04-MAR-13', '03-MAR-13', 1);
INSERT INTO DETAILRENTAL VALUES (1002, 59237, 3.5, '04-MAR-13', '04-MAR-13', 3);
INSERT INTO DETAILRENTAL VALUES (1003, 54325, 3.5, '04-MAR-13', '09-MAR-13', 3);
INSERT INTO DETAILRENTAL VALUES (1003, 61369, 2, '06-MAR-13', '09-MAR-13', 1);
INSERT INTO DETAILRENTAL VALUES (1003, 61388, 0, '06-MAR-13', '09-MAR-13', 1);
INSERT INTO DETAILRENTAL VALUES (1004, 34341, 2, '07-MAR-13', '07-MAR-13', 1);
INSERT INTO DETAILRENTAL VALUES (1004, 34367, 3.5, '05-MAR-13', '07-MAR-13', 3);
INSERT INTO DETAILRENTAL VALUES (1004, 44392, 3.5, '05-MAR-13', '07-MAR-13', 3);
INSERT INTO DETAILRENTAL VALUES (1005, 34342, 2, '07-MAR-13', '05-MAR-13', 1);
INSERT INTO DETAILRENTAL VALUES (1005, 44397, 3.5, '05-MAR-13', '05-MAR-13', 3);
INSERT INTO DETAILRENTAL VALUES (1006, 34366, 3.5, '05-MAR-13', '04-MAR-13', 3);
INSERT INTO DETAILRENTAL VALUES (1006, 61367, 2, '07-MAR-13', NULL, 1);
INSERT INTO DETAILRENTAL VALUES (1007, 34368, 3.5, '05-MAR-13', NULL, 3);
INSERT INTO DETAILRENTAL VALUES (1008, 34369, 3.5, '05-MAR-13', '05-MAR-13', 3);
INSERT INTO DETAILRENTAL VALUES (1009, 54324, 3.5, '05-MAR-13', NULL, 3);


 SELECT * FROM DETAILRENTAL;


 /* Problem 67 - Skipped.	Write the INSERT commands necessary to place the following data in the tables that were created in Problem 65.*/

 /* Problem 68.	Write the SQL command to change the movie year for movie number 1245 to 2010.*/

SELECT MOVIE_NUM, MOVIE_YEAR FROM MOVIE WHERE MOVIE_NUM = 1245;

UPDATE MOVIE SET MOVIE_YEAR = 2010 WHERE MOVIE_NUM = 1245;

SELECT MOVIE_NUM, MOVIE_YEAR FROM MOVIE WHERE MOVIE_NUM = 1245;


 /* Problem 69.	Write the SQL command to change the price code for all Action movies to price code 3.*/

SELECT MOVIE_NUM, MOVIE_GENRE, PRICE_CODE FROM MOVIE WHERE UPPER(MOVIE_GENRE) = 'ACTION';

UPDATE MOVIE SET PRICE_CODE = 3 WHERE UPPER(MOVIE_GENRE) = 'ACTION';

SELECT MOVIE_NUM, MOVIE_GENRE, PRICE_CODE FROM MOVIE WHERE UPPER(MOVIE_GENRE) = 'ACTION';


 /* Problem 70.	Write a single SQL command to increase all price rental fee values by $0.50.*/


SELECT * FROM PRICE;

UPDATE PRICE SET PRICE_RENTFEE = PRICE_RENTFEE + 0.5;

SELECT * FROM PRICE;

 /* Problem 71 SKIPPED.	Write the SQL command to save the changes made to the PRICE and MOVIE tables in Problems 67 – 70. (skip this question).*/

 /* Problem 72.	Write a query to display the movie title, movie year, and movie genre for all movies (result shown in Figure P7.72).*/

	SELECT MOVIE_TITLE, MOVIE_YEAR, MOVIE_GENRE  FROM MOVIE;


  /* Problem 73. Write a query to display the movie year, movie title, and movie cost sorted by movie year in descending order (result shown in Figure P7.73).*/

  --SELECT MOVIE_YEAR, MOVIE_TITLE, MOVIE_COST FROM MOVIE ORDER BY MOVIE_YEAR DESC;
  
  SELECT MOVIE_YEAR, MOVIE_TITLE, MOVIE_COST FROM MOVIE ORDER BY MOVIE_YEAR DESC, MOVIE_NUM DESC;
  

  /* Problem 74. Write a query to display the movie title, movie year, and movie genre for all movies sorted by movie genre in ascending order, then sorted by movie year in descending order within genre (result shown in Figure P7.74).*/

  SELECT MOVIE_TITLE, MOVIE_YEAR, MOVIE_GENRE FROM MOVIE ORDER BY MOVIE_GENRE ASC, MOVIE_YEAR DESC;


  /* Problem 75. Write a query to display the movie number, movie title, and price code for all movies with a title that starts with the letter “R” (result shown in Figure P7.75).*/

  SELECT MOVIE_NUM, MOVIE_TITLE, PRICE_CODE FROM MOVIE WHERE UPPER(MOVIE_TITLE) LIKE 'R%';


  /* Problem 76. Write a query to display the movie title, movie year, and movie cost for all movies that contain the word “hope” anywhere in the title.  Sort the results in ascending order by title (result shown in figure P7.76).*/

    SELECT MOVIE_TITLE, MOVIE_YEAR, MOVIE_COST FROM MOVIE WHERE UPPER(MOVIE_TITLE) LIKE '%HOPE%' ORDER BY MOVIE_TITLE ASC;


  /* Problem 77. Write a query to display the movie title, movie year, and movie genre for all action movies (result shown in Figure P7.77).*/

	 SELECT MOVIE_TITLE, MOVIE_YEAR, MOVIE_GENRE FROM MOVIE WHERE UPPER(MOVIE_GENRE) = 'ACTION' ORDER BY MOVIE_YEAR ASC;


  /* Problem 78. Write a query to display the movie number, movie title, and movie cost for all movies with a cost greater than $40 (result shown in Figure P7.78).*/

	 SELECT MOVIE_NUM, MOVIE_TITLE, MOVIE_COST FROM MOVIE WHERE MOVIE_COST > 40; 


  /* Problem 79. Write a query to display the movie number, movie title, movie cost, and movie genre for all movies that are either action or comedy movies and that have a cost that is less than $50.  Sort the results in ascending order by genre. (Result shown in Figure P7.79.)*/

  	 SELECT MOVIE_NUM, MOVIE_TITLE, MOVIE_COST, MOVIE_GENRE FROM MOVIE WHERE UPPER(MOVIE_GENRE) IN ('ACTION','COMEDY') AND (MOVIE_COST < 50) ORDER BY MOVIE_GENRE ASC; 

	 --SELECT MOVIE_NUM, MOVIE_TITLE, MOVIE_COST, MOVIE_GENRE FROM MOVIE WHERE UPPER(MOVIE_GENRE) IN ('ACTION','COMEDY') OR (MOVIE_COST < 50) ORDER BY MOVIE_GENRE ASC; 


  /* Problem 80. Write a query to display the movie number, and movie description for all movies where the movie description is a combination of the movie title, movie year and movie genre with the movie year enclosed in parentheses (result shown in Figure P7.80).*/

	 SELECT MOVIE_NUM, CONCAT(MOVIE_TITLE, ' (',MOVIE_YEAR, ') ',MOVIE_GENRE) AS 'MOVIE DESCRIPTION' FROM MOVIE ; 


  /* Problem 81. Write a query to display the movie genre and the number of movies in each genre (result shown in Figure P7.81).*/

	 SELECT MOVIE_GENRE, COUNT(*) AS 'NUMEBR OF MOVIES' FROM MOVIE GROUP BY MOVIE_GENRE;


  /* Problem 82. Write a query to display the average cost of all of the movies (result shown in Figure P7.82).*/


	 SELECT (CAST(AVG(MOVIE_COST) AS decimal(6,4))) AS 'AVERAGE MOVIE COST' FROM MOVIE;


  /* Problem 83. Write a query to display the movie genre and average cost of movies in each genre (result shown in Figure P7.83).*/

	 SELECT MOVIE_GENRE, (CAST(AVG(MOVIE_COST) AS decimal(4,2))) AS 'AVERAGE COST' FROM MOVIE GROUP BY MOVIE_GENRE;


  /* Problem 84. Write a query to display the movie title, movie genre, price description, and price rental fee for all movies with a price code (result shown in Figure P7.84).*/

	 SELECT A.MOVIE_TITLE, A.MOVIE_GENRE, B.PRICE_DESCRIPTION, B.PRICE_RENTFEE FROM MOVIE A, PRICE B 
	 WHERE A.PRICE_CODE =  B.PRICE_CODE ORDER BY B.PRICE_DESCRIPTION DESC; 


  /* Problem 85. Write a query to display the movie genre and average price rental fee for movies in each genre that have a price (result shown in Figure P7.85). */


  	 SELECT A.MOVIE_GENRE, (CAST(AVG(B.PRICE_RENTFEE) AS decimal(3,2))) AS 'AVERAGE RENTAL FEE' FROM MOVIE A, PRICE B 
	 WHERE A.PRICE_CODE =  B.PRICE_CODE GROUP BY A.MOVIE_GENRE; 


  /* Problem 86. Write a query to display the movie title, movie year, and the movie cost divided by the price rental fee for each movie that has a price to determine the number of rentals it will take to break even on the purchase of the movie (result shown in Figure P7.86). */


     SELECT A.MOVIE_TITLE, A.MOVIE_YEAR, (CAST((A.MOVIE_COST/B.PRICE_RENTFEE) AS decimal(4,2))) AS 'BREAKEVEN RENTALS' FROM MOVIE A, PRICE B 
	 WHERE A.PRICE_CODE =  B.PRICE_CODE ORDER BY A.MOVIE_TITLE DESC, A.MOVIE_YEAR ASC; 


  /* Problem 87. Write a query to display the movie title and movie year for all movies that have a price code (result shown in Figure P7.87).*/


  	SELECT MOVIE_TITLE, MOVIE_YEAR FROM MOVIE WHERE PRICE_CODE IS NOT NULL ;



  /* Problem 88. Write a query to display the movie title, movie year, and movie cost for all movies that have a cost between $44.99 and $49.99 (result shown in Figure P7.88).*/


  	SELECT MOVIE_TITLE, MOVIE_YEAR, MOVIE_COST FROM MOVIE WHERE MOVIE_COST BETWEEN 44.99 AND 49.99;


  /* Problem 89. Write a query to display the movie title, movie year, price description, and price rental fee for all movies that are in the genres Family, Comedy, or Drama (result shown in Figure P7.89).*/


  	 SELECT A.MOVIE_TITLE, A.MOVIE_YEAR, B.PRICE_DESCRIPTION, B.PRICE_RENTFEE, A.MOVIE_GENRE FROM MOVIE A, PRICE B 
	 WHERE A.PRICE_CODE =  B.PRICE_CODE 
	 AND UPPER(A.MOVIE_GENRE) IN ('FAMILY','COMEDY','DRAMA'); 


  /* Problem 90. Write a query to display the movie number, movie title, and movie year for all movies that do not have a video (result shown in Figure P7.90).*/


  	 SELECT MOVIE_NUM, MOVIE_TITLE, MOVIE_YEAR FROM MOVIE
	 WHERE MOVIE_NUM  NOT IN (SELECT MOVIE_NUM FROM VIDEO);
	  

  /* Problem 91. Write a query to display the membership number, first name, last name, and balance of the memberships that have a rental (result shown in Figure P7.91).*/

     SELECT DISTINCT A.MEM_NUM, A.MEM_FNAME, A.MEM_LNAME, A.MEM_BALANCE FROM MEMBERSHIP A, RENTAL B 
	 WHERE A.MEM_NUM =  B.MEM_NUM 
	 ORDER BY A.MEM_NUM ASC; 


  /* Problem 92. Write a query to display the minimum balance, maximum balance, and average balance for memberships that have a rental (result shown in Figure P7.92).*/

     --SELECT MIN(A.MEM_BALANCE) AS 'MINIMUM BALANCE', MAX(A.MEM_BALANCE) AS 'MAXIMUM BALANCE', (ROUND(AVG(A.MEM_BALANCE),6,4)) AS 'AVERAGE BALANCE' FROM MEMBERSHIP A, RENTAL B 
	 --WHERE A.MEM_NUM =  B.MEM_NUM; 

	 SELECT MIN(A.MEM_BALANCE) AS 'MINIMUM BALANCE', MAX(A.MEM_BALANCE) AS 'MAXIMUM BALANCE', (CAST(AVG(A.MEM_BALANCE) AS decimal(6,2))) AS 'AVERAGE BALANCE' FROM MEMBERSHIP A, RENTAL B 
	 WHERE A.MEM_NUM =  B.MEM_NUM; 

	 --SELECT MIN(A.MEM_BALANCE) AS 'MINIMUM BALANCE', MAX(A.MEM_BALANCE) AS 'MAXIMUM BALANCE', AVG(A.MEM_BALANCE) AS 'AVERAGE BALANCE' FROM MEMBERSHIP A, RENTAL B 
	 --WHERE A.MEM_NUM =  B.MEM_NUM;


  /* Problem 93. Write a query to display the membership name (concatenate the first name and last name with a space between them into a single column), membership address (concatenate the street, city, state, and zip codes into a single column with spaces (result shown in Figure P7.93).*/


  	 SELECT CONCAT(MEM_FNAME, ' ', MEM_LNAME) AS 'MEMBERSHIP NAME', CONCAT(MEM_STREET, ', ', MEM_CITY, ', ', MEM_STATE, ' ', MEM_ZIP) AS 'MEMBERSHIP ADDRESS' FROM MEMBERSHIP ; 


  /* Problem 94. Write a query to display the rental number, rental date, video number, movie title, due date, and return date for all videos that were returned after the due date.  Sort the results by rental number and movie title (result shown in Figure P7.94).*/


	 SELECT B.RENT_NUM, B.RENT_DATE, A.VID_NUM, C.MOVIE_TITLE, A.DETAIL_DUEDATE, A.DETAIL_RETURNDATE 
	 FROM DETAILRENTAL A, RENTAL B, MOVIE C, VIDEO D 
	 WHERE A.RENT_NUM =  B.RENT_NUM
	 AND A.VID_NUM = D.VID_NUM
	 AND C.MOVIE_NUM = D.MOVIE_NUM
	 AND A.DETAIL_RETURNDATE > A.DETAIL_DUEDATE
	 ORDER BY B.RENT_NUM ASC, C.MOVIE_TITLE ASC; 


  /* Problem 95. Write a query to display the rental number, rental date, video number, movie title, due date, return date, detail fee, and number of days past the due date that the video was returned for each video that was returned after the due date.  Sort the results by rental number and movie title. (Result shown in Figure P7.95.) */
     

	 SELECT B.RENT_NUM, B.RENT_DATE, A.VID_NUM, C.MOVIE_TITLE, A.DETAIL_DUEDATE, A.DETAIL_RETURNDATE, A.DETAIL_FEE, datediff(day,A.DETAIL_DUEDATE, A.DETAIL_RETURNDATE) AS 'DAYS PAST DUE'
	 FROM DETAILRENTAL A, RENTAL B, MOVIE C, VIDEO D 
	 WHERE A.RENT_NUM =  B.RENT_NUM
	 AND A.VID_NUM = D.VID_NUM
	 AND C.MOVIE_NUM = D.MOVIE_NUM
	 AND A.DETAIL_RETURNDATE > A.DETAIL_DUEDATE
	 ORDER BY B.RENT_NUM ASC, C.MOVIE_TITLE ASC; 


  /* Problem 96. Write a query to display the rental number, rental date, movie title, and detail fee for each movie that was returned on or before the due date (result shown in Figure P7.96).*/

  	 SELECT DISTINCT B.RENT_NUM, B.RENT_DATE, C.MOVIE_TITLE, A.DETAIL_FEE 
	 FROM DETAILRENTAL A, RENTAL B, MOVIE C, VIDEO D
	 WHERE A.RENT_NUM =  B.RENT_NUM
	 AND A.VID_NUM = D.VID_NUM
	 AND C.MOVIE_NUM = D.MOVIE_NUM
	 AND A.DETAIL_RETURNDATE <= A.DETAIL_DUEDATE
	 --ORDER BY B.RENT_NUM ASC; 
	 ORDER BY B.RENT_DATE, A.DETAIL_FEE ASC; 

  /* Problem 97. Write a query to display the membership number, last name, and total rental fees earned from that membership (result shown in Figure P7.97).  The total rental fee is the sum of all of the detail fees (without the late fees) from all movies that the membership has rented. */

  
	 SELECT DISTINCT E.MEM_NUM, E.MEM_LNAME, E.MEM_FNAME, D.TOTALRENTAL2 AS 'RENTAL FEE REVENUE'
	 FROM 
	 (
	 SELECT DISTINCT B.MEM_NUM, SUM(A.TOTALRENTAL) AS 'TOTALRENTAL2'
	 FROM 
	 (SELECT DISTINCT RENT_NUM, SUM(DETAIL_FEE) AS TOTALRENTAL FROM DETAILRENTAL GROUP BY RENT_NUM) A, RENTAL B
	 WHERE B.RENT_NUM = A.RENT_NUM
	 GROUP BY B.MEM_NUM
	 ) D , MEMBERSHIP E
	 WHERE D.MEM_NUM = E.MEM_NUM
	 ;


  /* Problem 98 
    Write a query to display the movie number, movie genre, average movie cost of movies in that genre, movie cost of that individual movie, 
	and the percentage difference between the average movie cost and the individual movie cost (result shown in Figure P7.98).  
	Note: the percentage difference is calculated as the cost of the individual movie minus the average cost of movies in that genre, divided by the average cost of movies in that genre multiplied by 100.  
	For example, if the average cost of movies in the “Family” genre is $25, if a given Family movie cost $26, then the calculation would be ((26 – 25) / 25 * 100), which would work out to be 4.00%.   
	This indicates that this movie costs 4% more than the average Family movie.
  */


  
	 SELECT DISTINCT A.MOVIE_NUM, A.MOVIE_GENRE, B.AVGCOST AS 'AVERAGE COST', A.MOVIE_COST, 
	 (CAST(((A.MOVIE_COST - B.AVGCOST)*100/B.AVGCOST) AS decimal(4,2))) AS 'PERCENT DIFFERENCE'
	 FROM
	 (
	 SELECT MOVIE_GENRE, (CAST(AVG(MOVIE_COST) AS decimal(4,2))) AS 'AVGCOST' FROM MOVIE
	 GROUP BY MOVIE_GENRE) B, MOVIE A
	 WHERE A.MOVIE_GENRE = B.MOVIE_GENRE
	 ORDER BY A.MOVIE_NUM
	 ;


 /*************************************************************************************/
/*End of file*/
/*************************************************************************************/

