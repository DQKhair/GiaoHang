USE [Giao Hàng]
GO

/****** Object:  StoredProcedure [dbo].[KiemTraDangNhap]    Script Date: 3/25/2023 8:26:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[KiemTraDangNhap]
@user varchar(100),@pass varchar(100)
as
begin
	declare @temp int;
	select @temp = count([Mã nhân viên])
	from [Tài khoản]
	where [Tài khoản]=@user and [Mật khẩu]=@pass

	return @temp
end
GO

