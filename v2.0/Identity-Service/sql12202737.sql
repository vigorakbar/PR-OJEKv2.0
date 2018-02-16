-- phpMyAdmin SQL Dump
-- version 4.7.1
-- https://www.phpmyadmin.net/
--
-- Host: sql12.freemysqlhosting.net
-- Generation Time: 08 Nov 2017 pada 13.37
-- Versi Server: 5.5.54-0ubuntu0.14.04.1
-- PHP Version: 7.0.22-0ubuntu0.16.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sql12202737`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `ID` int(14) NOT NULL,
  `name` varchar(50) NOT NULL,
  `username` varchar(25) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(50) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `driver` tinyint(1) NOT NULL,
  `image` varchar(50) NOT NULL DEFAULT './img/profile-placeholder.png'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`ID`, `name`, `username`, `email`, `password`, `phone_number`, `driver`, `image`) VALUES
(1, 'Jehian', 'reiva5', 'jehiannormansaviero@gmail.com', '1arext1ar', '081382525626', 0, './img/HMIF-Jehian.jpg'),
(2, 'Adya Naufal Fikri', 'adyanf', 'adyanf@gmail.com', 'opsrtisuc', '089510149602', 1, './img/HMIF-Adya.jpg'),
(3, 'Vigor Akbar', 'vigorakbar', 'vigorakbar@gmail.com', 'bsuigasum', '08812387183', 1, './img/HMIF-Vigor.jpg'),
(4, 'Turfa Auliarachman', 'kingfalcon', 'nangisdarah@gmail.com', 'thtorhrot', '082132400651', 1, './img/HMIF-Turfa.jpg'),
(5, 'Fildah Ananda Amalia', 'fildahfreeze', 'fildahanandaamalia@gmail.com', 'nadlsshhsd', '081381767784', 1, './img/HMIF-Fildah.jpg'),
(6, '12345678901234567890123456789012345678901234567890', '1234567890123456789012345', '12345678901234567890@gmail.com', '12345678901234567890123456789012345678901234567890', '087838283874', 0, './img/profile-placeholder.png'),
(7, 'Vigor Akbar', 'aya', 'aya@gmail.com', '12345678901234567890123456789012345678901234567890', '087838283874', 0, './img/profile-placeholder.png'),
(8, 'asdfasdf', 'adfasdf', 'sdadsf@gmail.com', 'vigor', '0982301923809', 0, './img/profile-placeholder.png'),
(9, 'dfasdfklj', 'vioioi', 'vioioi@gmail.com', 'vigor', '091238019238', 0, './img/profile-placeholder.png'),
(10, 'adsflksdf', 'opopopo', 'opopopo@gmail.com', 'vigorvig', '08782371082307', 0, './img/profile-placeholder.png'),
(11, 'adsflksdf', 'opopopo', 'opopopo@gmail.com', 'vigorvig', '08782371082307', 0, './img/profile-placeholder.png'),
(12, 'adsflksdf', 'opopopo', 'opopopo@gmail.com', 'vigorvig', '08782371082307', 0, './img/profile-placeholder.png'),
(13, 'adsflksdf', 'opopopo', 'opopopo@gmail.com', 'vigorvig', '08782371082307', 0, './img/profile-placeholder.png'),
(14, 'adsflksdf', 'opopopo', 'opopopo@gmail.com', 'vigorvig', '08782371082307', 0, './img/profile-placeholder.png'),
(15, 'adsflksdf', 'opopopo', 'opopopo@gmail.com', 'vigorvig', '08782371082307', 0, './img/profile-placeholder.png'),
(16, 'adsflksdf', 'opopopo', 'opopopo@gmail.com', 'vigorvig', '08782371082307', 0, './img/profile-placeholder.png'),
(17, 'adsflksdf', 'opopopo', 'opopopo@gmail.com', 'vigorvig', '08782371082307', 0, './img/profile-placeholder.png'),
(18, 'adsflksdf', 'opopopo', 'opopopo@gmail.com', 'vigorvig', '08782371082307', 0, './img/profile-placeholder.png'),
(19, 'vigorakbar', 'vigorakbar', 'vigorakbar@gmail.com', 'asdfasdf', '01283092830', 0, './img/profile-placeholder.png'),
(20, 'Namanya', 'gantengnih', 'email@ganteng.com', 'ganteng', '0850513121', 1, './img/profile-placeholder.png'),
(21, 'Namanya', 'gantengajah', 'emailemail@ganteng.com', 'ganteng', '0850513121', 1, './img/profile-placeholder.png');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users_token`
--

CREATE TABLE `users_token` (
  `ID` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` varchar(64) NOT NULL,
  `expiry` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `users_token`
--

INSERT INTO `users_token` (`ID`, `user_id`, `token`, `expiry`) VALUES
(1, 4, 'OlKVeyCYUtE1gkQJVWPoNbXQqKUwuunB', '2017-11-07 05:33:24'),
(2, 4, 'sU2T3WJBpaQPPUGQ7m48Lb842MLRhscY', '2017-11-07 05:40:16'),
(3, 4, 'SGWvZT9HUv90M1kgbygH0ONHLUsQ6hlLydtrXrhn9e2s0qOvW14nYaUatGDhMLFU', '2017-11-07 05:41:46'),
(4, 4, 'eWW6XADLI3ELYj9jpUscPhCBXs1RuS28MG6lQ6xCzmfRFkJSjtlVMyaOwJmAUAaU', '2017-11-09 03:00:10'),
(5, 10, 'ypcQBY8DWMILdQOC7tEudZxr0D5nXODxti5oOLX47u06MSQnv2MKlAInBmT1uDTz', '2017-11-09 03:06:43'),
(6, 3, 'Y6RbcFZVVjZIA3beidt08mAsNM6prFSAhEfZ1BcsNPhRASuLXe5yow30iGQSiT7r', '2017-11-09 03:10:55'),
(7, 4, '2LqjjCV0jAoKwJwgCAeYAK8486auG1Tg26MmzGmKPnmPQgYNu6m3prtnyWRHIL66', '2017-11-09 03:14:19'),
(8, 4, 'bjridlZgn6jRR7XWG2xTgH6NeRPqTS7o8JvaGicJTvAyU1qh3HAdDvfBEarw0s2C', '2017-11-09 03:14:26'),
(9, 4, 'En4LaDMegCPEZr6ASC6MZy3fR9w9jJc0uRSxgMZ1BZIPBf4edw7FZuFD68QZIxoS', '2017-11-09 03:48:54'),
(10, 4, 'Y2XRG7mlFYOjRuie7HTaQXEGiCPJE694VW2D4s99Za8IQsJeN2LLT9Bt9cKI65aJ', '2017-11-09 03:56:31'),
(11, 4, 'ow75VRSvCmewad0oiUHB0OLGxrmnPoKeSG26O0tnzHWyemB4N6RiF08KcBvKbhEn', '2017-11-09 04:04:14'),
(12, 4, '1Gsk7dTdvvSMIUQvOVaaCN8STUCRodu0v8F2SLkP7xTeamQVp7E4W4ifBTJWmwkw', '2017-11-09 04:32:37'),
(13, 4, 'xZHjoMRLohcl8LWgEXAfkcVQhviY1MaudOfcBerP9tVpuxS2pAs86EjkDPW6tkom', '2017-11-09 04:33:05'),
(14, 4, '5nH5XzNYPdIVEWmXi6nkvs4AzRCknetCBOH7axmQP7HNEnxkOwxhlSNLZQc8XXZS', '2017-11-09 04:34:20'),
(15, 4, 'pTQXBIzg3BHEnZ9agHn7mwOB6vzoIcDbMaWq191yyjSTVGNiZhmOob5jJFTo3bhB', '2017-11-09 04:35:17'),
(16, 21, 'E0lti2q8C8PRB4OHNMxTpAeiPvaLuqPOQSsuwZaL7Ljr6kOtEthPQwUvm1qQLkoD', '2017-11-09 04:41:32'),
(17, 21, 'HEHHSis7IIyOI7r9gv6dCK16mMbmAQp716qee1RxpoxC5TqobaK8h4xGsfPA4YSP', '2017-11-09 04:42:06'),
(18, 21, 'xZKmcqmzOugum5igCrBUZ7NMjCGVvux3Lv1bMM6kl8Zj9swmUkrCRQqR6mQRpjql', '2017-11-09 04:43:50'),
(19, 4, 'w8o2t2q73mgchg3XhAxoozFwxdQLJOfjC4C82mjAhC5Gw5Man4Y0llK3e1mcb32u', '2017-11-09 04:44:35'),
(20, 4, 'yy6H5pYTxBmjNVFqBZt6ctdCDxMX0sn8iIQKEVH2MGK192PKqFXwR8pBLYeQdOUK', '2017-11-09 05:02:30'),
(21, 4, 'AzyC8EAH1V5AagqpE3GgsX2p9pwrcD0N8IcyDYTp8kA619p0419YKLtBKR2w2i2S', '2017-11-09 05:02:56'),
(22, 4, 'BlEhufYaU511ZebaqPWKnhJAZVLSEoO4sEqTNCiwGI50MgLjCiz8jQA0hMyVOrAH', '2017-11-09 05:04:01'),
(23, 4, 'GGBydLkIS6EbhxbUJhGeDXmwHQPdZoUVHaucsP8UEk4bg0i8AUe6bGQ30XyQFKak', '2017-11-09 05:09:49'),
(24, 4, 'VIHGiLd0viMvdvznO0hzBBRA333tAMbn2bT3p4VVQkiUUrnp2tevfeZ9sMXbRFNq', '2017-11-09 05:09:50');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `users_token`
--
ALTER TABLE `users_token`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `token` (`token`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `ID` int(14) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT for table `users_token`
--
ALTER TABLE `users_token`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
