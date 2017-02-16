use master ;
go
create database Sales1977_log
on
( NAME = Sales1977_dat,  
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Sales1977.mdf',  
    SIZE = 5,  
    MAXSIZE = 10,  
    FILEGROWTH = 5 )
	log on (name = Sales1977_log,
	filename = 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Sales1977.ldf',
	size= 2,
	maxsize = 3)   