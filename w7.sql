﻿--w7

USE QLDETAI
--a
SELECT GV.MAGV, GV.HOTEN, QL.HOTEN AS 'GVQL'
FROM GIAOVIEN GV LEFT JOIN GIAOVIEN QL ON GV.GVQLCM = QL.GVQLCM

--b: CHÚ Ý LEFT JOIN Ở GIAOVIEN GV
SELECT BM.MABM, BM.TENBM,TBM.HOTEN 'TRUONGBM', COUNT(GV.MAGV) 'SLGV'
FROM BOMON BM LEFT JOIN GIAOVIEN TBM ON BM.TRUONGBM = TBM.MAGV
			  LEFT JOIN GIAOVIEN GV ON GV.MABM = BM.MABM
GROUP BY BM.MABM, BM.TENBM, TBM.HOTEN

--c
SELECT GV.*, CV.*
FROM CONGVIEC CV RIGHT JOIN THAMGIADT TG ON CV.SOTT = TG.STT AND CV.MADT = TG.MADT
					   JOIN GIAOVIEN GV ON GV.MAGV = TG.MAGV
WHERE GV.PHAI = 'Nam'
ORDER BY CV.MADT ASC

--d
SELECT GV.*, CV.*
FROM CONGVIEC CV RIGHT JOIN THAMGIADT TG ON CV.SOTT = TG.STT AND CV.MADT = TG.MADT
					   JOIN GIAOVIEN GV ON GV.MAGV = TG.MAGV
WHERE TG.MADT = '001'

--e
SELECT GV.MAGV, GV.HOTEN, 2014 - YEAR(GV.NGSINH) 'NAMVEHUU'
FROM GIAOVIEN GV JOIN BOMON BM ON GV.MAGV = BM.TRUONGBM
WHERE 2014 - YEAR(GV.NGSINH) >= (CASE PHAI
									 WHEN 'Nam' THEN 60
									 WHEN N'Nữ' THEN 55
									 END)

--f
SELECT GV.MAGV, GV.HOTEN, (CASE GV.PHAI
								WHEN 'Nam' THEN YEAR(GV.NGSINH) + 60
								WHEN N'Nữ' THEN YEAR(GV.NGSINH) + 55
								END) 'NAMVEHUU'
FROM GIAOVIEN GV JOIN KHOA K ON K.TRUONGKHOA = GV.MAGV

--g
CREATE TABLE DANHSACHTHIDUA
(
	MAGV CHAR(5),
	SODTDAT INT,
	DANHHIEU NVARCHAR(100)
	
	CONSTRAINT PK_DSTD PRIMARY KEY(MAGV),
	CONSTRAINT FK_DS_GV FOREIGN KEY(MAGV)
	REFERENCES GIAOVIEN
)

INSERT INTO DANHSACHTHIDUA(MAGV, SODTDAT)
SELECT GV.MAGV, 0
FROM GIAOVIEN GV

UPDATE DANHSACHTHIDUA 
SET SODTDAT = (SELECT COUNT(TG.MADT)
			   FROM THAMGIADT TG 
			   WHERE TG.KETQUA = N'Đạt' AND TG.MAGV = DANHSACHTHIDUA.MAGV)

UPDATE DANHSACHTHIDUA
SET DANHHIEU = (CASE 
				WHEN SODTDAT >= 1 AND SODTDAT <= 2 THEN N'Hoàn thành nhiệm vụ'
				WHEN SODTDAT = 0 THEN N'Chưa hoàn thành nhiệm vụ'
				WHEN SODTDAT >= 3 AND SODTDAT <= 5 THEN N'Tiên tiến'
				WHEN SODTDAT >= 6 THEN N'Lao động xuất sắc'
				END)
SELECT * FROM DANHSACHTHIDUA

--h
SELECT GV.MAGV, GV.HOTEN, AVG(GV.LUONG) AS TB
FROM GIAOVIEN GV JOIN BOMON BM ON GV.MABM = BM.MABM
				 JOIN KHOA K ON K.MAKHOA = BM.MAKHOA
--COMPUTE AVG(GV.LUONG), MIN(GV.LUONG), MAX(GV.LUONG) BY GV.MAGV
WHERE GV.PHAI = N'Nữ' AND K.TENKHOA = N'Công nghệ thông tin'
GROUP BY GV.MAGV, GV.HOTEN WITH ROLLUP
--GROUP BY GV.MAGV, GV.HOTEN WITH ROLLUP

--COMPUTE O CÒN AVAILABLE Ở SQL2O22 => tạm khỏi làm h->l

--M
SELECT DT.MACD, DT.CAPQL, COUNT(*) AS QUANTITY
FROM DETAI DT
GROUP BY DT.MACD, DT.CAPQL WITH  CUBE

SELECT DT.CAPQL, DT.MACD, COUNT(*) AS QUANTITY
FROM DETAI DT
GROUP BY DT.MACD, DT.CAPQL WITH ROLLUP

--VỚI ROLLUP THÌ THUỘC TÍNH ĐẦU SẼ ĐƯỢC BẤT KÌ, THUỘC TÍNH THỨ HAI THÌ 0
--=> CHÚ Ý VÀO THỨ TỰ VỚI ROLLUP

--N
SELECT MABM, PHAI, SUM(LUONG) AS LUONG
FROM GIAOVIEN
GROUP BY MABM, PHAI WITH CUBE

--O
SELECT GV.MABM, GV.PHAI, SUM(GV.LUONG) AS LUONG
FROM GIAOVIEN GV JOIN BOMON BM ON GV.MABM = BM.MABM
WHERE BM.MAKHOA = 'CNTT'
GROUP BY GV.MABM, GV.PHAI WITH CUBE

--Q75
SELECT GV.HOTEN, BM.TENBM
FROM GIAOVIEN GV LEFT JOIN BOMON BM ON BM.TRUONGBM = GV.MAGV

--Q76
SELECT BM.TENBM, GV.HOTEN
FROM BOMON BM LEFT JOIN GIAOVIEN GV ON BM.TRUONGBM = GV.MAGV

--Q77
SELECT GV.HOTEN, DT.TENDT
FROM GIAOVIEN GV LEFT JOIN DETAI DT ON GV.MAGV = DT.GVCNDT

--Q78
INSERT CHUDE VALUES('TMP', 'TMP')
INSERT DETAI 
VALUES('000', 'TMP', N'Trường', 999, '2024-04-27', '2024-04-28', 'TMP', NULL)
SELECT * FROM DETAI

DELETE FROM DETAI
WHERE MACD = 'TMP'

--Q79
SELECT GV.MAGV, GV.HOTEN, GV.LUONG, (CASE 
									 WHEN GV.LUONG < 1800 THEN N'THẤP'
									 WHEN GV.LUONG <= 2200 AND GV.LUONG >= 1800 THEN N'TRUNG BÌNH'
									 ELSE N'CAO'
									 END) AS XH
FROM GIAOVIEN GV

--Q80: ĐÙ MÁ HAY VCL
SELECT GV1.MAGV, GV1.HOTEN, GV1.LUONG, (CASE 
									 WHEN GV1.LUONG IS NULL THEN 'N/A'
									 ELSE
									 (SELECT COUNT(*) + 1
									 FROM GIAOVIEN GV2
									 WHERE GV2.LUONG > GV1.LUONG
									 )
									 END) AS XH
FROM GIAOVIEN GV1

--Q81: BÍ
--SELECT GV.HOTEN, (CASE
--				  WHEN GV.LUONG IS NULL THEN 'N/A'
--				  WHEN GV.MAGV IN 
--				  ELSE(
--				  SELECT GV2.LUONG + 300
--				  FROM GIAOVIEN GV2 
--				  WHERE GV2.MAGV = GV.MAGV AND GV2.MAGV IN (SELECT TRUONGBM FROM BOMON)
--				  )
---FROM GIAOVIEN GV JOIN

--Q82
SELECT HOTEN, (CASE PHAI
			   WHEN N'Nam' THEN YEAR(NGSINH) + 60
			   WHEN N'Nữ' THEN YEAR(NGSINH) + 55
			   END) AS NGHIHUU
FROM GIAOVIEN