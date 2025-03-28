--1. Käivita iga lause SQL Serveris
--2. Kommenteeri neid antud failis
--3. Tee uus branch iga SQL lausete teemade kohta
--3a. Tee Git commit iga SQL lause kohta.
--4. pane tabelite screen'id ja/või SQL tulemused readme faili
--5. Moodlesse lisa oma repo public link

-- db loomine
create database Tarpv24

--db kasutamine
DRop DataBASE Tarpv24

--tabeli Gender loomine
create table Gender
(
Id int NOT NULL primary key,
Gender nvarchar(10) not null
)

create table Person
(
Id int not null primary key,
Name nvarchar(25),
Email nvarchar(30),
GenderId int
)

--- andmete sisestamine tabelisse
insert into Gender (Id, Gender)
values (1, 'Female')
insert into Gender (Id, Gender)
values (2, 'Male')

--- Tabeli muutmine võõrvõtme määramise ja sellele piirangu andmisega
alter table Person add constraint tblPerson_GenderId_FK
foreign key (GenderId) references Gender(Id)


-- Sisestage andmed Person tabelisse
insert into Person (Id, Name, Email, GenderId)
values (1, 'Supermees', 's@s.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (2, 'Wonderwoman', 'w@w.com', 1)
insert into Person (Id, Name, Email, GenderId)
values (3, 'Batman', 'b@b.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (4, 'Aquaman', 'a@a.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (5, 'Catwoman', 'c@c.com', 1)
insert into Person (Id, Name, Email, GenderId)
values (6, 'Antman', 'ant"ant.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (7, 'Spiderman', 'spider@spiderman.com', 2)

-- vaatame tabeli andmeid
select * from Person

--- Tabeli muutmine piirangu kustutamisega
alter table Person
drop constraint tblPerson_GenderId_FK

-- Sisestage andmed Gender tabelisse
insert into Gender (Id, Gender)
values (3, 'Unknown')

-- lisame võõrvõtme uuesti
alter table Person
add constraint DF_Person_GenderId
default 3 for GenderId


select * from Person
select * from Gender

insert into Person (Id, Name, Email)
values (8, 'Test', 'Test')

--- Vanuse veeru lisamine tabelisse Person
alter table Person
add Age nvarchar(10)

--uuendame andmeid
update Person
set Age = 149
where Id = 8

-- Tabeli muutmine sisestatud vanuste piirangu kehtestamisega
alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 150)

insert into Person (Id, Name, Email, GenderId, Age)
values (9, 'Test', 'Test', 2, 160)

--ID 8-ga isiku eemaldamine laualt Person
select * from Person
go
delete from Person where Id = 8
go
select * from Person

--- lisame veeru juurde
alter table Person
add City nvarchar(25)

-- Näita inimesi tabelist Person, kelle linn on võrdne Gotham
select * from Person where City = 'Gotham'


-- kõik, kes ei ela Gothamis
select * from Person where City <> 'Gotham'
select * from Person where City != 'Gotham'

-- Näidake tabelist inimesi Person, kelle vanus on 100 või 50 või 20 aastat
select * from Person where Age = 100 or Age = 50 or Age = 20
select * from Person where Age in (100, 50, 20)


--- Näidake tabelist inimesi Person kelle linn algab tähega n ja näidake inimesi, kelle e-posti aadress sisaldab @
select * from Person where City like 'n%'
select * from Person where Email like '%@%'

-- Näidake tabelist inimesi Person kes pole @-kirjas
select * from Person where Email not like '%@%'

--- näitab, kelle on emailis ees ja peale @-märki
-- ainult üks täht
select * from Person where Email like '_@_.com'

-- Näitab inimesi, kelle nime WAS-is ei kuvata
select * from Person where Name like '[^WAS]%'

--- Näidake tabelist inimesi Person kelle linn on võrdne Gotham või New York ja kelle vanus on 40
select * from Person where (City = 'Gotham' or City = 'New York')
and Age >= 40

---võtab kolm esimest rida
select top 3 * from Person

--- Näitab kogu tabelit Person ja esimesed 3 vanusereas ja esimesed 3 nimes
select * from Person
select top 3 Age, Name from Person

--- Näitab 50% tabeli koguandmete ridadest Person
select top 50 percent * from Person

-- Sorteerib read tabelist Person veeru Age järgi
select * from Person order by cast(Age as int)

-- Sorteerib tabelist read Person veeru Age järgi
select * from Person order by Age

--- Arvutab kõigi veerus Age olevate väärtuste summa
select sum(cast(Age as int)) from Person

-- Määrab veeru Age minimaalse väärtuse.
select min(cast(Age as int)) from Person

-- Määrab veeru Age maksimaalse väärtuse.
select max(cast(Age as int)) from Person

--- Iga kordumatu linna jaoks arvutab vanuse väärtuste summa ja kuvab selle koguvana.
select City, sum(cast(Age as int)) as TotalAge from Person group by City


--- loome uued tabelid
create table Department
(
Id int primary key,
DepartmentName nvarchar(50),
Location nvarchar(50),
DepartmentHead nvarchar(50)
)

create table Employees
(
Id int primary key,
Name nvarchar(50),
Gender nvarchar(10),
Salary nvarchar(50),
DepartmentId int
)

-- Andmete lisamine tabelisse Department
insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (1, 'IT', 'London', 'Rick')
insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (2, 'Payroll', 'Delhi', 'Ron')
insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (3, 'HR', 'New York', 'Christie')
insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (4, 'Other Deparment', 'Sydney', 'Cindrella')

select * from Department

insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (1, 'Tom', 'Male', 4000, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (2, 'Pam', 'Female', 3000, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (3, 'John', 'Male', 3500, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (4, 'Sam', 'Male', 4500, 2)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (5, 'Todd', 'Male', 2800, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (6, 'Ben', 'Male', 7000, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (7, 'Sara', 'Female', 4800, 3)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (8, 'Valarie', 'Female', 5500, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (9, 'James', 'Male', 6500, NULL)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (10, 'Russell', 'Male', 8800, NULL)

select * from Employees

---?
select distinct Name, DepartmentId from Employees

---?
select sum(cast(Salary as int)) from Employees
---?
select min(cast(Salary as int)) from Employees


alter table Employees
add City nvarchar(25)


alter table Employees
add DepartmentId
int null


--?
alter table Employees
add MiddleName nvarchar(30)

alter table Employees
add LastName nvarchar(30)

update Employees set FirstName = 'Tom', MiddleName = 'Nick', LastName = 'Jones'
where Id = 1
update Employees set FirstName = 'Pam', MiddleName = NULL, LastName = 'Anderson'
where Id = 2
update Employees set FirstName = 'John', MiddleName = NULL, LastName = NULL
where Id = 3
update Employees set FirstName = 'Sam', MiddleName = NULL, LastName = 'Smith'
where Id = 4
update Employees set FirstName = NULL, MiddleName = 'Todd', LastName = 'Someone'
where Id = 5
update Employees set FirstName = 'Ben', MiddleName = 'Ten', LastName = 'Sven'
where Id = 6
update Employees set FirstName = 'Sara', MiddleName = NULL, LastName = 'Connor'
where Id = 7
update Employees set FirstName = 'Valarie', MiddleName = 'Balerine', LastName = NULL
where Id = 8
update Employees set FirstName = 'James', MiddleName = '007', LastName = 'Bond'
where Id = 9
update Employees set FirstName = NULL, MiddleName = NULL, LastName = 'Crowe'
where Id = 10


--- igast reast võtab esimeses veerus täidetud lahtri ja kuvab ainult seda
select Id, coalesce(FirstName, MiddleName, LastName) as Name
from Employees

select * from Employees
select * from Department
