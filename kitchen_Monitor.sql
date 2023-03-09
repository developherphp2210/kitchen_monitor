-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versione server:              8.0.30 - MySQL Community Server - GPL
-- S.O. server:                  Win64
-- HeidiSQL Versione:            11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dump della struttura del database kitchen_monitor
CREATE DATABASE IF NOT EXISTS `kitchen_monitor` /*!40100 DEFAULT CHARACTER SET armscii8 COLLATE armscii8_bin */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `kitchen_monitor`;

-- Dump della struttura di tabella kitchen_monitor.impostazioni
CREATE TABLE IF NOT EXISTS `impostazioni` (
  `id` int DEFAULT NULL,
  `timer_refresh` int DEFAULT NULL,
  `max_articoli` int DEFAULT NULL,
  `ragsoc` varchar(50) COLLATE armscii8_bin DEFAULT NULL,
  `testo_scorrevole` text CHARACTER SET armscii8 COLLATE armscii8_bin,
  `testo_1` varchar(15) COLLATE armscii8_bin DEFAULT NULL,
  `testo_2` varchar(15) COLLATE armscii8_bin DEFAULT NULL,
  `colore_sfondo` varchar(8) COLLATE armscii8_bin DEFAULT NULL,
  `colore_testo` varchar(8) COLLATE armscii8_bin DEFAULT NULL,
  `colore_header` varchar(8) COLLATE armscii8_bin DEFAULT NULL,
  `colore_footer` varchar(8) COLLATE armscii8_bin DEFAULT NULL,
  `colore_box_1` varchar(8) COLLATE armscii8_bin DEFAULT NULL,
  `colore_box_2` varchar(8) COLLATE armscii8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;

-- Dump dei dati della tabella kitchen_monitor.impostazioni: ~1 rows (circa)
/*!40000 ALTER TABLE `impostazioni` DISABLE KEYS */;
INSERT INTO `impostazioni` (`id`, `timer_refresh`, `max_articoli`, `ragsoc`, `testo_scorrevole`, `testo_1`, `testo_2`, `colore_sfondo`, `colore_testo`, `colore_header`, `colore_footer`, `colore_box_1`, `colore_box_2`) VALUES
	(1, 5, 7, 'INFO & TEL SRL', 'MESSAGGIO PUBBLICITARIO SCORREVOLE POSSO INSERIRE ANCHE UN TESTO MOLTO LUNGO', 'Da Ritirare', 'In Preparazione', '#000000', '#ffffff', '#000000', '#008080', '#fa7000', '#00f504');
/*!40000 ALTER TABLE `impostazioni` ENABLE KEYS */;

-- Dump della struttura di tabella kitchen_monitor.ordini
CREATE TABLE IF NOT EXISTS `ordini` (
  `id` int NOT NULL AUTO_INCREMENT,
  `num_ordine` int DEFAULT NULL,
  `stato` int NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;

-- Dump dei dati della tabella kitchen_monitor.ordini: ~5 rows (circa)
/*!40000 ALTER TABLE `ordini` DISABLE KEYS */;
INSERT INTO `ordini` (`id`, `num_ordine`, `stato`, `created`, `updated`) VALUES
	(1, 5, 0, '2023-02-27 18:03:47', NULL),
	(2, 6, 1, '2023-02-27 18:03:59', '2023-03-05 18:43:31'),
	(3, 7, 1, '2023-02-27 18:04:06', '2023-03-05 18:39:36'),
	(4, 8, 1, '2023-02-27 18:04:16', '2023-03-05 18:10:33'),
	(5, 4, 1, '2023-02-27 18:05:23', '2023-03-06 21:07:07');
/*!40000 ALTER TABLE `ordini` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
