--truy vấn đơn giản_w3_lab
--mở bảng 

use QLDETAI 

--q1
select HOTEN, LUONG from GIAOVIEN where PHAI = N'Nữ'

--q2
select HOTEN, LUONG * 1.1 'LUONG TANG 10%'
from GIAOVIEN 

--q3
select distinct MAGV 
from GIAOVIEN as gv join BOMON as bm on gv.MABM = bm.MABM
where (HOTEN like N'Nguyễn %' and LUONG > 2000) or (gv.MAGV = bm.TRUONGBM and datediff(year, NGAYNHANCHUC, '1995-12-31') < 0)

--q4
select gv.HOTEN
from GIAOVIEN as gv join BOMON as bm on gv.MABM = bm.MABM
where MAKHOA = 'CNTT'

--q5
select distinct bm.*, gv.*
from BOMON as bm join GIAOVIEN as gv on gv.MABM = bm.MABM
where gv.MAGV = bm.TRUONGBM
--kết quả của 005 không hiện vì khác mã bộ môn

--q6
select distinct gv.HOTEN, bm.*
from BOMON as bm join GIAOVIEN as gv on gv.MABM = bm.MABM

--q7
select dt.TENDT, gv.HOTEN
from DETAI as dt join GIAOVIEN as gv on GVCNDT = MAGV

--q8
select distinct k.*, gv.*
from KHOA as k join GIAOVIEN as gv on k.TRUONGKHOA = gv.MAGV

--q9
select gv.*, bm.TENBM, tgdt.MADT
from GIAOVIEN as gv join BOMON as bm on gv.MABM = bm.MABM
					join THAMGIADT as tgdt on gv.MAGV = TGDT.MADT
where TENBM = N'Vi sinh' and MADT = '006'

--q10
select gv.HOTEN, gv.NGSINH, gv.DIACHI, dt.MADT, cd.TENCD
from DETAI as dt join GIAOVIEN as gv on gv.MAGV = dt.GVCNDT
				 join CHUDE as cd on cd.MACD = dt.MACD
where dt.CAPQL = N'Thành phố'

--q11
select gv.HOTEN as TENGV, ql.*
from GIAOVIEN as gv left join GIAOVIEN as ql on gv.GVQLCM = ql.MAGV 

--q12
select gv.HOTEN as TENGV, ql.HOTEN as TENGVQLCM
from GIAOVIEN as gv join GIAOVIEN as ql on gv.GVQLCM = ql.MAGV 
where ql.MAGV = gv.GVQLCM and ql.HOTEN = N'Nguyễn Thanh Tùng' --dữ liệu không có ai tên này nên kết quả không có

--q13
select HOTEN, TENBM
from GIAOVIEN as gv join BOMON as bm on gv.MABM = bm.MABM
where TENBM = N'Hệ thống thông tin' and gv.MAGV = bm.TRUONGBM

--q15
select TENCV, TENDT, CAPQL
from DETAI as dt join CONGVIEC as cv on dt.MADT = cv.MADT
where cv.NGAYBD between '2008/03/01' and '2008/03/31' and dt.TENDT = N'HTTT quản lý các trường ĐH'

--q16
select gv.HOTEN as TENGV, ql.HOTEN as TENGVQLCM
from GIAOVIEN as gv join GIAOVIEN as ql on gv.GVQLCM = ql.MAGV 

--q17
select TENCV
from CONGVIEC 
where NGAYBD between '2007/01/01' and '2007/08/01'

--q18
select gv.HOTEN 
from GIAOVIEN gv, GIAOVIEN gv2
where gv2.HOTEN = N'Trần Trà Hương' and gv.MABM = gv2.MABM and gv.HOTEN != N'Trần Trà Hương'

--q19
select distinct gv.*, bm.TENBM, dt.GVCNDT
from GIAOVIEN as gv join BOMON as bm on gv.MABM = bm.MABM
					join DETAI as dt on gv.MAGV = dt.GVCNDT
where bm.TRUONGBM = dt.GVCNDT

--q20
select* from BOMON
select gv.*
from BOMON bm join GIAOVIEN gv on gv.MABM = bm.MABM
				 join KHOA k on bm.MAKHOA = k.MAKHOA
where gv.MAGV = k.TRUONGKHOA and gv.MAGV = bm.TRUONGBM 

--q21
select distinct gv.HOTEN, bm.TENBM, dt.GVCNDT
from GIAOVIEN as gv join BOMON as bm on gv.MABM = bm.MABM
					join DETAI as dt on gv.MAGV = dt.GVCNDT
where bm.TRUONGBM = dt.GVCNDT

--q22
select distinct gv.MAGV
from GIAOVIEN as gv join KHOA as k on gv.MAGV = k.TRUONGKHOA
					join DETAI as dt on gv.MAGV = dt.GVCNDT

--q23
select distinct gv.MAGV
from GIAOVIEN as gv join BOMON as bm on gv.MABM = bm.MABM
				 left join DETAI as dt on gv.MAGV = dt.GVCNDT --join cái này thì không xuất hiện 003, phải left join để trích toàn bộ data của giaovien
where gv.MABM = N'HTTT' or MADT = '001'

select * from GIAOVIEN

--q24
select gv.*
from GIAOVIEN gv, GIAOVIEN gv2
where gv2.MAGV = '002' and gv.MABM = gv2.MABM and gv.MAGV != '002'

--q25
select gv.*
from GIAOVIEN as gv join BOMON as bm on gv.MABM = bm.MABM
where gv.MAGV = bm.TRUONGBM

--q26
select HOTEN, LUONG
from GIAOVIEN

--HÀM GOM NHÓM KẾT HỢP

--q27
select count(distinct MAGV) 'SLGV', sum(LUONG) 'TONGLUONG'
from GIAOVIEN 

--q28
select bm.TENBM, count(distinct gv.MAGV) 'SLGV', avg(gv.LUONG) 'LUONGTB'
from GIAOVIEN gv join BOMON bm on gv.MABM = bm.MABM
group by bm.TENBM

--q29
select cd.TENCD, count(dt.MADT) 'SLDT'
from CHUDE cd join DETAI dt on cd.MACD = dt.MACD
group by TENCD

--q30
select gv.HOTEN, count(distinct tgdt.MADT) 'SLDT'
from GIAOVIEN gv join THAMGIADT tgdt on gv.MAGV = tgdt.MAGV
group by gv.HOTEN --phải group by thuộc tính được select mà không xài hàm, vd như group by gv.MAGV thì lỗi

--q31
select gv.HOTEN, count(dt.GVCNDT) 'SLDT'
from GIAOVIEN gv join DETAI dt on gv.MAGV = dt.GVCNDT
group by gv.HOTEN

--q32
select gv.HOTEN, count (nt.TEN) 'SLNT'
from GIAOVIEN gv join NGUOITHAN nt on gv.MAGV = nt.MAGV
group by gv.HOTEN

--q33: THEM DISTINCT 
select gv.HOTEN, count (DISTINCT tgdt.MADT) 'SLDT' 
from GIAOVIEN gv join THAMGIADT tgdt on gv.MAGV = tgdt.MAGV
--where count (tgdt.MADT) > 3 => Lỗi vì where không dùng với hàm => xài having
group by gv.HOTEN
having count (tgdt.MADT) > 3

--q34: THÊM DISTINCT
select dt.TENDT, count(DISTINCT tgdt.MADT) 'SLGV'
from GIAOVIEN gv join THAMGIADT tgdt on gv.MAGV = tgdt.MAGV
			     join DETAI dt on tgdt.MADT = dt.MADT
where dt.TENDT = N'Ứng dụng hóa học xanh' --đề tài này không có ai tham gia
--where dt.TENDT = N'Nghiên cứu tế bào gốc'
group by dt.TENDT



