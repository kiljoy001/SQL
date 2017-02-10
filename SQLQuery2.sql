USE [model_db]
GO
/****** Object:  StoredProcedure [dbo].[insertUser]    Script Date: 2/8/2017 10:32:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[insertCompany]
	@fname nchar(60),
	@lname nchar(60),
	@password nchar(60),
	@phone nchar(11),
	@login nchar(60)
	
AS
BEGIN
	insert into site_login (user_password, user_fname, user_lname, user_phone_number, user_login, company_guid, user_type)
	values(@password, @fname, @lname, @phone, @login, NEWID(),'user' );
	SET NOCOUNT OFF;
END