


CREATE PROC sp_sampleproc_1
AS
BEGIN
	SELECT 'HELLO WORLD'

END;

EXECUTE sp_sampleproc_1

EXEC sp_sampleproc_1

sp_sampleproc_1



---



ALTER PROC sp_sampleproc_1
AS
BEGIN
	SELECT 'QUERY COMPLETED' RESULT

END;

sp_sampleproc_1


-----



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
DELIVERY_DATE DATE -- tamamlanan delivery date
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



CREATE PROC sp_sumorder
AS
BEGIN
	
	SELECT COUNT (ORDER_ID) FROM Order_tbl

END;


sp_sumorder


-----


CREATE PROC sp_wanted_dayorder ( @DAY DATE )
AS
BEGIN

	SELECT COUNT (ORDER_ID)
	FROM ORDER_TBL
	WHERE ORDER_DATE = @DAY

END;

SELECT * FROM ORDER_TBL


EXEC sp_wanted_dayorder '2021-08-12'



-----


DECLARE @P1 INT , @P2 INT , @SUM INT

SET @P1 = 5

SELECT @P2 = 4

SELECT @SUM = @P1+@P2

SELECT @SUM


------



DECLARE @P1 INT , @P2 INT , @SUM INT


SELECT @P1 = 3 , @P2 = 7, @SUM = @P1+@P2

SELECT  @SUM


PRINT @SUM


----


DECLARE @CUST_ID INT

SET @CUST_ID = 5

SELECT  *
FROM ORDER_TBL
WHERE CUSTOMER_ID = @CUST_ID



-----


--3 TEN KÜÇÜKSE
--3' E EÞÝTSE
--3' TEN BÜYÜKSE


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



---WHILE


DECLARE @NUM_OF_ITER INT = 50 , @COUNTER INT = 0

WHILE @NUM_OF_ITER > @COUNTER
BEGIN
	SELECT @COUNTER
	SET @COUNTER = @COUNTER + 1  --@COUNTER += 1
END




---FUNCTIONS


--scalar valued function


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


-----

--table valued function
--BEGIN END KALIBI KULLANILAMAZ



CREATE FUNCTION fn_order_detail (@DATE DATE)
RETURNS TABLE
AS
	RETURN SELECT * FROM ORDER_TBL WHERE ORDER_DATE = @DATE


SELECT * FROM dbo.fn_order_detail('2021-08-17')



----triggers



----BÝR ORDER' IN GEÇ MÝ ERKEN MÝ YOKSA ZAMANINDA MI ULAÞTIÐINI DÖNDÜREN BÝR FONKSÝYON TANIMLAMAK ÝSTÝYORUM

alter FUNCTION dbo.statusofdelivery
(
	@order_id int
)
RETURNS varchar(20)
AS
BEGIN

DECLARE @EST_DATE DATE
DECLARE @DEL_DATE DATE
DECLARE @STATUS varchar(20)

SELECT @EST_DATE= EST_DELIVERY_DATE FROM ORDER_TBL WHERE ORDER_ID=@order_id

SET @DEL_DATE = (SELECT DELIVERY_DATE FROM ORDER_DELIVERY WHERE ORDER_ID= @order_id)

	IF  @EST_DATE < @DEL_DATE

		SET @STATUS = 'LATE'

	ELSE IF @EST_DATE = @DEL_DATE
		
		SET @STATUS = 'ON TIME'

	ELSE 
		SET @STATUS = 'EARLY'

	RETURN @STATUS
END




SELECT * from ORDER_TBL WHERE dbo.statusofdelivery(ORDER_ID) ='EARLY'



CREATE TABLE ON_TIME_ORDER
(
ORDER_ID INT,
DELIVERY_STATUS VARCHAR(10),
CONSTRAINT check_status CHECK (dbo.statusofdelivery(ORDER_ID) = 'ON TIME')
)



create trigger insert_trg_order
on ORDER_TBL
after insert
as
begin
	print 'New record inserted'
end

insert into ORDER_TBL values(9,8, 'Sam', GETDATE(), GETDATE()+4)


----------------


---DML TRIGGERS


create trigger update_trg_order
on ORDER_TBL
after UPDATE
as
begin
	print 'Updated Successfully'
end




--- bir order zamanýnda teslim edilmiþse on time order tablosuna bunu anýnda insert edelim.

ALTER TRIGGER insert_trg_order2
ON ORDER_DELIVERY
AFTER INSERT
AS
BEGIN
	
	DECLARE @ORDER_ID INT, @DEL_STATUS VARCHAR(10)

	SELECT @ORDER_ID = ORDER_ID FROM inserted
	SELECT @DEL_STATUS = (SELECT dbo.typeofdelivery(@ORDER_ID))

	IF @DEL_STATUS = 'ON TIME'
		INSERT ON_TIME_ORDER (ORDER_ID, DELIVERY_STATUS) VALUES (@ORDER_ID, @DEL_STATUS)
END



--insert into ORDER_TBL values(9,8, 'Sam', GETDATE(), GETDATE()+4)

INSERT INTO ORDER_DELIVERY (ORDER_ID, DELIVERY_DATE) 
VALUES (9, GETDATE()+4)



SELECT * FROM  ON_TIME_ORDER








