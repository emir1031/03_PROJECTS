
----------INSERT

----!!! ilgili kolonun özelliklerine ve kýsýtlarýna uygun veri girilmeli !!!


-- Insert iþlemi yapacaðýnýz tablo sütunlarýný aþaðýdaki gibi parantez içinde belirtebilirsiniz.
-- Bu kullanýmda sadece belirttiðiniz sütunlara deðer girmek zorundasýnýz. Sütun sýrasý önem arz etmektedir.

INSERT INTO Person.Person (Person_ID, Person_Name, Person_Surname) VALUES (75056659595,'Zehra', 'Tekin')

INSERT INTO Person.Person (Person_ID, Person_Name) VALUES (889623212466,'Kerem')


--Eðer bir tablodaki tüm sütunlara insert etmeyecekseniz, seçtiðiniz sütunlarýn haricindeki sütunlar Nullable olmalý.
--Eðer Not Null constrainti uygulanmýþ sütun varsa hata verecektir.

--Aþaðýda Person_Surname sütununa deðer girilmemiþtir. 
--Person_Surname sütunu Nullable olduðu için Person_Surname yerine Null deðer atayarak iþlemi tamamlar.

INSERT INTO Person.Person (Person_ID, Person_Name) VALUES (78962212466,'Kerem')

--Insert edeceðim deðerler tablo kýsýtlarýna ve sütun veri tiplerine uygun olmazsa aþaðýdaki gibi iþlemi gerçekleþtirmez.


--Insert keywordunden sonra Into kullanmanýza gerek yoktur.
--Ayrýca Aþaðýda olduðu gibi insert etmek istediðiniz sütunlarý belirtmeyebilirsiniz. 
--Buna raðmen sütun sýrasýna ve yukarýdaki kurallara dikkat etmelisiniz.
--Bu kullanýmda tablonun tüm sütunlarýna insert edileceði farz edilir ve sizden tüm sütunlar için deðer ister.

INSERT Person.Person VALUES (15078893526,'Mert','Yetiþ')

--Eðer deðeri bilinmeyen sütunlar varsa bunlar yerine Null yazabilirsiniz. 
--Tabiki Null yazmak istediðiniz bu sütunlar Nullable olmalýdýr.

INSERT Person.Person VALUES (55556698752, 'Esra', Null)



--Ayný anda birden fazla kayýt insert etmek isterseniz;

INSERT Person.Person VALUES (35532888963,'Ali','Tekin');-- Tüm tablolara deðer atanacaðý varsayýlmýþtýr.
INSERT Person.Person VALUES (88232556264,'Metin','Sakin')


--Ayný tablonun ayný sütunlarýna birçok kayýt insert etmek isterseniz aþaðýdaki syntaxý kullanabilirsiniz.
--Burada dikkat edeceðiniz diðer bir konu Mail_ID sütununa deðer atanmadýðýdýr.
--Mail_ID sütunu tablo oluþturulurken identity olarak tanýmlandýðý için otomatik artan deðerler içerir.
--Otomatik artan bir sütuna deðer insert edilmesine izin verilmez.

INSERT INTO Person.Person_Mail (E_Mail, Person_ID) 
VALUES ('zehtek@gmail.com', 75056659595),
	   ('meyet@gmail.com', 15078893526),
	   ('metsak@gmail.com', 35532558963)

--Yukarýdaki syntax ile aþaðýdaki fonksiyonlarý çalýþtýrdýðýnýzda,
--Yaptýðýnýz son insert iþleminde tabloya eklenen son kaydýn identity' sini ve tabloda etkilenen kayýt sayýsýný getirirler.
--Not: fonksiyonlarý teker teker çalýþtýrýn.

SELECT @@IDENTITY--last process last identity number
SELECT @@ROWCOUNT--last process row count



--Aþaðýdaki syntax ile farklý bir tablodaki deðerleri daha önceden oluþturmuþ olduðunuz farklý bir tabloya insert edebilirsiniz.
--Sütun sýrasý, tipi, constraintler ve diðer kurallar yine önemli.

select * into Person.Person_2 from Person.Person-- Person_2 þeklinde yedek bir tablo oluþturun


INSERT Person.Person_2 (Person_ID, Person_Name, Person_Surname)
SELECT * FROM Person.Person where Person_name like 'M%'


--Aþaðýdaki syntaxda göreceðiniz üzere hiçbir deðer belirtilmemiþ. 
--Bu þekilde tabloya tablonun default deðerleriyle insert iþlemi yapýlacaktýr.
--Tabiki sütun constraintleri buna elveriþli olmalý. 

INSERT Book.Publisher
DEFAULT VALUES



--update