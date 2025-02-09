-- Tabel pengunjung
CREATE TABLE pengunjung (
    id_pengunjung INT PRIMARY KEY,
    nama_pengunjung VARCHAR(250),
    tinggi_pengunjung FLOAT,
    tanggal_lahir DATE,
    email VARCHAR(250) UNIQUE,
    nomor_telepon VARCHAR(250) UNIQUE
);

-- Tabel jenis_tiket
CREATE TABLE jenis_tiket (
    id_jenis_tiket INT PRIMARY KEY,
    nama_jenis_tiket VARCHAR(250),
    harga_jenis_tiket INT,
    deskripsi_tiket VARCHAR(250)
);

-- Tabel wahana
CREATE TABLE wahana (
    id_wahana INT PRIMARY KEY,
    nama_wahana VARCHAR(250),
    kapasitas_wahana INT,
    tinggi_minimum FLOAT,
    waktu_operasi_mulai_wahana TIMESTAMP,
    waktu_operasi_selesai_wahana TIMESTAMP
);

-- Tabel restoran
CREATE TABLE restoran (
    id_restoran INT PRIMARY KEY,
    nama_restoran VARCHAR(250),
    kapasitas_restoran INT,
    waktu_buka_restoran TIMESTAMP,
    waktu_tutup_restoran TIMESTAMP
);

-- Tabel pembelian_restoran
CREATE TABLE pembelian_restoran (
    id_pembelian_restoran INT PRIMARY KEY,
    id_pengunjung INT NOT NULL,
    id_restoran INT NOT NULL,
    menu VARCHAR(250),
    jumlah_item INT,
    harga INT,
    waktu_pembelian TIMESTAMP,
    FOREIGN KEY (id_pengunjung) REFERENCES pengunjung(id_pengunjung),
    FOREIGN KEY (id_restoran) REFERENCES restoran(id_restoran)
);

-- Tabel reservasi
CREATE TABLE reservasi (
    id_reservasi INT PRIMARY KEY,
    jumlah_tiket INT,
    waktu_reservasi TIMESTAMP,
    id_restoran INT,
    id_pengunjung INT,  
    id_wahana INT,     
    FOREIGN KEY (id_restoran) REFERENCES restoran(id_restoran),
    FOREIGN KEY (id_pengunjung) REFERENCES pengunjung(id_pengunjung),
    FOREIGN KEY (id_wahana) REFERENCES wahana(id_wahana)
);

-- Tabel acara_khusus
CREATE TABLE acara_khusus (
    id_acara INT PRIMARY KEY,
    nama_acara VARCHAR(250),
    tanggal_mulai DATE,
    tanggal_selesai DATE,
    kapasitas_ruang INT,
    harga_tiket INT,
    id_reservasi INT,
    FOREIGN KEY (id_reservasi) REFERENCES reservasi(id_reservasi)
);


-- Tabel pembelian_tiket
CREATE TABLE pembelian_tiket (
    id_pembelian_tiket INT PRIMARY KEY,
    id_pengunjung INT,  
    id_jenis_tiket INT, 
    id_wahana INT,      
    tanggal_berlaku DATE,
    status_penggunaan BOOL,
    tanggal_beli TIMESTAMP,
    FOREIGN KEY (id_pengunjung) REFERENCES pengunjung(id_pengunjung),
    FOREIGN KEY (id_jenis_tiket) REFERENCES jenis_tiket(id_jenis_tiket),
    FOREIGN KEY (id_wahana) REFERENCES wahana(id_wahana)
);

-- Tabel karyawan
CREATE TABLE karyawan (
    id_karyawan INT PRIMARY KEY,
    nama_karyawan VARCHAR(250),
    posisi VARCHAR(250),
    tanggal_bergabung TIMESTAMP,
    gaji INT
);

-- Tabel pemeliharaan
CREATE TABLE pemeliharaan (
    id_pemeliharaan INT PRIMARY KEY,
    id_wahana INT NOT NULL,
    tanggal_pemeliharaan DATE,
    deskripsi VARCHAR(250),
    status VARCHAR(250),
    waktu_mulai_pemeliharaan TIMESTAMP,
    waktu_selesai_pemeliharaan TIMESTAMP,
    id_karyawan INT,  -- Menambahkan kolom untuk menghubungkan dengan tabel karyawan
    FOREIGN KEY (id_wahana) REFERENCES wahana(id_wahana),
    FOREIGN KEY (id_karyawan) REFERENCES karyawan(id_karyawan)  -- Menambahkan foreign key untuk karyawan
);
-- Tabel shift
CREATE TABLE shift (
    id_shift INT PRIMARY KEY,
    id_karyawan INT,
    tanggal DATE,
    waktu_mulai TIMESTAMP,
    waktu_selesai TIMESTAMP,
    FOREIGN KEY (id_karyawan) REFERENCES karyawan(id_karyawan)
);

-- Tabel menu
CREATE TABLE menu (
    id_menu INT PRIMARY KEY,
    id_restoran INT NOT NULL,
    nama_menu VARCHAR(250),
    harga INT,
    kategori VARCHAR(250),
    id_pembelian INT, 
    FOREIGN KEY (id_restoran) REFERENCES restoran(id_restoran),
    FOREIGN KEY (id_pembelian) REFERENCES pembelian_restoran(id_pembelian_restoran)  -- Menambahkan foreign key untuk id_pembelian
);




-- Tabel pengunjung
INSERT INTO pengunjung (id_pengunjung, nama_pengunjung, tinggi_pengunjung, tanggal_lahir, email, nomor_telepon)
VALUES
(1, 'Andi Santoso', 170.5, '1990-05-15', 'andi@example.com', '08123456789'),
(2, 'Budi Prasetyo', 165.2, '1985-07-22', 'budi@example.com', '08987654321'),
(3, 'Citra Wulandari', 160.8, '1992-03-12', 'citra@example.com', '08567891234'),
(4, 'Dian Fajar', 172.3, '1995-08-30', 'dian@example.com', '08765432109');

-- Tabel jenis_tiket
INSERT INTO jenis_tiket (id_jenis_tiket, nama_jenis_tiket, harga_jenis_tiket, deskripsi_tiket)
VALUES
(1, 'Tiket Reguler', 100000, 'Tiket standar untuk masuk ke wahana dan restoran.'),
(2, 'Tiket VIP', 200000, 'Tiket eksklusif dengan akses prioritas ke wahana dan restoran.'),
(3, 'Tiket Acara Khusus', 150000, 'Tiket khusus untuk acara yang diadakan pada hari tertentu.');

-- Tabel wahana
INSERT INTO wahana (id_wahana, nama_wahana, kapasitas_wahana, tinggi_minimum, waktu_operasi_mulai_wahana, waktu_operasi_selesai_wahana)
VALUES
(1, 'Roller Coaster', 25, 140.0, '2024-12-15 10:00:00', '2024-12-15 18:00:00'),
(2, 'Ferris Wheel', 50, 120.0, '2024-12-15 09:00:00', '2024-12-15 21:00:00'),
(3, 'Water Slide', 30, 130.0, '2024-12-15 11:00:00', '2024-12-15 17:00:00');

-- Tabel restoran
INSERT INTO restoran (id_restoran, nama_restoran, kapasitas_restoran, waktu_buka_restoran, waktu_tutup_restoran)
VALUES
(1, 'Restoran A', 50, '2024-12-15 08:00:00', '2024-12-15 22:00:00'),
(2, 'Restoran B', 60, '2024-12-15 09:00:00', '2024-12-15 23:00:00'),
(3, 'Restoran C', 40, '2024-12-15 10:00:00', '2024-12-15 21:00:00');

-- Tabel pembelian_restoran
INSERT INTO pembelian_restoran (id_pembelian_restoran, id_pengunjung, id_restoran, menu, jumlah_item, harga, waktu_pembelian)
VALUES
(1, 1, 1, 'Burger Keju', 2, 40000, '2024-12-15 12:30:00'),
(2, 2, 2, 'Pizza Margherita', 1, 60000, '2024-12-15 13:00:00'),
(3, 3, 3, 'Nasi Goreng Spesial', 3, 45000, '2024-12-15 14:00:00');


-- 1. Insert ke dalam tabel reservasi terlebih dahulu
INSERT INTO reservasi (id_reservasi, jumlah_tiket, waktu_reservasi, id_restoran, id_pengunjung, id_wahana)
VALUES
(1, 2, '2024-12-15 12:15:00', 1, 1, 1),
(2, 1, '2024-12-15 13:30:00', 2, 2, 2),
(3, 3, '2024-12-15 14:45:00', 3, 3, 3);

-- 2. Insert ke dalam tabel acara_khusus setelah data di reservasi ada
INSERT INTO acara_khusus (id_acara, nama_acara, tanggal_mulai, tanggal_selesai, kapasitas_ruang, harga_tiket, id_reservasi)
VALUES
(1, 'Konser Musik', '2024-12-20', '2024-12-20', 200, 150000, 1),
(2, 'Festival Makanan', '2024-12-22', '2024-12-22', 150, 100000, 2);

-- Tabel pembelian_tiket
INSERT INTO pembelian_tiket (id_pembelian_tiket, id_pengunjung, id_jenis_tiket, id_wahana, tanggal_berlaku, status_penggunaan, tanggal_beli)
VALUES
(1, 1, 1, 1, '2024-12-15', TRUE, '2024-12-14 10:00:00'),
(2, 2, 2, 2, '2024-12-15', TRUE, '2024-12-14 11:00:00'),
(3, 3, 3, 3, '2024-12-15', FALSE, '2024-12-14 12:00:00');

-- Tabel karyawan
-- Tabel karyawan
INSERT INTO karyawan (id_karyawan, nama_karyawan, posisi, tanggal_bergabung, gaji)
VALUES
(1, 'Eva Saraswati', 'Manajer Restoran', '2024-01-01 08:00:00', 7000000),
(2, 'Fajar Pramono', 'Karyawan Wahana', '2024-03-15 09:00:00', 4500000);

-- Tabel pemeliharaan
INSERT INTO pemeliharaan (id_pemeliharaan, id_wahana, tanggal_pemeliharaan, deskripsi, status, waktu_mulai_pemeliharaan, waktu_selesai_pemeliharaan, id_karyawan)
VALUES
(1, 1, '2024-12-10', 'Perawatan Roller Coaster', 'Selesai', '2024-12-10 09:00:00', '2024-12-10 12:00:00', 1),
(2, 2, '2024-12-11', 'Perawatan Ferris Wheel', 'Selesai', '2024-12-11 10:00:00', '2024-12-11 13:00:00', 2);

-- Tabel shift
INSERT INTO shift (id_shift, id_karyawan, tanggal, waktu_mulai, waktu_selesai)
VALUES
(1, 1, '2024-12-15', '2024-12-15 08:00:00', '2024-12-15 16:00:00'),
(2, 2, '2024-12-15', '2024-12-15 09:00:00', '2024-12-15 17:00:00');

-- Tabel menu
INSERT INTO menu (id_menu, id_restoran, nama_menu, harga, kategori, id_pembelian)
VALUES
(1, 1, 'Pizza Margherita', 50000, 'Makanan', 1),  -- id_restoran = 1 untuk Restoran A
(2, 2, 'Spaghetti Carbonara', 60000, 'Makanan', 2);  -- id_restoran = 2 untuk Restoran B



-- invoice restoran
SELECT 
    p.nama_pengunjung, 
   p.email, 
    p.nomor_telepon, 
    pb.id_pembelian_tiket, 
    jt.id_jenis_tiket, 
    jt.nama_jenis_tiket, 
    pb.tanggal_berlaku, 
    pb.tanggal_beli, 
    w.id_wahana, 
    w.nama_wahana, 
    r.jumlah_tiket AS jumlah_tiket, 
    jt.harga_jenis_tiket AS harga_per_wahana,
    (r.jumlah_tiket * jt.harga_jenis_tiket) AS total_harga_per_wahana,
    SUM(r.jumlah_tiket * jt.harga_jenis_tiket) OVER() AS total_semua_harga
FROM 
    pengunjung p
LEFT JOIN 
    pembelian_tiket pb ON p.id_pengunjung = pb.id_pengunjung
LEFT JOIN 
    jenis_tiket jt ON pb.id_jenis_tiket = jt.id_jenis_tiket
LEFT JOIN 
    reservasi r ON pb.id_pembelian_tiket = r.id_reservasi
LEFT JOIN 
    wahana w ON r.id_wahana = w.id_wahana;


-- informasi pemeliharaan
SELECT 
    p.id_pemeliharaan, 
    w.id_wahana, 
    w.nama_wahana, 
    p.deskripsi, 
    p.status
FROM 
    pemeliharaan p
LEFT JOIN 
    wahana w ON p.id_wahana = w.id_wahana;



-- shift karyawan
SELECT 
    k.nama_karyawan, 
    k.id_karyawan, 
    s.id_shift, 
    p.id_pemeliharaan, 
    p.tanggal_pemeliharaan, 
    p.waktu_mulai_pemeliharaan,
    p.waktu_selesai_pemeliharaan
FROM 
    karyawan k
LEFT JOIN 
    shift s ON k.id_karyawan = s.id_karyawan
LEFT JOIN 
    pemeliharaan p ON s.id_shift = p.id_pemeliharaan;




-- tiket wahana
SELECT 
    p.nama_pengunjung, 
    p.tinggi_pengunjung, 
    jt.id_jenis_tiket, 
    pb.id_pembelian_tiket, 
    pb.tanggal_berlaku, 
    w.id_wahana, 
    w.nama_wahana, 
    r.jumlah_tiket AS qty_tiket, 
    jt.harga_jenis_tiket AS price_per_tiket, 
    (r.jumlah_tiket * jt.harga_jenis_tiket) AS total_per_wahana,
    SUM(r.jumlah_tiket * jt.harga_jenis_tiket) OVER() AS total_semua_wahana
FROM 
    pengunjung p
LEFT JOIN 
    pembelian_tiket pb ON p.id_pengunjung = pb.id_pengunjung
LEFT JOIN 
    jenis_tiket jt ON pb.id_jenis_tiket = jt.id_jenis_tiket
LEFT JOIN 
    reservasi r ON pb.id_pembelian_tiket = r.id_reservasi
LEFT JOIN 
    wahana w ON r.id_wahana = w.id_wahana;




-- invoice restoran
SELECT 
    p.nama_pengunjung,
    pr.id_pembelian_restoran AS id_pembelian,
    r.id_restoran,
    pr.id_pengunjung,
    pr.waktu_pembelian,
    res.jumlah_tiket AS jumlah_tiket,
    m.id_menu,
    m.nama_menu,
    pr.jumlah_item AS jumlah_item_menu,
    pr.harga AS harga_per_item,
    (pr.jumlah_item * pr.harga) AS total,
    SUM(pr.jumlah_item * pr.harga) OVER() AS jumlah_total_semua
FROM 
    pengunjung p
LEFT JOIN 
    pembelian_restoran pr ON p.id_pengunjung = pr.id_pengunjung
LEFT JOIN 
    reservasi res ON pr.id_pengunjung = res.id_pengunjung
LEFT JOIN 
    restoran r ON pr.id_restoran = r.id_restoran
LEFT JOIN 
    menu m ON m.id_pembelian = pr.id_pembelian_restoran;






-- invoice pembelian tiket
SELECT 
    p.nama_pengunjung, 
    p.email, 
    p.nomor_telepon, 
    pb.id_pembelian_tiket, 
    jt.id_jenis_tiket, 
    pb.tanggal_berlaku, 
    pb.tanggal_beli, 
    w.id_wahana, 
    w.nama_wahana, 
    r.jumlah_tiket AS qty_tiket, 
    jt.harga_jenis_tiket AS price_per_tiket,
    (r.jumlah_tiket * jt.harga_jenis_tiket) AS total,
    SUM(r.jumlah_tiket * jt.harga_jenis_tiket) OVER() AS total_semua
FROM 
    pengunjung p
LEFT JOIN 
    pembelian_tiket pb ON p.id_pengunjung = pb.id_pengunjung
LEFT JOIN 
    jenis_tiket jt ON pb.id_jenis_tiket = jt.id_jenis_tiket
LEFT JOIN 
    reservasi r ON pb.id_pembelian_tiket = r.id_reservasi
LEFT JOIN 
    wahana w ON r.id_wahana = w.id_wahana;