create database [Giao Hàng]
use [Giao Hàng]
create table [Quyền](
	[Mã quyền] int primary key,
	[Tên quyền] nvarchar(1000)
)
create table [Chức vụ](
	[Mã chức vụ] int primary key,
	[Tên chức vụ] nvarchar(1000)
)
create table [Phân quyền](
	[Mã phân quyền] int primary key,
	[Mã quyền] int,
	[Mã chức vụ] int
)
create table [Chức năng](
	[Mã chức năng] int primary key,
	[Tên chức năng] nvarchar(1000)
)
create table [Phân chức năng](
	[Mã quyền] int,
	[Mã chức năng] int,
	primary key([Mã quyền],[Mã chức năng])
)
create table [Nhân viên](
	[Mã nhân viên] int primary key,
	[Tên nhân viên] nvarchar(100),
	[Mã chức vụ] int
)
create table [Tài khoản](
	[Mã nhân viên] int primary key,
	[Tài khoản] varchar(100),
	[Mật khẩu] varchar(100),
	foreign key ([Mã nhân viên]) references [Nhân viên]([Mã nhân viên])
)