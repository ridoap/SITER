-- Membuat Database --

CREATE DATABASE db_BarberShop
ON
(
NAME = Perkuliahan,
FILENAME = 'D:\Project Sister\BarberShop.mdf',
SIZE = 10,
MAXSIZE = 50,
FILEGROWTH = 5
)
LOG ON
(
NAME = Perkuliahan_log,
FILENAME = 'D:\Project Sister\BarberShop_log.ldf',
SIZE = 5MB,
MAXSIZE = 25MB,
FILEGROWTH = 5MB
)

-- Menggunakan Database --

Use db_BarberShop

-- Membuat Tabel Pegawai --

CREATE TABLE Pegawai
(
Id_Pegawai char (20) NOT NULL PRIMARY KEY,
Nama varchar (20) NOT NULL,
Alamat varchar (20) NOT NULL,
Jabatan varchar (20) NOT NULL,
Telepon char (12) NOT NULL
)

-- Menambahkan data Ketabel Pegawai --

INSERT INTO Pegawai VALUES
('H01' , 'Tegar Subagyo' , 'Purwokerto' , 'Hairstylish' ,'08386777988'),
('H02' , 'Farhan Suharjo', 'Purbalingga', 'Hairstylish', '08378776677'),
('H03' , 'Faruk Al Kodir', 'Gumelar', 'Hairstylish', '0856557755'),
('K01' , 'Fikri Al Jabar', 'Bumiayu', 'Kasir', '083877367654')

select * from Pegawai

-- Membuat Tabel HairStylist -- 

CREATE TABLE Hairstylist
(
Id_Pegawai char (20) PRIMARY KEY FOREIGN KEY REFERENCES Pegawai(Id_Pegawai),
Nama varchar (20) NOT NULL,
Username varchar (20) NOT NULL,
Password char (20) NOT NULL
)

DROP TABLE Hairstylist

-- Menambahkan data Ketabel HairStylist --

INSERT INTO Hairstylist VALUES
('H01' , 'Tegar Subagyo' , 'tegar', '12345'),
('H02' , 'Farhan Suharjo', 'farhan', '12345'),
('H03' , 'Faruk Al Kodir', 'faruk', '12345')

select * from Hairstylist

-- Membuat Tabel Services --

CREATE TABLE Service
(
Id_Pegawai char (20) FOREIGN KEY REFERENCES Hairstylist(Id_Pegawai),
Id_Service char (20) NOT NULL PRIMARY KEY,
Harga char (20) NOT NULL,
Keterangan_Service varchar (20) NOT NULL
)


-- Menambahkan Data Ke Tabel Services --

INSERT INTO Service VALUES
('H01' , 'SRC01' , '25.000', 'Potong Rambut'),
('H02' , 'SRC02', '35.000', 'PotongRambut,Keramas'),
('H03' , 'SRC03', '200.000', 'Colouring Rambut')

select * from Service


-- Membuat Table Member --

CREATE TABLE Member 
(
Id_Member char (20) NOT NULL PRIMARY KEY,
Nama varchar (20) NOT NULL,
Email varchar (20) NOT NULL,
Alamat varchar (20) NOT NULL,
Telepon char (12) NOT NULL
)

-- Menambahkan Data KE Tabel Member --

INSERT INTO Member VALUES
('MBR01' , 'Didin Pinjol' , 'didin30@gmail.com', 'Sumampir' , ' 083383838'),
('MBR02' , 'Waluy Getar', 'waluy2@gmail.com', 'KarangSalam', '085875674'),
('MBR03' , 'Mamat Raup', 'mamat54@gmail.com', 'KedungBanteng',' 081431761')

select * from Member

-- Membuat Tabel Produk --

CREATE TABLE Produk
(
Id_Produk char (20) NOT NULL PRIMARY KEY,
Nama varchar (20) NOT NULL,
Harga char (20) NOT NULL,
Stok char (50) NOT NULL
)

-- Menambahkan Data Ke Tabel Prdoduk --

INSERT INTO Produk VALUES
('PK001' , 'Pomade' , '50.000', '15'),
('PK002' , 'Shampo', '30.000', '35'),
('PK003' , 'Hair Color', '125.000', '20')

select * from Produk

-- Membuat Tabel Diskon --

CREATE TABLE Diskon
(
Id_Diskon char (20) NOT NULL PRIMARY KEY,
Keterangan varchar (50) NOT NULL
)

DROP TABLE Diskon

-- Menambahkan Data Ke Tabel Diskon --

INSERT INTO Diskon VALUES
('DSK001' , 'diskon 2% pomade'),
('DSK002' , 'diskon 2% Shampo'),
('DSK003' , 'diskon 10% Hair Color')

select * from Diskon

-- Membuat Tabel Resevarsi --

CREATE TABLE Reservasi
(
Id_Reservasi char (20) NOT NULL PRIMARY KEY,
Id_Pegawai char (20) FOREIGN KEY REFERENCES Pegawai(Id_Pegawai),
Id_Member char (20) FOREIGN KEY REFERENCES Member(Id_Member),
Status varchar (20) NOT NULL
)

-- Menambahkan Data Ke Tabel Reservasi --

INSERT INTO Reservasi VALUES
('RSV01' , 'H01' , 'MBR03', 'succes'),
('RSV02' , 'H02' , 'MBR02', 'succes'),
('RSV03' , 'H03' , 'MBR01', 'succes')

select * from Reservasi

-- Membuat Tabel Kasir --
CREATE TABLE Kasir
(
Id_Pegawai char (20) PRIMARY KEY FOREIGN KEY REFERENCES Pegawai(Id_Pegawai),
Id_Service char (20) FOREIGN KEY REFERENCES Service(Id_Service),
Id_Produk char (20) FOREIGN KEY REFERENCES Produk(Id_Produk),
Id_Diskon char (20) FOREIGN KEY REFERENCES Diskon(Id_Diskon),
Username varchar (20) NOT NULL,
Password char (20) NOT NULL
)

-- Menambahkan Data Ke Tabel Kasir --

INSERT INTO Kasir VALUES
('K01' , 'SRC01' , 'PK001', 'DSK001', 'fikri', '12345')



-- Membuat Tabel Laporan --
CREATE TABLE Laporan
(
Id_Laporan char (20) PRIMARY KEY,
Keterangan_Laporan varchar (50) NOT NULL
)


-- Menambahkan Data Ke Tabel Laporan --

INSERT INTO Laporan VALUES
('LP01' , 'Penjualan Bulan Juni'),
('LP02', 'Penjualan Bulan Mei'),
('LP03', 'Penjualan Bulan April')

-- Membuat Tabel Pemilik --

CREATE TABLE Pemilik 
(
Id_Laporan char (20) FOREIGN KEY REFERENCES Laporan(Id_Laporan),
Username varchar (20) NOT NULL,
Password char (20) NOT NULL
)

-- Menambahkan Data Ke Tabel Pemilik --

INSERT INTO Pemilik VALUES
('LP01' , 'dadang', '12345'),
('LP02', 'dadang', '12345'),
('LP03', 'dadang', '12345')

------------------------------------------------------
---Mengatur Administrasi INSERT, UPDATE DELETE, SELECT 
----------  DAN TENTUKAN PULA USERNYA  ---------------

-- Hak Akses Pemilik

GRANT SELECT
ON Laporan
TO Owner_Dadang

-- Hak Akses Hairstylist

GRANT INSERT, UPDATE, DELETE, SELECT
ON Service
TO Hairstylist_All

-- Hak Akses Kasir

GRANT INSERT, UPDATE, DELETE, SELECT
ON Laporan
TO Kasir_Fikri

GRANT INSERT, UPDATE, DELETE, SELECT
ON Reservasi
TO Kasir_Fikri




CREATE VIEW Nota
AS
SELECT A.Id_Pegawai , B.Keterangan_Service,
C.Nama , C.Harga 
FROM Kasir A JOIN Service B ON
A.Id_Service=B.Id_Service
JOIN Produk C ON A.Id_Produk=C.Id_Produk


select * from Nota



