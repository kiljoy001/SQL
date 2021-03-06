USE [model_db]
GO
/****** Object:  StoredProcedure [dbo].[insertUser]    Script Date: 2/8/2017 10:32:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
alter proc [dbo].[insertUser]

	@fname		nvarchar(60),
	@lname		nvarchar(60),
	@password	nvarchar(60),
	@phone		nvarchar(11),
	@login		nvarchar(60),
	@cname		nvarchar(255),
	@ctitle		nvarchar(60),
	@caddr		nvarchar(255),
	@czip		nvarchar(6),
	@cstate		nvarchar(2),
	@city		nvarchar(60)

AS
BEGIN
	insert into site_login (
	user_password,
	user_fname, 
	user_lname, 
	user_phone_number, 
	user_login, 
	user_type, 
	user_cname, 
	user_ctitle, 
	user_czip, 
	user_cstate,
	user_caddr, 
	user_city
	)
	values(
	@password, 
	@fname, 
	@lname, 
	@phone, 
	@login,
	'user',
	@cname, 
	@ctitle, 
	@czip,
	@cstate,
	@caddr,
	@city
	 );
	SET NOCOUNT OFF;
END