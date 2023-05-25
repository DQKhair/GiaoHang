USE [Giao Hàng]
GO

/****** Object:  StoredProcedure [dbo].[KiemTraChucNang]    Script Date: 3/25/2023 8:25:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[KiemTraChucNang]
@maChucVu int
as
begin
select cn.*
from [Chức vụ] cv
join [Phân quyền] pq on cv.[Mã chức vụ]=pq.[Mã chức vụ]
join [Phân chức năng] pcn on pq.[Mã quyền]=pcn.[Mã quyền]
join [Chức năng] cn on cn.[Mã chức năng] = pcn.[Mã chức năng]
where cv.[Mã chức vụ]= @maChucVu
order by cn.[Mã chức năng]

end
GO

