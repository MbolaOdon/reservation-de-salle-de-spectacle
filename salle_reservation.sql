-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Aug 15, 2024 at 03:43 PM
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
-- Database: `salle_reservation`
--

-- --------------------------------------------------------

--
-- Table structure for table `client`
--

CREATE TABLE `client` (
  `idCli` int(11) NOT NULL,
  `nomPrenom` varchar(200) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `adresse` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(256) NOT NULL,
  `role` varchar(6) NOT NULL,
  `create_date` timestamp NULL DEFAULT current_timestamp(),
  `update_date` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `client`
--

INSERT INTO `client` (`idCli`, `nomPrenom`, `phone`, `adresse`, `email`, `password`, `role`, `create_date`, `update_date`) VALUES
(4, 'odenfit odon', '0325648795', 'maninday', 'odenfit@gmail.com', '$2y$10$1NyOMD/InVdIEY6j5ve41e5s8tLv11aRk0LXi/yEGc5FNe9TAIfxu', 'cli', NULL, NULL),
(5, 'Romeo augustin', '0325648795', 'maninday', 'romeo@gmail.com', '$2y$10$/8Qpc3ZeSOAo2gqhhSw3Sus3tCbth77K1Jt9W8QygXZmqMv0uELKe', 'cli', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `payement`
--

CREATE TABLE `payement` (
  `idPay` int(11) NOT NULL,
  `idReserv` int(11) NOT NULL,
  `avance` double NOT NULL,
  `reste` double DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `persona_acces_token`
--

CREATE TABLE `persona_acces_token` (
  `id` int(11) NOT NULL,
  `tokenable_type` varchar(100) NOT NULL,
  `tokenable_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `last_use` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `expire_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `photos`
--

CREATE TABLE `photos` (
  `idPho` int(11) NOT NULL,
  `design` varchar(255) NOT NULL,
  `interne_design` varchar(300) NOT NULL,
  `idSalle` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `photos`
--

INSERT INTO `photos` (`idPho`, `design`, `interne_design`, `idSalle`) VALUES
(35, 'img.jpg', 'img.jpg', 6),
(36, '66b9f8bf5f8b4.jpg', '66b9f8bf5f8b4.jpg', 11);

-- --------------------------------------------------------

--
-- Table structure for table `Proprietaire`
--

CREATE TABLE `Proprietaire` (
  `idPro` int(11) NOT NULL,
  `nomPrenom` varchar(100) NOT NULL,
  `adresse` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(6) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Proprietaire`
--

INSERT INTO `Proprietaire` (`idPro`, `nomPrenom`, `adresse`, `phone`, `email`, `password`, `role`, `created_at`, `update_at`) VALUES
(1, 'Odon Admin', 'besasavy Toliara', '0325648795', 'admin@gmail.com', '$2y$10$7JL.Ahmaf07iP26iZcF1j.yyRlscTDH/PSn0BMqRkqgBz.0A03CuK', 'admin', '2024-08-03 17:36:06', '2024-08-06 08:44:58'),
(2, 'Marc Jean', 'maninday', '0325648595', 'marc@gmail.com', '$2y$10$9KjkU3p8Oz5F8fSBfZOsGej1IAQQr8sVhG6v02ZwoDmvBBMvNAqIC', 'prop', '2024-08-03 17:44:26', '2024-08-06 08:45:22');

-- --------------------------------------------------------

--
-- Table structure for table `reservation`
--

CREATE TABLE `reservation` (
  `idReserv` int(11) NOT NULL,
  `nbrSalle` int(11) DEFAULT NULL,
  `dateDebut` date NOT NULL,
  `dateFin` date NOT NULL,
  `validation` tinyint(1) NOT NULL,
  `idSalle` int(11) NOT NULL,
  `idCli` int(11) NOT NULL,
  `create_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reservation`
--

INSERT INTO `reservation` (`idReserv`, `nbrSalle`, `dateDebut`, `dateFin`, `validation`, `idSalle`, `idCli`, `create_date`, `update_date`) VALUES
(1, 1, '2024-08-09', '2024-08-10', 1, 11, 5, '2024-08-09 02:18:41', '2024-08-15 13:18:30');

-- --------------------------------------------------------

--
-- Stand-in structure for view `reservation_salle_client`
-- (See below for the actual view)
--
CREATE TABLE `reservation_salle_client` (
`idReserv` int(11)
,`idSalle` int(11)
,`idCli` int(11)
,`dateDebut` date
,`dateFin` date
,`validation` tinyint(1)
,`nbrSalle` int(11)
,`subTitre` varchar(50)
,`titre` varchar(50)
,`design` varchar(255)
,`nomPrenom` varchar(200)
,`phone` varchar(15)
,`email` varchar(255)
);

-- --------------------------------------------------------

--
-- Table structure for table `salle`
--

CREATE TABLE `salle` (
  `idSalle` int(11) NOT NULL,
  `titre` varchar(50) NOT NULL,
  `subTitre` varchar(50) DEFAULT NULL,
  `Description` text NOT NULL,
  `prix` double NOT NULL,
  `occupation` tinyint(1) NOT NULL,
  `localName` varchar(100) NOT NULL,
  `longLatitude` varchar(50) DEFAULT NULL,
  `nbrPlace` int(11) DEFAULT NULL,
  `star` int(10) NOT NULL,
  `typeSalle` varchar(250) NOT NULL,
  `path_image` varchar(255) DEFAULT NULL,
  `idPro` int(11) NOT NULL,
  `create_date` timestamp NULL DEFAULT current_timestamp(),
  `update_date` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `salle`
--

INSERT INTO `salle` (`idSalle`, `titre`, `subTitre`, `Description`, `prix`, `occupation`, `localName`, `longLatitude`, `nbrPlace`, `star`, `typeSalle`, `path_image`, `idPro`, `create_date`, `update_date`) VALUES
(6, 'Coliseum Manjakamiadana', 'Coliseum manjaka', 'Batiment de tout evenements', 20000, 0, 'Manjakamiadana', NULL, 2000, 1, 'Coliseum', '', 2, '2024-08-07 01:30:51', NULL),
(11, 'Alibaba', 'Alibaba spectacle', 'salle de spectacle au vaste surface', 50000, 0, 'Paris', NULL, 0, 5, 'Salle de fete', NULL, 2, '2024-08-08 20:14:49', NULL);

-- --------------------------------------------------------

--
-- Stand-in structure for view `salle_image`
-- (See below for the actual view)
--
CREATE TABLE `salle_image` (
`idSalle` int(11)
,`titre` varchar(50)
,`subTitre` varchar(50)
,`Description` text
,`prix` double
,`occupation` tinyint(1)
,`localName` varchar(100)
,`longLatitude` varchar(50)
,`nbrPlace` int(11)
,`star` int(10)
,`typeSalle` varchar(250)
,`idPro` int(11)
,`idPho` int(11)
,`design` varchar(255)
,`interne_design` varchar(300)
);

-- --------------------------------------------------------

--
-- Structure for view `reservation_salle_client`
--
DROP TABLE IF EXISTS `reservation_salle_client`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `reservation_salle_client`  AS SELECT `reservation`.`idReserv` AS `idReserv`, `reservation`.`idSalle` AS `idSalle`, `reservation`.`idCli` AS `idCli`, `reservation`.`dateDebut` AS `dateDebut`, `reservation`.`dateFin` AS `dateFin`, `reservation`.`validation` AS `validation`, `reservation`.`nbrSalle` AS `nbrSalle`, `salle_image`.`subTitre` AS `subTitre`, `salle_image`.`titre` AS `titre`, `salle_image`.`design` AS `design`, `client`.`nomPrenom` AS `nomPrenom`, `client`.`phone` AS `phone`, `client`.`email` AS `email` FROM (((`salle_image` join `reservation` on(`salle_image`.`idSalle` = `reservation`.`idSalle`)) join `client` on(`reservation`.`idCli` = `client`.`idCli`)) join `Proprietaire` on(`salle_image`.`idPro` = `Proprietaire`.`idPro`)) ;

-- --------------------------------------------------------

--
-- Structure for view `salle_image`
--
DROP TABLE IF EXISTS `salle_image`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `salle_image`  AS SELECT `s`.`idSalle` AS `idSalle`, `s`.`titre` AS `titre`, `s`.`subTitre` AS `subTitre`, `s`.`Description` AS `Description`, `s`.`prix` AS `prix`, `s`.`occupation` AS `occupation`, `s`.`localName` AS `localName`, `s`.`longLatitude` AS `longLatitude`, `s`.`nbrPlace` AS `nbrPlace`, `s`.`star` AS `star`, `s`.`typeSalle` AS `typeSalle`, `s`.`idPro` AS `idPro`, `p`.`idPho` AS `idPho`, `p`.`design` AS `design`, `p`.`interne_design` AS `interne_design` FROM (`salle` `s` join `photos` `p`) WHERE `s`.`idSalle` = `p`.`idSalle` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`idCli`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `payement`
--
ALTER TABLE `payement`
  ADD PRIMARY KEY (`idPay`);

--
-- Indexes for table `persona_acces_token`
--
ALTER TABLE `persona_acces_token`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `photos`
--
ALTER TABLE `photos`
  ADD PRIMARY KEY (`idPho`),
  ADD KEY `photos_idSalle_foreign` (`idSalle`);

--
-- Indexes for table `Proprietaire`
--
ALTER TABLE `Proprietaire`
  ADD PRIMARY KEY (`idPro`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `reservation`
--
ALTER TABLE `reservation`
  ADD PRIMARY KEY (`idReserv`),
  ADD KEY `reservation_idcli_foreign` (`idCli`),
  ADD KEY `reservation_idsalle_foreign` (`idSalle`);

--
-- Indexes for table `salle`
--
ALTER TABLE `salle`
  ADD PRIMARY KEY (`idSalle`),
  ADD KEY `salle_idpro_foreign` (`idPro`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `client`
--
ALTER TABLE `client`
  MODIFY `idCli` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `payement`
--
ALTER TABLE `payement`
  MODIFY `idPay` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `persona_acces_token`
--
ALTER TABLE `persona_acces_token`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `photos`
--
ALTER TABLE `photos`
  MODIFY `idPho` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `Proprietaire`
--
ALTER TABLE `Proprietaire`
  MODIFY `idPro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `reservation`
--
ALTER TABLE `reservation`
  MODIFY `idReserv` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `salle`
--
ALTER TABLE `salle`
  MODIFY `idSalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `photos`
--
ALTER TABLE `photos`
  ADD CONSTRAINT `photos_idSalle_foreign` FOREIGN KEY (`idSalle`) REFERENCES `salle` (`idSalle`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `photoss_idSalle_foreign` FOREIGN KEY (`idSalle`) REFERENCES `salle` (`idSalle`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `reservation`
--
ALTER TABLE `reservation`
  ADD CONSTRAINT `reservation_idcli_foreign` FOREIGN KEY (`idCli`) REFERENCES `client` (`idCli`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reservation_idsalle_foreign` FOREIGN KEY (`idSalle`) REFERENCES `salle` (`idSalle`) ON UPDATE CASCADE;

--
-- Constraints for table `salle`
--
ALTER TABLE `salle`
  ADD CONSTRAINT `salle_idpro_foreign` FOREIGN KEY (`idPro`) REFERENCES `Proprietaire` (`idPro`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
