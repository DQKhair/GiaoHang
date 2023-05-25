go
create procedure KiemTraChucNang
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
exec KiemTraChucNang 1