USE [model_db]
GO
/****** Object:  StoredProcedure [dbo].[insertUser]    Script Date: 2/8/2017 10:32:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[insertUser]
	@fname		nchar(60),
	@lname		nchar(60),
	@password	nchar(60),
	@phone		nchar(11),
	@login		nchar(60),
	@cname		nchar(255),
	@ctitle		nchar(60),
	@caddr		nchar(255),
	@czip		nchar(6),
	@cstate		nchar(2)

AS
BEGIN
	insert into Company(company_name, company_title, company_address_street, company_state, company_zcode, company_number, NEWID())
	values(@cname, @ctitle, @caddr, @cstate, @czip, @phone);
	insert into site_login (user_password, user_fname, user_lname, user_phone_number, user_login, user_type)
	values(@password, @fname, @lname, @phone, @login,'user' );
	SET NOCOUNT OFF;
END