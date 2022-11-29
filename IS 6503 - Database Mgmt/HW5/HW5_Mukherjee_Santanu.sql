
/* HW5_Mukherjee_Santanu*/

/* This is the SQL Query file for HW5 (Problems 20-34) */

/* Before we work on Problems 20-34, we need to create 2 databases, create the required tables for each database and insert data into those tables as shown below*/

/* The first step is to make sure to drop the databases if already created*/

DROP DATABASE DBP2030;
DROP DATABASE DBP3134;


/* The next step is to create 2 databases*/

CREATE DATABASE DBP2030;
CREATE DATABASE DBP3134;

/* The following statements drops the tables that will be used to later create and run queries for both databases DBP2030 and DBP3134 */

DROP TABLE DBP2030.dbo.INVOICE;
DROP TABLE DBP2030.dbo.CUSTOMER;


DROP TABLE DBP3134.dbo.LINE;
DROP TABLE DBP3134.dbo.INVOICE;
DROP TABLE DBP3134.dbo.CUSTOMER;
DROP TABLE DBP3134.dbo.PRODUCT;
DROP TABLE DBP3134.dbo.VENDOR;


/* The folowing statements creates the tables for the database DBP2030 and inserts data into those tables */

CREATE TABLE DBP2030.dbo.CUSTOMER (
CUST_NUM     INTEGER PRIMARY KEY,
CUST_LNAME   VARCHAR(30),
CUST_FNAME   VARCHAR(30),
CUST_BALANCE DECIMAL(8,2));

CREATE TABLE DBP2030.dbo.INVOICE (
INV_NUM    INTEGER PRIMARY KEY,
CUST_NUM   INTEGER,
INV_DATE   DATE,
INV_AMOUNT DECIMAL(10,2),
FOREIGN KEY (CUST_NUM) REFERENCES CUSTOMER(CUST_NUM));


INSERT INTO DBP2030.dbo.CUSTOMER VALUES (1000, 'Smith', 'Jeanne', 1050.11);
INSERT INTO DBP2030.dbo.CUSTOMER VALUES (1001, 'Ortega', 'Juan', 840.92);


INSERT INTO DBP2030.dbo.INVOICE VALUES (8000, 1000, '2016-03-23', 235.89);
INSERT INTO DBP2030.dbo.INVOICE VALUES (8001, 1001, '2016-03-23', 312.82);
INSERT INTO DBP2030.dbo.INVOICE VALUES (8002, 1001, '2016-03-30', 528.10);
INSERT INTO DBP2030.dbo.INVOICE VALUES (8003, 1000, '2016-04-16', 194.78);
INSERT INTO DBP2030.dbo.INVOICE VALUES (8004, 1000, '2016-04-23', 619.44);

select * from DBP2030.dbo.CUSTOMER;
select * from DBP2030.dbo.INVOICE;


/* The folowing statements creates the tables for the database DBP3134 and inserts data into those tables */


CREATE TABLE DBP3134.dbo.VENDOR ( 
V_CODE 		INTEGER, 
V_NAME 		VARCHAR(35) NOT NULL, 
V_CONTACT 	VARCHAR(15) NOT NULL, 
V_AREACODE 	CHAR(3) NOT NULL, 
V_PHONE 	CHAR(8) NOT NULL, 
V_STATE 	CHAR(2) NOT NULL, 
V_ORDER 	CHAR(1) NOT NULL, 
PRIMARY KEY (V_CODE));

CREATE TABLE DBP3134.dbo.PRODUCT (
P_CODE 	VARCHAR(10) CONSTRAINT DBP3134_PRODUCT_P_CODE_PK PRIMARY KEY,
P_DESCRIPT 	VARCHAR(35) NOT NULL,
P_INDATE 	DATE NOT NULL,
P_QOH 		NUMERIC NOT NULL,
P_MIN 		NUMERIC NOT NULL,
P_PRICE 	NUMERIC(8,2) NOT NULL,
P_DISCOUNT 	NUMERIC(4,2) NOT NULL,
V_CODE 		INTEGER,
CONSTRAINT DBP3134_PRODUCT_V_CODE_FK
FOREIGN KEY (V_CODE) REFERENCES DBP3134.dbo.VENDOR);

CREATE TABLE DBP3134.dbo.CUSTOMER (
CUS_CODE	NUMERIC PRIMARY KEY,
CUS_LNAME	VARCHAR(15) NOT NULL,
CUS_FNAME	VARCHAR(15) NOT NULL,
CUS_INITIAL	CHAR(1),
CUS_AREACODE 	CHAR(3) DEFAULT '615' NOT NULL CHECK(CUS_AREACODE IN ('615','713','931')),
CUS_PHONE	CHAR(8) NOT NULL,
CUS_BALANCE	NUMERIC(9,2) DEFAULT 0.00,
CONSTRAINT CUS_UI1 UNIQUE(CUS_LNAME,CUS_FNAME));


CREATE TABLE DBP3134.dbo.INVOICE (
INV_NUMERIC     	NUMERIC PRIMARY KEY,
CUS_CODE	NUMERIC NOT NULL REFERENCES DBP3134.dbo.CUSTOMER(CUS_CODE),
INV_DATE  	DATE DEFAULT GETDATE() NOT NULL,
INV_SUBTOTAL    NUMERIC(9,2),
INV_TAX         NUMERIC(9,2),
INV_TOTAL       NUMERIC(9,2),
CONSTRAINT INV_CK1 CHECK (INV_DATE > CAST('01-JAN-2012' AS DATETIME)));


CREATE TABLE  DBP3134.dbo.LINE (
INV_NUMERIC 	NUMERIC NOT NULL,
LINE_NUMERIC	NUMERIC(2,0) NOT NULL,
P_CODE		VARCHAR(10) NOT NULL,
LINE_UNITS	NUMERIC(9,2) DEFAULT 0.00 NOT NULL,
LINE_PRICE	NUMERIC(9,2) DEFAULT 0.00 NOT NULL,
LINE_TOTAL      NUMERIC(9,2),
PRIMARY KEY (INV_NUMERIC,LINE_NUMERIC),
FOREIGN KEY (INV_NUMERIC) REFERENCES DBP3134.dbo.INVOICE ON DELETE CASCADE,
FOREIGN KEY (P_CODE) REFERENCES DBP3134.dbo.PRODUCT(P_CODE),
CONSTRAINT LINE_UI1 UNIQUE(INV_NUMERIC, P_CODE));


/**************************************************************************************************************/
 -- Inserting data into the tables created above for database DBP3134

 /**************************************************************************************************************/

 
/* DBP3134.VENDOR rows						*/
INSERT INTO DBP3134.dbo.VENDOR VALUES(21225,'Bryson, Inc.'    ,'Smithson','615','223-3234','TN','Y');
INSERT INTO DBP3134.dbo.VENDOR VALUES(21226,'SuperLoo, Inc.'  ,'Flushing','904','215-8995','FL','N');
INSERT INTO DBP3134.dbo.VENDOR VALUES(21231,'D\&E Supply'     ,'Singh'   ,'615','228-3245','TN','Y');
INSERT INTO DBP3134.dbo.VENDOR VALUES(21344,'Gomez Bros.'     ,'Ortega'  ,'615','889-2546','KY','N');
INSERT INTO DBP3134.dbo.VENDOR VALUES(22567,'Dome Supply'     ,'Smith'   ,'901','678-1419','GA','N');
INSERT INTO DBP3134.dbo.VENDOR VALUES(23119,'Randsets Ltd.'   ,'Anderson','901','678-3998','GA','Y');
INSERT INTO DBP3134.dbo.VENDOR VALUES(24004,'Brackman Bros.'  ,'Browning','615','228-1410','TN','N');
INSERT INTO DBP3134.dbo.VENDOR VALUES(24288,'ORDVA, Inc.'     ,'Hakford' ,'615','898-1234','TN','Y');
INSERT INTO DBP3134.dbo.VENDOR VALUES(25443,'B\&K, Inc.'      ,'Smith'   ,'904','227-0093','FL','N');
INSERT INTO DBP3134.dbo.VENDOR VALUES(25501,'Damal Supplies'  ,'Smythe'  ,'615','890-3529','TN','N');
INSERT INTO DBP3134.dbo.VENDOR VALUES(25595,'Rubicon Systems' ,'Orton'   ,'904','456-0092','FL','Y');

select * from DBP3134.dbo.VENDOR;

/* DBP3134.PRODUCT rows						*/
INSERT INTO DBP3134.dbo.PRODUCT VALUES('11QER/31','Power painter, 15 psi., 3-nozzle'     ,'03-NOV-2011',  8,  5,109.99,0.00,25595);
INSERT INTO DBP3134.dbo.PRODUCT VALUES('13-Q2/P2','7.25-in. pwr. saw blade'              ,'13-DEC-2011', 32, 15, 14.99,0.05,21344);
INSERT INTO DBP3134.dbo.PRODUCT VALUES('14-Q1/L3','9.00-in. pwr. saw blade'              ,'13-NOV-2011', 18, 12, 17.49,0.00,21344);
INSERT INTO DBP3134.dbo.PRODUCT VALUES('1546-QQ2','Hrd. cloth, 1/4-in., 2x50'            ,'15-JAN-2012', 15,  8, 39.95,0.00,23119);
INSERT INTO DBP3134.dbo.PRODUCT VALUES('1558-QW1','Hrd. cloth, 1/2-in., 3x50'            ,'15-JAN-2012', 23,  5, 43.99,0.00,23119);
INSERT INTO DBP3134.dbo.PRODUCT VALUES('2232/QTY','B\&D jigsaw, 12-in. blade'            ,'30-DEC-2011',  8,  5,109.92,0.05,24288);
INSERT INTO DBP3134.dbo.PRODUCT VALUES('2232/QWE','B\&D jigsaw, 8-in. blade'             ,'24-DEC-2011',  6,  5, 99.87,0.05,24288);
INSERT INTO DBP3134.dbo.PRODUCT VALUES('2238/QPD','B\&D cordless drill, 1/2-in.'         ,'20-JAN-2012', 12,  5, 38.95,0.05,25595);
INSERT INTO DBP3134.dbo.PRODUCT VALUES('23109-HB','Claw hammer'                          ,'20-JAN-2012', 23, 10,  9.95,0.10,21225);
INSERT INTO DBP3134.dbo.PRODUCT VALUES('23114-AA','Sledge hammer, 12 lb.'                ,'02-JAN-2012',  8,  5, 14.40,0.05,NULL );
INSERT INTO DBP3134.dbo.PRODUCT VALUES('54778-2T','Rat-tail file, 1/8-in. fine'          ,'15-DEC-2011', 43, 20,  4.99,0.00,21344);
INSERT INTO DBP3134.dbo.PRODUCT VALUES('89-WRE-Q','Hicut chain saw, 16 in.'              ,'07-FEB-2012', 11,  5,256.99,0.05,24288);
INSERT INTO DBP3134.dbo.PRODUCT VALUES('PVC23DRT','PVC pipe, 3.5-in., 8-ft'              ,'20-FEB-2011',188, 75,  5.87,0.00,NULL );
INSERT INTO DBP3134.dbo.PRODUCT VALUES('SM-18277','1.25-in. metal screw, 25'             ,'01-MAR-2012',172, 75,  6.99,0.00,21225);
INSERT INTO DBP3134.dbo.PRODUCT VALUES('SW-23116','2.5-in. wd. screw, 50'                ,'24-FEB-2012',237,100,  8.45,0.00,21231);
INSERT INTO DBP3134.dbo.PRODUCT VALUES('WR3/TT3' ,'Steel matting, 4''x8''x1/6", .5" mesh','17-JAN-2012', 18,  5,119.95,0.10,25595);

select * from DBP3134.dbo.PRODUCT;


/* DBP3134.CUSTOMER rows					*/
INSERT INTO DBP3134.dbo.CUSTOMER VALUES(10010,'Ramas'   ,'Alfred','A' ,'615','844-2573',0);
INSERT INTO DBP3134.dbo.CUSTOMER VALUES(10011,'Dunne'   ,'Leona' ,'K' ,'713','894-1238',0);
INSERT INTO DBP3134.dbo.CUSTOMER VALUES(10012,'Smith'   ,'Kathy' ,'W' ,'615','894-2285',0);
INSERT INTO DBP3134.dbo.CUSTOMER VALUES(10013,'Olowski' ,'Paul'  ,'F' ,'615','894-2180',0);
INSERT INTO DBP3134.dbo.CUSTOMER VALUES(10014,'Orlando' ,'Myron' ,NULL,'615','222-1672',0);
INSERT INTO DBP3134.dbo.CUSTOMER VALUES(10015,'O''Brian','Amy'   ,'B' ,'713','442-3381',0);
INSERT INTO DBP3134.dbo.CUSTOMER VALUES(10016,'Brown'   ,'James' ,'G' ,'615','297-1228',0);
INSERT INTO DBP3134.dbo.CUSTOMER VALUES(10017,'Williams','George',NULL,'615','290-2556',0);
INSERT INTO DBP3134.dbo.CUSTOMER VALUES(10018,'Farriss' ,'Anne'  ,'G' ,'713','382-7185',0);
INSERT INTO DBP3134.dbo.CUSTOMER VALUES(10019,'Smith'   ,'Olette','K' ,'615','297-3809',0);

select * from DBP3134.dbo.CUSTOMER;


/* DBP3134.INVOICE rows						*/
INSERT INTO DBP3134.dbo.INVOICE VALUES(1001,10014,'16-JAN-2012',  24.90,  1.99,  0.00);
INSERT INTO DBP3134.dbo.INVOICE VALUES(1002,10011,'16-JAN-2012',   9.98,  0.80,  0.00);
INSERT INTO DBP3134.dbo.INVOICE VALUES(1003,10012,'16-JAN-2012', 153.85, 12.31, 0.00);
INSERT INTO DBP3134.dbo.INVOICE VALUES(1004,10011,'17-JAN-2012',  34.97,  2.80,  0.00);
INSERT INTO DBP3134.dbo.INVOICE VALUES(1005,10018,'17-JAN-2012',  70.44,  5.64,  0.00);
INSERT INTO DBP3134.dbo.INVOICE VALUES(1006,10014,'17-JAN-2012', 397.83, 31.83, 0.00);
INSERT INTO DBP3134.dbo.INVOICE VALUES(1007,10015,'17-JAN-2012',  34.97,  2.80,  0.00);
INSERT INTO DBP3134.dbo.INVOICE VALUES(1008,10011,'17-JAN-2012', 399.15, 31.93, 0.00);

select * from DBP3134.dbo.INVOICE;


/* DBP3134.LINE rows						*/
INSERT INTO DBP3134.dbo.LINE VALUES(1001,1,'13-Q2/P2',1,  14.99,  14.99);
INSERT INTO DBP3134.dbo.LINE VALUES(1001,2,'23109-HB',1,   9.95,   9.95);
INSERT INTO DBP3134.dbo.LINE VALUES(1002,1,'54778-2T',2,   4.99,   9.98);
INSERT INTO DBP3134.dbo.LINE VALUES(1003,1,'2238/QPD',1,  38.95,  38.95);
INSERT INTO DBP3134.dbo.LINE VALUES(1003,2,'1546-QQ2',1,  39.95,  39.95);
INSERT INTO DBP3134.dbo.LINE VALUES(1003,3,'13-Q2/P2',5,  14.99,  74.95);
INSERT INTO DBP3134.dbo.LINE VALUES(1004,1,'54778-2T',3,   4.99,  14.97);
INSERT INTO DBP3134.dbo.LINE VALUES(1004,2,'23109-HB',2,   9.95,  19.90);
INSERT INTO DBP3134.dbo.LINE VALUES(1005,1,'PVC23DRT',12,  5.87,  70.44);
INSERT INTO DBP3134.dbo.LINE VALUES(1006,1,'SM-18277',3,   6.99,  20.97);
INSERT INTO DBP3134.dbo.LINE VALUES(1006,2,'2232/QTY',1, 109.92, 109.92);
INSERT INTO DBP3134.dbo.LINE VALUES(1006,3,'23109-HB',1,   9.95,   9.95);
INSERT INTO DBP3134.dbo.LINE VALUES(1006,4,'89-WRE-Q',1, 256.99, 256.99);
INSERT INTO DBP3134.dbo.LINE VALUES(1007,1,'13-Q2/P2',2,  14.99,  29.98);
INSERT INTO DBP3134.dbo.LINE VALUES(1007,2,'54778-2T',1,   4.99,   4.99);
INSERT INTO DBP3134.dbo.LINE VALUES(1008,1,'PVC23DRT',5,   5.87,  29.35);
INSERT INTO DBP3134.dbo.LINE VALUES(1008,2,'WR3/TT3' ,3, 119.95, 359.85);
INSERT INTO DBP3134.dbo.LINE VALUES(1008,3,'23109-HB',1,   9.95,   9.95);

select * from DBP3134.dbo.LINE;

/*******************************************************************************************/




 /* Problem 20.	Create an Oracle sequence named CUST_NUM_SEQ to generate values for customer numbers. The sequence should start with the value 2000. */

DROP SEQUENCE CUST_NUM_SEQ;

CREATE SEQUENCE CUST_NUM_SEQ START WITH 2000 INCREMENT BY 1 NO CACHE;




 /* Problem 21.	Create an Oracle sequence named INV_NUM_SEQ to generate values for invoice numbers. The sequence should start with the value 9000.. */

DROP SEQUENCE INV_NUM_SEQ;

CREATE SEQUENCE INV_NUM_SEQ START WITH 9000 INCREMENT BY 1 NO CACHE;



/* Problem 22.	Insert the following customer into the CUSTOMER table, using the Oracle sequence created in Problem 20 to generate the customer number automatically:.
			‘Powers’, ‘Ruth’, 500  */

DELETE FROM DBP2030.dbo.CUSTOMER WHERE UPPER(CUST_LNAME) = 'POWERS';

SELECT * FROM DBP2030.dbo.CUSTOMER;

INSERT INTO DBP2030.dbo.CUSTOMER VALUES(NEXT VALUE FOR CUST_NUM_SEQ, 'Powers', 'Ruth', 500);

SELECT * FROM DBP2030.dbo.CUSTOMER;

/* Problem 23.	Modify the CUSTOMER table to include the customer’s date of birth (CUST_DOB), which should store date data  */

ALTER TABLE DBP2030.dbo.CUSTOMER DROP COLUMN CUST_DOB ;

SELECT * FROM DBP2030.dbo.CUSTOMER;

ALTER TABLE DBP2030.dbo.CUSTOMER
ADD CUST_DOB DATE NULL;

SELECT * FROM DBP2030.dbo.CUSTOMER;


/* Problem 24.	Modify customer 1000 to indicate the date of birth on March 15, 1989. */

UPDATE DBP2030.dbo.CUSTOMER SET CUST_DOB = NULL WHERE CUST_NUM = 1000;

SELECT * FROM DBP2030.dbo.CUSTOMER;

UPDATE DBP2030.dbo.CUSTOMER SET CUST_DOB = '15-MAR-89' WHERE CUST_NUM = 1000;

SELECT * FROM DBP2030.dbo.CUSTOMER;


/* Problem 25.	Modify customer 1001 to indicate the date of birth on December 22, 1988. */

UPDATE DBP2030.dbo.CUSTOMER SET CUST_DOB = NULL WHERE CUST_NUM = 1001;

SELECT * FROM DBP2030.dbo.CUSTOMER;

UPDATE DBP2030.dbo.CUSTOMER SET CUST_DOB = '22-DEC-88' WHERE CUST_NUM = 1001;

SELECT * FROM DBP2030.dbo.CUSTOMER;


/* Problem 26.	Create a trigger named trg_updatecustbalance to update the CUST_BALANCE in the CUSTOMER table when a new invoice record is entered. (Assume that the sale is a credit sale.) 
Whatever value appears in the INV_AMOUNT column of the new invoice should be added to the customer’s balance. Test the trigger using the following new INVOICE record, 
which would add 225.40 to the balance of customer 1001: 8005, 1001, '27-APR-18', 225.40  */


DROP TRIGGER trg_updatecustbalance;

SELECT * FROM DBP2030.dbo.INVOICE;
SELECT * FROM DBP2030.dbo.CUSTOMER;

UPDATE DBP2030.dbo.CUSTOMER SET cust_balance = 840.92 WHERE CUST_NUM = 1001;


/* Trigger statement should be the first statement in a query batch*/

USE DBP2030;

CREATE TRIGGER trg_updatecustbalance on  dbo.INVOICE
AFTER insert
AS
BEGIN
   DECLARE @InvAmount DECIMAL(10,2)
   DECLARE @CustNum INT

   SELECT @InvAmount = inserted.INV_AMOUNT, @CustNum = inserted.CUST_NUM FROM inserted

   UPDATE DBP2030.dbo.CUSTOMER SET CUST_BALANCE = CUST_BALANCE + @InvAmount WHERE CUST_NUM = @CustNum;

END;

 /* Test the trigger using the following new INVOICE record, which would add 225.40 to the balance of customer 1001:
8005, 1001, '27-APR-18', 225.40
 */

DELETE FROM DBP2030.dbo.INVOICE WHERE INV_NUM = 8005;


SELECT * FROM DBP2030.dbo.INVOICE;
SELECT * FROM DBP2030.dbo.CUSTOMER;

INSERT INTO DBP2030.dbo.INVOICE VALUES (8005, 1001, '27-APR-18', 225.40);

SELECT * FROM DBP2030.dbo.INVOICE;
SELECT * FROM DBP2030.dbo.CUSTOMER;



/* Problem 27.	Write a procedure named prc_cust_add to add a new customer to the CUSTOMER table. Use the following values in the new record:
1002, 'Rauthor', 'Peter', 0.00
(You should execute the procedure and verify that the new customer was added to ensure your code is correct.) */

DROP PROCEDURE prc_cust_add;

DELETE FROM DBP2030.dbo.CUSTOMER WHERE CUST_NUM = 1002;
SELECT * FROM DBP2030.dbo.CUSTOMER;

CREATE PROCEDURE prc_cust_add 
AS
BEGIN
	INSERT INTO DBP2030.dbo.CUSTOMER VALUES (1002, 'Rauthor', 'Peter', 0.00, NULL);

END;

/* Execute the procedure by adding a new record with values 1002, 'Rauthor', 'Peter', 0.00 */

SELECT * FROM DBP2030.dbo.CUSTOMER;

EXEC prc_cust_add;

SELECT * FROM DBP2030.dbo.CUSTOMER;


/* Problem 28.	Write a procedure named prc_invoice_add to add a new invoice record to the INVOICE table. Use the following values in the new record:
8006, 1000, '30-APR-18', 301.72 
(You should execute the procedure and verify that the new invoice was added to ensure your code is correct.)*/

DROP PROCEDURE prc_invoice_add;

DELETE FROM DBP2030.dbo.INVOICE WHERE INV_NUM = 8006;
SELECT * FROM DBP2030.dbo.INVOICE;

CREATE PROCEDURE prc_invoice_add 
AS
BEGIN
	INSERT INTO DBP2030.dbo.INVOICE VALUES (8006, 1000, '30-APR-18', 301.72);

END;

/* Execute the procedure by adding a new record with values 8006, 1000, '30-APR-18', 301.72  */

SELECT * FROM DBP2030.dbo.INVOICE;

EXEC prc_invoice_add;

SELECT * FROM DBP2030.dbo.INVOICE;


/* Problem 29.	Write a trigger to update the customer balance when an invoice is deleted. Name the trigger trg_updatecustbalance2. */

 /* Test the trigger using the following new INVOICE record, which is first being added and then deleted would reduce 100.00 from the balance of customer 1001:
8100, 1001, '31-OCT-19', 100.00
 */

SELECT * FROM DBP2030.dbo.INVOICE;
SELECT * FROM DBP2030.dbo.CUSTOMER;

INSERT INTO DBP2030.dbo.INVOICE VALUES (8100, 1001, '31-OCT-19', 100.00);

SELECT * FROM DBP2030.dbo.INVOICE;
SELECT * FROM DBP2030.dbo.CUSTOMER;

/* Code for the trigger */

DROP TRIGGER trg_updatecustbalance2;

USE DBP2030;

CREATE TRIGGER trg_updatecustbalance2 on  dbo.INVOICE
AFTER delete
AS
BEGIN
   DECLARE @InvAmount1 DECIMAL(10,2)
   DECLARE @CustNum1 INT

   SELECT @InvAmount1 = deleted.INV_AMOUNT, @CustNum1 = deleted.CUST_NUM FROM deleted

   UPDATE DBP2030.dbo.CUSTOMER SET CUST_BALANCE = CUST_BALANCE - @InvAmount1 WHERE CUST_NUM = @CustNum1;

END;


 /* Test the trigger using the following new INVOICE record, which is first being added and then deleted would reduce 100.00 from the balance of customer 1000:
8100, 1001, '31-OCT-19', 100.00
 */

SELECT * FROM DBP2030.dbo.INVOICE;
SELECT * FROM DBP2030.dbo.CUSTOMER;

DELETE FROM  DBP2030.dbo.INVOICE WHERE INV_NUM = 8100;

SELECT * FROM DBP2030.dbo.INVOICE;
SELECT * FROM DBP2030.dbo.CUSTOMER;



/* Problem 30.	Write a procedure to delete an invoice, giving the invoice number as a parameter. Name the procedure prc_inv_delete. Test the procedure by deleting invoices 8005 and 8006. */


DROP PROCEDURE prc_invoice_delete;

CREATE PROCEDURE prc_invoice_delete (@Invnum INTEGER) 
AS
BEGIN
IF @Invnum = null -- validation of primary key
	PRINT 'Error: Invoice Number should not be NULL';
ELSE
	BEGIN
	DELETE FROM DBP2030.dbo.INVOICE WHERE INV_NUM = @Invnum;
	PRINT ('* * Deletion Successful * *');
	END;
END;

/* Execute the procedure so that Invoice numbers 8005 and 8006 are deleted  */

SELECT * FROM DBP2030.dbo.INVOICE WHERE INV_NUM IN (8005,8006);

EXEC prc_invoice_delete @Invnum=8005;
EXEC prc_invoice_delete @Invnum=8006;

SELECT * FROM DBP2030.dbo.INVOICE WHERE INV_NUM IN (8005,8006);



/* First Half Complete. Second half uses database DBP3134 */


/* Problem 31.	Create a trigger named trg_line_total to write the LINE_TOTAL value in the LINE table every time you add a new LINE row. */
/*(The LINE_TOTAL value is the product of the LINE_UNITS and LINE_PRICE values.) */


DROP TRIGGER trg_line_total;

SELECT * FROM DBP3134.dbo.PRODUCT;
SELECT * FROM DBP3134.dbo.INVOICE;
SELECT * FROM DBP3134.dbo.LINE;

DELETE FROM DBP3134.dbo.LINE WHERE INV_NUMERIC = 1008 AND LINE_NUMERIC = 4;


/* Trigger statement should be the first statement in a query batch*/

USE DBP3134;

CREATE TRIGGER trg_line_total on  dbo.LINE
AFTER INSERT
AS
BEGIN
   
   DECLARE @LinePrice DECIMAL(10,2)
   DECLARE @LineUnits INT
   DECLARE @Invnumeric1 INT
   DECLARE @Linenumeric1 INT

   SELECT @LinePrice = inserted.LINE_PRICE, @LineUnits = inserted.LINE_UNITS, @Invnumeric1 = INV_NUMERIC, @Linenumeric1 = LINE_NUMERIC FROM inserted

   UPDATE DBP3134.dbo.LINE SET LINE_TOTAL = LINE_TOTAL + (@LinePrice * @LineUnits) WHERE INV_NUMERIC = @Invnumeric1 AND LINE_NUMERIC = @Linenumeric1;
 	     
END;

  /* Test the trigger using the following new LINE record, which would update the LINE_TOTAL which is the product of the LINE_UNITS and LINE_PRICE values.
1008,4,'13-Q2/P2', 2,   14.99,  NULL
 */

SELECT * FROM DBP3134.dbo.PRODUCT;
SELECT * FROM DBP3134.dbo.INVOICE;
SELECT * FROM DBP3134.dbo.LINE;

INSERT INTO DBP3134.dbo.LINE VALUES(1008,4,'13-Q2/P2', 2,   14.99, 0);

SELECT * FROM DBP3134.dbo.PRODUCT;
SELECT * FROM DBP3134.dbo.INVOICE;
SELECT * FROM DBP3134.dbo.LINE;



/* Problem 32.	Create a trigger named trg_line_prod that automatically updates the quantity on hand for each product sold after a new LINE row is added. */


DROP TRIGGER trg_line_prod;

SELECT * FROM DBP3134.dbo.PRODUCT;
SELECT * FROM DBP3134.dbo.LINE;

DELETE FROM DBP3134.dbo.LINE WHERE INV_NUMERIC = 1007 AND LINE_NUMERIC = 3;
UPDATE DBP3134.dbo.PRODUCT SET P_QOH = 15 WHERE P_CODE = '1546-QQ2';

SELECT * FROM DBP3134.dbo.LINE WHERE INV_NUMERIC = 1007;
SELECT * FROM DBP3134.dbo.PRODUCT WHERE P_CODE = '1546-QQ2';

/* Trigger statement should be the first statement in a query batch*/

USE DBP3134;

CREATE TRIGGER trg_line_prod on  dbo.LINE
AFTER insert
AS
BEGIN

	DECLARE @PQoh INT
	DECLARE @Pcode VARCHAR(15)
	

	SELECT @Pcode = inserted.P_CODE,  @PQoh = inserted.LINE_UNITS FROM inserted

	UPDATE DBP3134.dbo.PRODUCT SET P_QOH = P_QOH - @PQoh WHERE P_CODE = @Pcode;
	PRINT('* * Update Finished * *');

END;

/* Test the trigger */

SELECT * FROM DBP3134.dbo.PRODUCT WHERE P_CODE = '1546-QQ2';
SELECT * FROM DBP3134.dbo.LINE WHERE INV_NUMERIC = 1007;

INSERT INTO DBP3134.dbo.LINE VALUES(1007,3,'1546-QQ2', 2,   39.95, 79.90);

SELECT * FROM DBP3134.dbo.LINE WHERE INV_NUMERIC = 1007;
SELECT * FROM DBP3134.dbo.PRODUCT WHERE P_CODE = '1546-QQ2';


/* Problem 33.	Create a stored procedure named prc_inv_amounts to update the INV_SUBTOTAL, INV_TAX, and INV_TOTAL. The procedure takes the invoice number as a parameter. 
The INV_SUBTOTAL is the sum of the LINE_TOTAL amounts for the invoice, the INV_TAX is the product of the INV_SUBTOTAL and the tax rate (8 percent), and the INV_TOTAL is the sum of the INV_SUBTOTAL and the
INV_TAX. */

DROP PROCEDURE prc_invoice_amounts;

SELECT * FROM DBP3134.dbo.INVOICE WHERE INV_NUMERIC = 1001;
SELECT * FROM DBP3134.dbo.LINE WHERE INV_NUMERIC = 1001;

UPDATE DBP3134.dbo.INVOICE SET INV_SUBTOTAL = 24.90, INV_TAX = 1.99, INV_TOTAL = 0 WHERE INV_NUMERIC = 1001;

SELECT * FROM DBP3134.dbo.INVOICE WHERE INV_NUMERIC = 1001;
SELECT * FROM DBP3134.dbo.LINE WHERE INV_NUMERIC = 1001;

/* Creating the procedure */

CREATE PROCEDURE prc_invoice_amounts (@Invnum5 INTEGER)
AS
BEGIN
		UPDATE DBP3134.dbo.INVOICE 
		SET INV_SUBTOTAL = (SELECT SUM(LINE_TOTAL) FROM DBP3134.dbo.LINE WHERE INV_NUMERIC=@Invnum5);
		
		UPDATE DBP3134.dbo.INVOICE
		SET	INV_TAX = INV_SUBTOTAL*0.08
		WHERE INV_NUMERIC = @Invnum5;

		UPDATE DBP3134.dbo.INVOICE
		SET	INV_TOTAL = INV_SUBTOTAL +  INV_TAX
		WHERE INV_NUMERIC = @Invnum5;

END;

/* Execute the procedure  */

SELECT * FROM DBP3134.dbo.INVOICE WHERE INV_NUMERIC = 1001;
SELECT * FROM DBP3134.dbo.LINE WHERE INV_NUMERIC = 1001;

EXEC prc_invoice_amounts @Invnum5 = 1001;

SELECT * FROM DBP3134.dbo.INVOICE WHERE INV_NUMERIC = 1001;
SELECT * FROM DBP3134.dbo.LINE WHERE INV_NUMERIC = 1001;


/* Problem 34.	Create a procedure named prc_cus_balance_update that will take the invoice number as a parameter and update the customer balance. 
(Hint: You can use the DECLARE section to define a TOTINV numeric variable that holds the computed invoice total.)  */


DROP PROCEDURE prc_cus_balance_update;

SELECT * FROM DBP3134.dbo.INVOICE WHERE INV_NUMERIC = 1001;
SELECT * FROM DBP3134.dbo.CUSTOMER WHERE CUS_CODE = 10014;

UPDATE DBP3134.dbo.CUSTOMER SET CUS_BALANCE = 0 WHERE CUS_CODE = 10014;

/* create the procedure*/

CREATE PROCEDURE prc_cus_balance_update (@Invnum6 INTEGER)
AS
BEGIN
		DECLARE @CusCode INT;
		SELECT @CusCode = CUS_CODE FROM DBP3134.dbo.INVOICE WHERE INV_NUMERIC = @Invnum6; --Getting the cus code
		
		UPDATE DBP3134.dbo.CUSTOMER
		SET CUS_BALANCE = CUS_BALANCE + (SELECT INV_TOTAL FROM DBP3134.dbo.INVOICE WHERE INV_NUMERIC = @Invnum6)
		WHERE CUS_CODE = @CusCode;
		
END;

/* Execute the procedure*/

SELECT * FROM DBP3134.dbo.INVOICE WHERE INV_NUMERIC = 1001;
SELECT * FROM DBP3134.dbo.CUSTOMER WHERE CUS_CODE = 10014;

EXEC prc_cus_balance_update @Invnum6 = 1001;

SELECT * FROM DBP3134.dbo.INVOICE WHERE INV_NUMERIC = 1001;
SELECT * FROM DBP3134.dbo.CUSTOMER WHERE CUS_CODE = 10014;


 
 /*************************************************************************************/
/*End of file*/
/*************************************************************************************/