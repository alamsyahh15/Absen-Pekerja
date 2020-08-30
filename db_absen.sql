-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Aug 30, 2020 at 07:47 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.3.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_absen`
--

-- --------------------------------------------------------

--
-- Table structure for table `tb_absen`
--

CREATE TABLE `tb_absen` (
  `id_absen` int(11) NOT NULL,
  `check_in` datetime NOT NULL,
  `check_out` datetime DEFAULT NULL,
  `date_today` date NOT NULL,
  `jam_kerja` time NOT NULL,
  `place` varchar(125) NOT NULL,
  `checkin_by` int(11) NOT NULL,
  `checkout_by` int(11) NOT NULL,
  `latitude_loc` double NOT NULL,
  `longitude_loc` double NOT NULL,
  `id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tb_absen`
--

INSERT INTO `tb_absen` (`id_absen`, `check_in`, `check_out`, `date_today`, `jam_kerja`, `place`, `checkin_by`, `checkout_by`, `latitude_loc`, `longitude_loc`, `id_user`) VALUES
(9, '2020-08-11 11:55:53', '2020-08-11 12:00:15', '2020-08-11', '08:00:00', 'Jakarta', 1, 1, 0, 0, 3),
(10, '2020-08-11 13:58:40', NULL, '2020-08-11', '00:00:00', 'Jakarta', 1, 0, 0, 0, 1),
(11, '2020-08-13 10:51:40', NULL, '2020-08-13', '00:00:00', 'Jakarta', 1, 0, 0, 0, 1),
(12, '2020-08-13 10:52:41', NULL, '2020-08-13', '00:00:00', 'Jakarta', 1, 0, 0, 0, 3);

-- --------------------------------------------------------

--
-- Table structure for table `tb_role`
--

CREATE TABLE `tb_role` (
  `id_role` int(11) NOT NULL,
  `name_role` varchar(125) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tb_role`
--

INSERT INTO `tb_role` (`id_role`, `name_role`) VALUES
(1, 'CEO'),
(2, 'Admin'),
(3, 'Staff');

-- --------------------------------------------------------

--
-- Table structure for table `tb_user`
--

CREATE TABLE `tb_user` (
  `id_user` int(11) NOT NULL,
  `fullname_user` varchar(125) NOT NULL,
  `email_user` varchar(125) NOT NULL,
  `photo_user` text NOT NULL,
  `username_user` varchar(125) NOT NULL,
  `password_user` text NOT NULL,
  `role_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tb_user`
--

INSERT INTO `tb_user` (`id_user`, `fullname_user`, `email_user`, `photo_user`, `username_user`, `password_user`, `role_id`) VALUES
(1, 'Alamsyah1239', 'update9@mail.com', '75ae0cf4-0fdd-4b13-be50-641f37e5befa-564859953.jpg', 'updateusername1239', '4297f44b13955235245b2497399d7a93', 3),
(3, 'Admib', 'adminuda@mail.com', '', 'adminuda', '4297f44b13955235245b2497399d7a93', 2),
(4, 'Nando Septian', 'nando@mail.com', '', 'nando123', '4297f44b13955235245b2497399d7a93', 3),
(5, 'Daput', 'daput@mail.com', '', 'daput123', '4297f44b13955235245b2497399d7a93', 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_absen`
--
ALTER TABLE `tb_absen`
  ADD UNIQUE KEY `id_absen` (`id_absen`);

--
-- Indexes for table `tb_role`
--
ALTER TABLE `tb_role`
  ADD PRIMARY KEY (`id_role`);

--
-- Indexes for table `tb_user`
--
ALTER TABLE `tb_user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tb_absen`
--
ALTER TABLE `tb_absen`
  MODIFY `id_absen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `tb_role`
--
ALTER TABLE `tb_role`
  MODIFY `id_role` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tb_user`
--
ALTER TABLE `tb_user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
