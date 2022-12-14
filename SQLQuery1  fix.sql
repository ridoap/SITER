
use barber

CREATE TABLE tblCustomer (
id_customer int primary key,
nama_customer varchar(20) not null,
alamat varchar(20) not null,
telepon varchar(20) not null,
jenis_kelamin char(1) not null)

insert into tblCustomer values
('01', 'Tegar Subekti', 'Karangsalem', '081242356742', 'L'),
('02', 'Safed Nuvaphone', 'Banyumas', '085435857387', 'L'),
('03', 'Ridho Aji P', 'Purbalingga', '087727727432', 'P'),
('04', 'Anan Widianto', 'Bobosan', '081645789876', 'L'),
('05', 'Tio Argatara Widodo', 'Grendeng', '081542867992', 'L');

select * from tblCustomer

CREATE TABLE tblKasir (
id_kasir int primary key,
nama_kasir varchar (20) not null,
jenis_kelamin char(1) not null,
umur int not null)

insert into tblKasir values
('1', 'Farhan', 'L', '23'),
('2', 'Vian', 'L', '23'),
('3', 'Aji', 'L', '21'),
('4', 'Rowdak', 'L', '19'),
('5', 'Rangga', 'L', '29')

select * from tblKasir

CREATE TABLE tblProduk (
id_produk int primary key,
nama_produk varchar(20) not null,
jenis varchar(20) not null,
harga varchar(20) not null,
stok varchar(20) not null)

insert into tblProduk values
('001', 'Bellagio', 'Pomade', '40000', '8'),
('002', 'Makarizo Hair', 'Vitamin', '15000', '6'),
('003', 'Rejoice', 'Shampo', '35000', '3'),
('004', 'Hairnerds Professional', 'Powder', '65000', '4'),
('005', 'Miranda', 'Pewarna Rambut', '35000', '9')

select * from tblProduk

CREATE TABLE tblService (
id_service int primary key,
jenis_pelayanan varchar(20) not null,
)

insert into tblService values
('12', 'Kramas'),
('13', 'Pijit')

select * from tblService

CREATE TABLE tblKapster (
id_kapster int primary key,
id_customer int foreign key references tblCustomer(id_customer),
nama_kapster varchar(20) not null,
umur int not null,
jenis_kelamin char (1) not null)

insert into tblKapster values
('1', '01', 'Rizky', '25', 'L'),
('2', '02', 'Prima', '22', 'L'),
('3', '03', 'Katon', '24', 'L'),
('4', '04', 'Bagas', '19', 'L'),
('5', '05', 'Bagus', '31', 'L')

select * from tblKapster

CREATE TABLE tblTransaksi (
id_transaksi int primary key,
id_customer int foreign key references tblCustomer(id_customer),
id_kasir int foreign key references tblKasir(id_kasir),
id_produk int foreign key references tblProduk(id_produk),
id_service int foreign key references tblService(id_service));

insert into tblTransaksi values
('20', '01', '3', '001', '12'),
('21', '02', '2', '003', '12'),
('22', '03', '4', '003', '13'),
('23', '04', '5', '002', '12'),
('24', '05', '1', '005', '13')

select * from tblTransaksi

CREATE TABLE tblReservasi(
id_reservasi int primary key,
id_transaksi int foreign key references tblTransaksi(id_transaksi),
id_produk int foreign key references tblProduk(id_produk),
nama_produk varchar(20),
jumlah_produk varchar(20),
tgl_reservasi varchar (20) not null);

insert into tblReservasi values
('0001', '20', '3', 'Rejoice', '1', '13'),
('0002', '21', '2', 'Makarizo Hair', '1', '13'),
('0003', '22', '4', 'Hairnerds Professional', '1', '15'),
('0004', '23', '5', 'Miranda', '3', '15'),
('0005', '24', '1', 'Bellagio', '1', '16')

select * from tblReservasi

ALTER TABLE tblReservasi DROP COLUMN jumlah_produk
ALTER TABLE tblReservasi ADD jumlah_produk int;

insert into tblKasir values ('01','Fikri','L','20')
insert into tblCustomer values ('01','Jono','PWT','00012122','L')
insert into tblKapster values ('01','01','Miko','20','L')
insert into tblProduk values ('01','Getsby','Pomade','1000','30')
insert into tblProduk values ('112','Marina','Pomade','2000','10')
insert into tblService values ('01','Cukur'),('02','Kramas')
insert into tblTransaksi values ('01','01','01','01','02')
insert into tblTransaksi values ('04','01','01','112','02')
insert into tblReservasi values ('05','04','112','Marina Pomade','12-12-22','2')

---Perintah dasar---
UPDATE tblProduk SET stok=30 WHERE id_produk='01'
UPDATE tblProduk SET stok=10 WHERE id_produk='112'
UPDATE tblReservasi SET jumlah_produk=4 WHERE id_reservasi='01'
DELETE from tblProduk WHERE id_produk='012'
ALTER TABLE tblProduk ADD stok varchar (50);
select * from tblReservasi
select * from tblProduk
select * from tblTransaksi

---Storage Procedur----
CREATE PROCEDURE tambah_produk
(@id_produk int, @nama VARCHAR(20), @jenis varchar (20), @harga varchar(20), @stok int)
AS BEGIN TRANSACTION
INSERT INTO tblProduk(id_produk, nama_produk, jenis, harga, stok) VALUES
(@id_produk, @nama, @jenis, @harga, @stok)

IF @@ERROR = 0
COMMIT TRANSACTION
ELSE
ROLLBACK TRANSACTION

EXEC tambah_produk '08','Mohito','HairSpray','30000','43'

select *from tblProduk

---TRIGGER-----
create trigger kurangistok on tblReservasi
for insert
as
update produk set produk.stok = produk.stok - beli.jumlah_produk
from tblProduk produk join inserted beli on produk.id_produk=beli.id_produk

select * from tblProduk
insert into tblReservasi values ('06','05','08','Mohito','23-12-22','4')

---Membuat Report Menggunakan View---
---Menampilkan nama Customer dan kepster dengan jenis pelayanannya---

CREATE VIEW laporan AS
SELECT a.id_transaksi, b.nama_customer, b.alamat, c.nama_kapster,d.jenis_pelayanan FROM tblTransaksi a
JOIN tblCustomer b ON a.id_customer = b.id_customer
JOIN tblKapster c ON a.id_customer = b.id_customer
JOIN tblService d ON a.id_service = d.id_service 

select * from laporan


