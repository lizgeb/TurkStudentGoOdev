-- 1. Uyeler tablosu
CREATE TABLE Uyeler (
    uye_id SERIAL PRIMARY KEY,
    kullanici_adi VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    sifre VARCHAR(255) NOT NULL,
    ad VARCHAR(50),
    soyad VARCHAR(50),
    kayit_tarihi TIMESTAMP
);

-- 2. Egitimler tablosu
CREATE TABLE Egitimler (
    egitim_id SERIAL PRIMARY KEY,
    baslik VARCHAR(200),
    aciklama TEXT,
    baslangic_tarihi DATE,
    bitis_tarihi DATE,
    egitmen VARCHAR(100)
);

-- 3. Kategoriler tablosu
CREATE TABLE Kategoriler (
    kategori_id SERIAL PRIMARY KEY,
    kategori_adi VARCHAR(100)
);

-- 4. Egitim-Kategori ilişkisi (ara tablo)
CREATE TABLE Egitim_Kategori (
    id SERIAL PRIMARY KEY,
    egitim_id INTEGER REFERENCES Egitimler(egitim_id),
    kategori_id INTEGER REFERENCES Kategoriler(kategori_id)
);

-- 5. Katilimlar tablosu (uyeler ve egitimler arası)
CREATE TABLE Katilimlar (
    katilim_id SERIAL PRIMARY KEY,
    uye_id INTEGER REFERENCES Uyeler(uye_id),
    egitim_id INTEGER REFERENCES Egitimler(egitim_id),
    katilim_tarihi TIMESTAMP
);

-- 6. Sertifikalar tablosu
CREATE TABLE Sertifikalar (
    sertifika_id SERIAL PRIMARY KEY,
    sertifika_kodu VARCHAR(100) UNIQUE,
    verilis_tarihi DATE
);

-- 7. Sertifika Atamalari (uyeler ve sertifikalar arası)
CREATE TABLE Sertifika_Atamalari (
    id SERIAL PRIMARY KEY,
    uye_id INTEGER REFERENCES Uyeler(uye_id),
    sertifika_id INTEGER REFERENCES Sertifikalar(sertifika_id),
    alis_tarihi DATE
);

-- 8. Blog Gonderileri
CREATE TABLE Blog_Gonderileri (
    gonderi_id SERIAL PRIMARY KEY,
    baslik VARCHAR(255),
    icerik TEXT,
    yayin_tarihi TIMESTAMP,
    yazar_id INTEGER REFERENCES Uyeler(uye_id)
);


--Tablolara Kayıt Ekleme

-- 1. Uyeler tablosu
INSERT INTO Uyeler (kullanici_adi, email, sifre, ad, soyad, kayit_tarihi)
VALUES 
('ayse123', 'ayse@example.com', '12345', 'Ayşe', 'Yılmaz', CURRENT_TIMESTAMP),
('mehmet89', 'mehmet@example.com', 'abcde', 'Mehmet', 'Demir', CURRENT_TIMESTAMP);

-- 2. Egitimler tablosu
INSERT INTO Egitimler (baslik, aciklama, baslangic_tarihi, bitis_tarihi, egitmen)
VALUES 
('Veri Bilimine Giriş', 'Temel veri bilimi kavramları.', '2025-04-01', '2025-05-01', 'Dr. Zeynep Kara'),
('Python ile Programlama', 'Python dili ile temel programlama eğitimi.', '2025-04-10', '2025-05-20', 'Ali Veli');

-- 3. Kategoriler tablosu
INSERT INTO Kategoriler (kategori_adi)
VALUES 
('Veri Bilimi'),
('Programlama');

-- 4. Egitim-Kategori ilişkisi (ara tablo)
INSERT INTO Egitim_Kategori (egitim_id, kategori_id)
VALUES 
(1, 1), -- Veri Bilimi Giriş → Veri Bilimi
(2, 2); -- Python Eğitimi → Programlama

-- 5. Katilimlar tablosu (uyeler ve egitimler arası)
INSERT INTO Katilimlar (uye_id, egitim_id, katilim_tarihi)
VALUES 
(1, 1, CURRENT_TIMESTAMP), -- Ayşe → Veri Bilimi Giriş
(2, 2, CURRENT_TIMESTAMP); -- Mehmet → Python Eğitimi

-- 6. Sertifikalar tablosu
INSERT INTO Sertifikalar (sertifika_kodu, verilis_tarihi)
VALUES 
('CERT-2025-001', '2025-05-02'),
('CERT-2025-002', '2025-05-21');

-- 7. Sertifika Atamalari (uyeler ve sertifikalar arası)
INSERT INTO Sertifika_Atamalari (uye_id, sertifika_id, alis_tarihi)
VALUES 
(1, 1, '2025-05-03'),
(2, 2, '2025-05-22');

-- 8. Blog Gonderileri
INSERT INTO Blog_Gonderileri (baslik, icerik, yayin_tarihi, yazar_id)
VALUES 
('Veri Bilimi ile Tanıştım', 'Bugün ilk kez veri bilimi eğitimine katıldım!', CURRENT_TIMESTAMP, 1),
('Python Harika!', 'Python diliyle programlama öğrenmek çok keyifli.', CURRENT_TIMESTAMP, 2);

