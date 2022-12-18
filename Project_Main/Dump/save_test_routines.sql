-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: save_test
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `median`
--

DROP TABLE IF EXISTS `median`;
/*!50001 DROP VIEW IF EXISTS `median`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `median` AS SELECT 
 1 AS `account_number`,
 1 AS `merchant_name`,
 1 AS `median`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `absolute_deviation`
--

DROP TABLE IF EXISTS `absolute_deviation`;
/*!50001 DROP VIEW IF EXISTS `absolute_deviation`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `absolute_deviation` AS SELECT 
 1 AS `account_number`,
 1 AS `merchant_name`,
 1 AS `absolute_deviation`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `mad`
--

DROP TABLE IF EXISTS `mad`;
/*!50001 DROP VIEW IF EXISTS `mad`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `mad` AS SELECT 
 1 AS `account_number`,
 1 AS `merchant_name`,
 1 AS `median_absolute_deviation`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `median`
--

/*!50001 DROP VIEW IF EXISTS `median`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `median` AS select `dd`.`account_number` AS `account_number`,`dd`.`merchant_name` AS `merchant_name`,avg(`dd`.`transaction_amount`) AS `median` from (select `transactions`.`account_number` AS `account_number`,`transactions`.`merchant_name` AS `merchant_name`,`transactions`.`transaction_amount` AS `transaction_amount`,row_number() OVER (PARTITION BY `transactions`.`account_number`,`transactions`.`merchant_name` ORDER BY `transactions`.`transaction_amount` )  AS `rn`,count(0) OVER (PARTITION BY `transactions`.`account_number`,`transactions`.`merchant_name` )  AS `cnt` from `transactions`) `dd` where (`dd`.`rn` in (floor(((`dd`.`cnt` + 1) / 2)),floor(((`dd`.`cnt` + 2) / 2)))) group by `dd`.`account_number`,`dd`.`merchant_name` order by `dd`.`account_number`,`dd`.`merchant_name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `absolute_deviation`
--

/*!50001 DROP VIEW IF EXISTS `absolute_deviation`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `absolute_deviation` AS select `transactions`.`account_number` AS `account_number`,`transactions`.`merchant_name` AS `merchant_name`,abs((`transactions`.`transaction_amount` - `median`.`median`)) AS `absolute_deviation` from (`transactions` join `median` on(((`transactions`.`account_number` = `median`.`account_number`) and (`transactions`.`merchant_name` = `median`.`merchant_name`)))) order by `transactions`.`account_number`,`transactions`.`merchant_name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `mad`
--

/*!50001 DROP VIEW IF EXISTS `mad`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `mad` AS select `dd`.`account_number` AS `account_number`,`dd`.`merchant_name` AS `merchant_name`,avg(`dd`.`absolute_deviation`) AS `median_absolute_deviation` from (select `absolute_deviation`.`account_number` AS `account_number`,`absolute_deviation`.`merchant_name` AS `merchant_name`,`absolute_deviation`.`absolute_deviation` AS `absolute_deviation`,row_number() OVER (PARTITION BY `absolute_deviation`.`account_number`,`absolute_deviation`.`merchant_name` ORDER BY `absolute_deviation`.`absolute_deviation` )  AS `rn`,count(0) OVER (PARTITION BY `absolute_deviation`.`account_number`,`absolute_deviation`.`merchant_name` )  AS `cnt` from `absolute_deviation`) `dd` where (`dd`.`rn` in (floor(((`dd`.`cnt` + 1) / 2)),floor(((`dd`.`cnt` + 2) / 2)))) group by `dd`.`account_number`,`dd`.`merchant_name` order by `dd`.`account_number`,`dd`.`merchant_name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-17 21:51:12
