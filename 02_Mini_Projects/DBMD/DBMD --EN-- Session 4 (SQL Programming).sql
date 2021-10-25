
--------SQL PROGRAMMING AND INDEXES

----------What is a Stored Procedure?
/*A stored procedure is a prepared SQL code that you can save, 
so the code can be reused over and over again.

So if you have an SQL query that you write over and over again, 
save it as a stored procedure, and then just call it to execute it.

You can also pass parameters to a stored procedure, 
so that the stored procedure can act based on the parameter value(s) that is passed.
*/

---------- ADVANTAGES
/*
Better Performance –
The procedure calls are quick and efficient as stored procedures are 
compiled once and stored in executable form.Hence the response is quick. 
The executable code is automatically cached, hence lowers the memory requirements.

Higher Productivity –
Since the same piece of code is used again and again so, it results in higher productivity.

Ease of Use –
To create a stored procedure, one can use any Java Integrated Development Environment (IDE). 
Then, they can be deployed on any tier of network architecture.

Scalability –
Stored procedures increase scalability by isolating application processing on the server.

Maintainability –
Maintaining a procedure on a server is much easier then maintaining copies on various client machines, 
this is because scripts are in one location.

Security –
Access to the Oracle data can be restricted by allowing users to manipulate the data only 
through stored procedures that execute with their definer’s privileges.
*/


----------QUERY TIME

---- BASIC PROCEDURE SYNTAX


CREATE PROC sp_sampleproc1
AS
BEGIN
	SELECT 'HELLO WORLD' 
END;


---- Methods of calling procedure

EXECUTE sp_sampleproc1

EXEC sp_sampleproc1

sp_sampleproc1


---- You can make any changes you want in the procedure by typing alter instead of create.


ALTER PROC sp_sampleproc1
AS
BEGIN
	PRINT 'QUERY COMPLETED' 
END;


sp_sampleproc1


-------- we create tables to use as an examples



CREATE TABLE ORDER_TBL 
(
ORDER_ID TINYINT NOT NULL,
CUSTOMER_ID TINYINT NOT NULL,
CUSTOMER_NAME VARCHAR(50),
ORDER_DATE DATE,
EST_DELIVERY_DATE DATE--estimated delivery date
);



INSERT ORDER_TBL VALUES (1, 1, 'Adam', GETDATE()-10, GETDATE()-5 ),
						(2, 2, 'Smith',GETDATE()-8, GETDATE()-4 ),
						(3, 3, 'John',GETDATE()-5, GETDATE()-2 ),
						(4, 4, 'Jack',GETDATE()-3, GETDATE()+1 ),
						(5, 5, 'Owen',GETDATE()-2, GETDATE()+3 ),
						(6, 6, 'Mike',GETDATE(), GETDATE()+5 ),
						(7, 6, 'Rafael',GETDATE(), GETDATE()+5 ),
						(8, 7, 'Johnson',GETDATE(), GETDATE()+5 )






SELECT * FROM ORDER_TBL





CREATE TABLE ORDER_DELIVERY
(
ORDER_ID TINYINT NOT NULL,
DELIVERY_DATE DATE -- completed delivery date
);



SET NOCOUNT ON
INSERT ORDER_DELIVERY VALUES (1, GETDATE()-6 ),
						(2, GETDATE()-2 ),
						(3, GETDATE()-2 ),
						(4, GETDATE() ),
						(5, GETDATE()+2 ),
						(6, GETDATE()+3 ),
						(7, GETDATE()+5 ),
						(8, GETDATE()+5 )





SELECT * FROM ORDER_DELIVERY




------ example of procedure


CREATE PROC sp_sumorder
AS
BEGIN
	
	SELECT COUNT (ORDER_ID) FROM Order_tbl

END;


sp_sumorder




---- example of procedure working with parameter
---- It will return the number of orders for the desired day.
---- @DAY parameter of procedure


CREATE PROC sp_wanted_dayorder ( @DAY DATE )
AS
BEGIN

	SELECT COUNT (ORDER_ID)
	FROM ORDER_TBL
	WHERE ORDER_DATE = @DAY

END;



SELECT * FROM ORDER_TBL



EXEC sp_wanted_dayorder '2021-08-12'



---- query parameters
---- It is defined by Declare. data type is determined, value can also be assigned.
---- Value is assigned with set or select.
---- These variables are determined for values ​​that are not constant, 
-- can change according to different situations, and can affect the query result.
--- For example, @p1 and @p2 parameters below may change according to the value we will give.
--- The @sum parameter can change according to @p1 and @p2.


DECLARE @P1 INT , @P2 INT , @SUM INT

SET @P1 = 5

SELECT @P2 = 4

SELECT @SUM = @P1+@P2

SELECT @SUM



---- You can assign a value for each of the variables with a separate set command.
--- but you can assign value to all of them with a single select command
--- you can also call the query result with Select or
--- You can print it as a string to the message window with print.



DECLARE @P1 INT , @P2 INT , @SUM INT


SELECT @P1 = 3 , @P2 = 7, @SUM = @P1+@P2

SELECT  @SUM


PRINT @SUM




--- mapping the variable to the column values ​​in the table
--- It will bring the customer information in the order_tbl table according 
--to the value to be entered into the parameter from outside.



DECLARE @CUST_ID INT

SET @CUST_ID = 5

SELECT  *
FROM ORDER_TBL
WHERE CUSTOMER_ID = @CUST_ID





--IF, ELSE IF, ELSE 


---- Let's look at how can change the customer_id when customer_id>3, customer_id<3, customer_id=3



DECLARE @CUST_ID INT


SET @CUST_ID = 3

IF @CUST_ID < 3
BEGIN
	SELECT *
	FROM ORDER_TBL
	WHERE	CUSTOMER_ID= @CUST_ID
END

ELSE IF @CUST_ID > 3
BEGIN
	SELECT *
	FROM ORDER_TBL
	WHERE	CUSTOMER_ID= @CUST_ID	
END

ELSE
	PRINT 'CUSTOMER ID EQUAL TO 3'




---- While

-- used to loop 
--- It ensures that the query is run repeatedly until the condition we wrote in the while statement is met.
-- It also requires a logical operation to repeat the loop, which is usually written at the end of the query.



DECLARE @NUM_OF_ITER INT = 50 , @COUNTER INT = 0

WHILE @NUM_OF_ITER > @COUNTER
BEGIN
	SELECT @COUNTER
	SET @COUNTER = @COUNTER + 1  --@COUNTER += 1
END



/////////////////////////////

----Functions

/*A table-valued function is a user-defined function that returns data of a table type. 
The return type of a table-valued function is a table, therefore, 
you can use the table-valued function just like you would use a table.


SQL Server scalar function takes one or more parameters and returns a single value.
The scalar functions help you simplify your code. For example, you may have a complex calculation 
that appears in many queries. Instead of including the formula in every query, 
you can create a scalar function that encapsulates the formula and uses it in each query.
*/


--- A table valued function

-- It creates a table that we can use like a table in From statement.
--- We cannot use the store procedure as a table. We just run it and get the result.
--- table valued functions allow us to use tables unlike SPs.
--- It actually saves a table that we have reached as a result of many sequences of operations as a function. 
-- When we run the function, all processes run behind and return to us as a table.
---- don't use begin and end



CREATE FUNCTION fn_order_detail (@DATE DATE)
RETURNS TABLE
AS
	RETURN SELECT * FROM ORDER_TBL WHERE ORDER_DATE = @DATE


SELECT * FROM dbo.fn_order_detail('2021-08-17')



----- Scalar valued function


----It returns a single value.
--- The returned value can be used in different places, the function can be called wherever desired.
--- Functions produce a result according to the input parameter they receive or make a change 
--on the input parameter.


CREATE FUNCTION fn_uppertext
(
	@inputtext varchar(max)
)
RETURNS VARCHAR(MAX)
AS
BEGIN

	RETURN UPPER(@inputtext)

END


SELECT dbo.fn_uppertext('whatsapp')


SELECT dbo.fn_uppertext(customer_name) FROM ORDER_TBL


/////////////////////////////////////

----------TRIGGERS
/*
DML triggers is a special type of stored procedure that automatically 
takes effect when a data manipulation language (DML) event takes place that affects 
the table or view defined in the trigger. DML events include INSERT, UPDATE, or DELETE statements. 
DML triggers can be used to enforce business rules and data integrity, query other tables, 
and include complex Transact-SQL statements. The trigger and the statement that fires 
it are treated as a single transaction, which can be rolled back from within the trigger. 
If a severe error is detected (for example, insufficient disk space), 
the entire transaction automatically rolls back.

AFTER trigger
AFTER triggers are executed after the action of the INSERT, UPDATE, MERGE, or DELETE statement is performed. 
AFTER triggers are never executed if a constraint violation occurs; therefore, 
these triggers cannot be used for any processing that might prevent constraint violations. 
For every INSERT, UPDATE, or DELETE action specified in a MERGE statement, 
the corresponding trigger is fired for each DML operation.

INSTEAD OF trigger
INSTEAD OF triggers override the standard actions of the triggering statement. 
Therefore, they can be used to perform error or value checking on one or 
more columns and the perform additional actions before insert, updating or deleting the row or rows. 
For example, when the value being updated in an hourly wage column in a payroll table exceeds a specified value, 
a trigger can be defined to either produce an error message and roll back the transaction, 
or insert a new record into an audit trail before inserting the record into the payroll table. 
The primary advantage of INSTEAD OF triggers is that they enable views that 
would not be updatable to support updates. 
For example, a view based on multiple base tables must use an INSTEAD OF trigger to support inserts, 
updates, and deletes that reference data in more than one table. 
Another advantage of INSTEAD OF triggers is that they enable you to code 
logic that can reject parts of a batch while letting other parts of a batch to succeed.

*/


////////////////////////////

--------- DATABASE INDEXES
/*

-- There are several different scanning methods, the query planner tries to bring the 
query result using the most appropriate one.

-- The correct scanning method to use is highly dependent on the use case and 
the state of the database at the time of scanning.







A clustered index defines the order in which data is physically stored in a table. 
Table data can be sorted in only way, therefore, there can be only one clustered index per table. 
In SQL Server, the primary key constraint automatically creates a clustered index on that particular column.



A non-clustered index doesn’t sort the physical data inside the table. 
In fact, a non-clustered index is stored at one place and table data is stored in another place. 
This is similar to a textbook where the book content is located in one place and the index is located in another. 
This allows for more than one non-clustered index per table.

*/

-- we create table 

create table website_visitor 
(
visitor_id int,
ad varchar(50),
soyad varchar(50),
phone_number bigint,
city varchar(50)
);

---  We are throwing random data into the table, it is out of our subject.

DECLARE @i int = 1
DECLARE @RAND AS INT
WHILE @i<200000
BEGIN
	SET @RAND = RAND()*81
	INSERT website_visitor
		SELECT @i , 'visitor_name' + cast (@i as varchar(20)), 'visitor_surname' + cast (@i as varchar(20)),
		5326559632 + @i, 'city' + cast(@RAND as varchar(2))
	SET @i +=1
END;


--- we check top 10

SELECT top 10*
FROM
website_visitor


--- We open statistics (Process and time), you don't have to open it, we just opened it to see the details of the transactions.

SET STATISTICS IO on
SET STATISTICS TIME on


--- Without any index, we condition the visitor_id and call the whole table


SELECT *
FROM
website_visitor
where
visitor_id = 100

--- When you look at the execution plan, you will see Table Scan, that is, it searches the entire table by looking at all the values ​​one by one.


-- We create an index on the visitor_id

Create CLUSTERED INDEX CLS_INX_1 ON website_visitor (visitor_id);



SELECT visitor_id
FROM
website_visitor
where
visitor_id = 100




SELECT *
FROM
website_visitor
where
visitor_id = 100





















































































