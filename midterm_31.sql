﻿CREATE DATABASE MIDTERM_W5
USE MIDTERM_W5

CREATE TABLE KHACHHANG
(
	MALOAI CHAR(2),
	HOTEN NVARCHAR(50),
	STT INT,
	DIACHI NVARCHAR(50)

	CONSTRAINT PK_KH PRIMARY KEY (MALOAI, STT)
)

CREATE TABLE SACH
(
	MASACH CHAR(4),
	TENSACH NVARCHAR(100),
	SOLUONG INT,
	DONGIA FLOAT,
	MALOAI CHAR(2),
	KHTIEUBIEU INT
	 
	CONSTRAINT PK_SACH PRIMARY KEY (MASACH)
	CONSTRAINT FK_S_KH FOREIGN KEY(MALOAI, KHTIEUBIEU)
	REFERENCES KHACHHANG
)

CREATE TABLE MUAHANG
(
	LOAIKH CHAR(2),
	SOTT INT,
	MASACH CHAR(4),
	NGAYMUA DATE,
	SOLUONG INT,
	DONGIA FLOAT

	CONSTRAINT PK_MH PRIMARY KEY (LOAIKH, SOTT, MASACH)
	CONSTRAINT FK_MH_KH FOREIGN KEY (LOAIKH, SOTT)
	REFERENCES KHACHHANG,
	CONSTRAINT FK_MH_SACH FOREIGN KEY(MASACH)
	REFERENCES SACH
)

INSERT KHACHHANG(MALOAI, STT, HOTEN, DIACHI) VALUES 
('L1',1, N'Nguyễn Thị Minh', N'123 Vườn Lài, Tân Phú'),
('L1', 2, N'Trần Trung Nghĩa', N'45 Phú Thọ Hòa, Tân Phú'),
('L2', 1, N'Vũ Ánh Nguyệt', N'11 Võ Văn Ngân, Thủ Đức')
('S002', N'Bài giảng cuối cùng', 24, 102000, 'L2', 1)
('L1', 2, 'S001', '30/12/2019', 20, 87000),
('L2', 1, 'S002', '6/6/2016' ,10, 100000),
('L1', 2, 'S002', '7/3/2018' ,5, 120000)