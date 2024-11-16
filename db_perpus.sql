-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 16, 2024 at 10:57 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_perpus`
--

-- --------------------------------------------------------

--
-- Stand-in structure for view `laporan`
-- (See below for the actual view)
--
CREATE TABLE `laporan` (
`nama` varchar(25)
,`judul` varchar(50)
,`tgl_pinjam` date
,`tgl_kembali` date
,`keterangan` enum('Telat','Tidak telat','Hilang','')
,`denda` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `lihat_transaksi`
-- (See below for the actual view)
--
CREATE TABLE `lihat_transaksi` (
`id_anggota` varchar(20)
,`nama` varchar(25)
,`kode_pinjam` varchar(20)
,`judul` varchar(50)
,`tgl_pinjam` date
,`tgl_hrskembali` date
,`kode_kembali` varchar(20)
,`tgl_kembali` date
,`keterangan` enum('Telat','Tidak telat','Hilang','')
,`denda` int(11)
,`kt` enum('Sudah kembali','Belum kembali','','')
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `recomendasi`
-- (See below for the actual view)
--
CREATE TABLE `recomendasi` (
`kode_buku` varchar(20)
,`judul` varchar(50)
,`penerbit` varchar(30)
,`tahun_terbit` int(4)
,`kategori` varchar(20)
,`keterangan` enum('Sudah kembali','Belum kembali','','')
);

-- --------------------------------------------------------

--
-- Table structure for table `tb_admin`
--

CREATE TABLE `tb_admin` (
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tb_admin`
--

INSERT INTO `tb_admin` (`username`, `password`) VALUES
('pindo', 'pindo123');

-- --------------------------------------------------------

--
-- Table structure for table `tb_anggota`
--

CREATE TABLE `tb_anggota` (
  `id_anggota` varchar(20) NOT NULL,
  `nama` varchar(25) NOT NULL,
  `password` varchar(25) NOT NULL,
  `jk` varchar(15) NOT NULL,
  `telp` varchar(25) NOT NULL,
  `alamat` varchar(50) NOT NULL,
  `status` enum('Pinjam','Tidak pinjam','','') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tb_anggota`
--

INSERT INTO `tb_anggota` (`id_anggota`, `nama`, `password`, `jk`, `telp`, `alamat`, `status`) VALUES
('USR001', 'Abdul Ghani Firmansyah', 'abdul123', 'Laki-laki', '081234567890', 'Bekasi, Jawa Barat', 'Tidak pinjam'),
('USR002', 'Erizka Nia Ramadhani', 'erizka123', 'Perempuan', '081234567890', 'Karawang, Jawa Barat', 'Tidak pinjam'),
('USR003', 'Hidayanthi Dwi Puja', 'Hidayanthi123', 'Perempuan', '081234567890', 'Bekasi, Jawa Barat', 'Tidak pinjam'),
('USR004', 'Muhammad Bayu Pratama', 'Bayu123', 'Laki-laki', '081234567890', 'Bekasi, Jawa Barat', 'Tidak pinjam'),
('USR005', 'Pangudian Siagian', 'dian123', 'Laki-laki', '081234567890', 'Karawang, Jawa Barat', 'Tidak pinjam');

-- --------------------------------------------------------

--
-- Table structure for table `tb_buku`
--

CREATE TABLE `tb_buku` (
  `kode_buku` varchar(20) NOT NULL,
  `judul` varchar(50) NOT NULL,
  `penerbit` varchar(30) NOT NULL,
  `tahun_terbit` int(4) NOT NULL,
  `kategori` varchar(20) NOT NULL,
  `jumlah` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tb_buku`
--

INSERT INTO `tb_buku` (`kode_buku`, `judul`, `penerbit`, `tahun_terbit`, `kategori`, `jumlah`) VALUES
('BK0001', 'Basis Data', 'Cristiano Ronaldo', 2024, 'Pendidikan', 100),
('BK0002', 'Pemrograman Berorientasi Objek', 'Lionel Messi', 2024, 'Pendidikan', 75);

-- --------------------------------------------------------

--
-- Table structure for table `tb_kembali`
--

CREATE TABLE `tb_kembali` (
  `kode_kembali` varchar(20) NOT NULL,
  `kode_pinjam` varchar(20) NOT NULL,
  `id_anggota` varchar(20) NOT NULL,
  `kode_buku` varchar(20) NOT NULL,
  `tgl_kembali` date NOT NULL,
  `denda` int(11) NOT NULL,
  `keterangan` enum('Telat','Tidak telat','Hilang','') NOT NULL,
  `jumlah` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Triggers `tb_kembali`
--
DELIMITER $$
CREATE TRIGGER `kembali_buku` AFTER INSERT ON `tb_kembali` FOR EACH ROW BEGIN
UPDATE tb_buku SET jumlah = jumlah + new.jumlah
WHERE kode_buku = new.kode_buku;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tb_petugas`
--

CREATE TABLE `tb_petugas` (
  `id_operator` varchar(20) NOT NULL,
  `nama` varchar(25) NOT NULL,
  `password` varchar(25) NOT NULL,
  `jk` varchar(15) NOT NULL,
  `telp` varchar(25) NOT NULL,
  `alamat` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tb_petugas`
--

INSERT INTO `tb_petugas` (`id_operator`, `nama`, `password`, `jk`, `telp`, `alamat`) VALUES
('OPR01', 'Ayunisa Yasmin', 'ayu123', 'Perempuan', '081234567890', 'Karawang, Jawa Barat'),
('OPR02', 'Satria Panca', 'satria123', 'Laki-laki', '080987654321', 'Karawang, Jawa Barat'),
('OPR03', 'Ilham Syihabudin', 'ilham123', 'Laki-laki', '081234509876', 'Karawang, Jawa Barat');

-- --------------------------------------------------------

--
-- Table structure for table `tb_pinjam`
--

CREATE TABLE `tb_pinjam` (
  `kode_pinjam` varchar(20) NOT NULL,
  `id_anggota` varchar(20) NOT NULL,
  `nama` varchar(25) NOT NULL,
  `kode_buku` varchar(20) NOT NULL,
  `judul` varchar(50) NOT NULL,
  `tgl_pinjam` date NOT NULL,
  `tgl_hrskembali` date NOT NULL,
  `jumlah` int(1) NOT NULL,
  `kt` enum('Sudah kembali','Belum kembali','','') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Triggers `tb_pinjam`
--
DELIMITER $$
CREATE TRIGGER `pinjam_buku` AFTER INSERT ON `tb_pinjam` FOR EACH ROW BEGIN
update tb_buku SET jumlah = jumlah - new.jumlah
WHERE kode_buku = new.kode_buku;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure for view `laporan`
--
DROP TABLE IF EXISTS `laporan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `laporan`  AS SELECT `tb_pinjam`.`nama` AS `nama`, `tb_pinjam`.`judul` AS `judul`, `tb_pinjam`.`tgl_pinjam` AS `tgl_pinjam`, `tb_kembali`.`tgl_kembali` AS `tgl_kembali`, `tb_kembali`.`keterangan` AS `keterangan`, `tb_kembali`.`denda` AS `denda` FROM (`tb_pinjam` join `tb_kembali` on(`tb_pinjam`.`kode_pinjam` = `tb_kembali`.`kode_pinjam`)) ;

-- --------------------------------------------------------

--
-- Structure for view `lihat_transaksi`
--
DROP TABLE IF EXISTS `lihat_transaksi`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `lihat_transaksi`  AS SELECT `tb_pinjam`.`id_anggota` AS `id_anggota`, `tb_pinjam`.`nama` AS `nama`, `tb_pinjam`.`kode_pinjam` AS `kode_pinjam`, `tb_pinjam`.`judul` AS `judul`, `tb_pinjam`.`tgl_pinjam` AS `tgl_pinjam`, `tb_pinjam`.`tgl_hrskembali` AS `tgl_hrskembali`, `tb_kembali`.`kode_kembali` AS `kode_kembali`, `tb_kembali`.`tgl_kembali` AS `tgl_kembali`, `tb_kembali`.`keterangan` AS `keterangan`, `tb_kembali`.`denda` AS `denda`, `tb_pinjam`.`kt` AS `kt` FROM (`tb_pinjam` left join `tb_kembali` on(`tb_pinjam`.`kode_pinjam` = `tb_kembali`.`kode_pinjam`)) ;

-- --------------------------------------------------------

--
-- Structure for view `recomendasi`
--
DROP TABLE IF EXISTS `recomendasi`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `recomendasi`  AS SELECT `tb_pinjam`.`kode_buku` AS `kode_buku`, `tb_pinjam`.`judul` AS `judul`, `tb_buku`.`penerbit` AS `penerbit`, `tb_buku`.`tahun_terbit` AS `tahun_terbit`, `tb_buku`.`kategori` AS `kategori`, `tb_pinjam`.`kt` AS `keterangan` FROM (`tb_pinjam` join `tb_buku` on(`tb_pinjam`.`kode_buku` = `tb_buku`.`kode_buku`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_admin`
--
ALTER TABLE `tb_admin`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `tb_anggota`
--
ALTER TABLE `tb_anggota`
  ADD PRIMARY KEY (`id_anggota`);

--
-- Indexes for table `tb_buku`
--
ALTER TABLE `tb_buku`
  ADD PRIMARY KEY (`kode_buku`);

--
-- Indexes for table `tb_kembali`
--
ALTER TABLE `tb_kembali`
  ADD PRIMARY KEY (`kode_kembali`),
  ADD KEY `kode_buku` (`kode_buku`),
  ADD KEY `id_anggota` (`id_anggota`),
  ADD KEY `id_anggota_2` (`id_anggota`),
  ADD KEY `kode_buku_2` (`kode_buku`),
  ADD KEY `kode_pinjam` (`kode_pinjam`);

--
-- Indexes for table `tb_petugas`
--
ALTER TABLE `tb_petugas`
  ADD PRIMARY KEY (`id_operator`);

--
-- Indexes for table `tb_pinjam`
--
ALTER TABLE `tb_pinjam`
  ADD PRIMARY KEY (`kode_pinjam`),
  ADD KEY `kode_buku` (`kode_buku`),
  ADD KEY `id_anggota` (`id_anggota`),
  ADD KEY `kode_buku_2` (`kode_buku`),
  ADD KEY `id_anggota_2` (`id_anggota`),
  ADD KEY `kode_buku_3` (`kode_buku`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tb_kembali`
--
ALTER TABLE `tb_kembali`
  ADD CONSTRAINT `tb_kembali_ibfk_2` FOREIGN KEY (`kode_buku`) REFERENCES `tb_buku` (`kode_buku`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tb_kembali_ibfk_3` FOREIGN KEY (`kode_pinjam`) REFERENCES `tb_pinjam` (`kode_pinjam`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tb_kembali_ibfk_4` FOREIGN KEY (`id_anggota`) REFERENCES `tb_anggota` (`id_anggota`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tb_pinjam`
--
ALTER TABLE `tb_pinjam`
  ADD CONSTRAINT `tb_pinjam_ibfk_1` FOREIGN KEY (`kode_buku`) REFERENCES `tb_buku` (`kode_buku`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tb_pinjam_ibfk_2` FOREIGN KEY (`id_anggota`) REFERENCES `tb_anggota` (`id_anggota`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
