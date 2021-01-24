-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jan 24, 2021 at 03:59 PM
-- Server version: 10.5.4-MariaDB
-- PHP Version: 7.1.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hospital_ms`
--
CREATE DATABASE IF NOT EXISTS `hospital_ms` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `hospital_ms`;

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

DROP TABLE IF EXISTS `appointments`;
CREATE TABLE IF NOT EXISTS `appointments` (
  `appointment_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `description` text NOT NULL,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `appointment_status` enum('PENDING','ACCEPTED','COMPLETED','REJECTED','CANCELLED','PAID') NOT NULL DEFAULT 'PENDING',
  `comments` text DEFAULT NULL,
  PRIMARY KEY (`appointment_id`),
  KEY `fk_patient_id` (`patient_id`),
  KEY `fk_doctor_id` (`doctor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `appointments`
--

INSERT INTO `appointments` (`appointment_id`, `patient_id`, `doctor_id`, `description`, `date`, `time`, `appointment_status`, `comments`) VALUES
(23, 21, 18, 'This is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointmentThis is a test appointment', NULL, NULL, 'PAID', NULL),
(24, 21, 18, 'This is another test update', '2020-12-10', '10:50:00', 'COMPLETED', NULL),
(25, 21, 18, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer malesuada, tellus sed cursus luctus, nibh eros aliquet nulla, ut luctus nulla urna ac orci. Curabitur sodales vel augue eu lobortis. Fusce ornare eu dui quis gravida. Vivamus tempus rutrum leo. Nunc dignissim lacus luctus elit finibus, id luctus urna gravida. Etiam rutrum pretium augue sed fringilla. Etiam eu', '2021-01-24', '10:30:00', 'PAID', NULL),
(26, 21, 18, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer malesuada, tellus sed cursus luctus, nibh eros aliquet nulla, ut luctus nulla urna ac orci. Curabitur sodales vel augue eu lobortis. Fusce ornare eu dui quis gravida. Vivamus tempus rutrum leo. Nunc dignissim lacus luctus elit finibus, id luctus urna gravida. Etiam rutrum pretium augue sed fringilla. Etiam eu faucibus purus, vitae tempor orci. Quisque in consectetur dui. Aenean quis felis rutrum, iaculis metus ut, efficitur orci. Phasellus dignissim suscipit sapien at rhoncus. In porttitor ligula at felis sagittis placerat. Ut maximus ligula tellus, quis blandit sapien auctor aliquam.', NULL, NULL, 'REJECTED', 'The description is too long!!!'),
(27, 21, 18, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer malesuada, tellus sed cursus luctus, nibh eros aliquet nulla, ut luctus nulla urna ac orci. Curabitur sodales vel augue eu lobortis. Fusce ornare eu dui quis gravida. Vivamus tempus rutrum leo. Nunc dignissim lacus luctus elit finibus, id luctus urna gravida. Etiam rutrum pretium augue sed fringilla. Etiam eu faucibus purus, vitae tempor orci. Quisque in consectetur dui. Aenean quis felis rutrum, iaculis metus ut, efficitur orci. .', NULL, NULL, 'CANCELLED', NULL),
(28, 21, 23, 'another update from the app', NULL, NULL, 'CANCELLED', NULL),
(29, 21, 23, 'This is the first test appointment made from the mobile application.', '2021-01-22', '16:00:00', 'PAID', NULL),
(30, 21, 18, 'This is the second test appointment made from the mobile application.', '2021-01-30', '15:20:00', 'COMPLETED', NULL),
(31, 21, 23, 'Testing after all three is done!', NULL, NULL, 'CANCELLED', NULL),
(32, 21, 23, 'Another appointment', NULL, NULL, 'CANCELLED', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `lab_reports`
--

DROP TABLE IF EXISTS `lab_reports`;
CREATE TABLE IF NOT EXISTS `lab_reports` (
  `report_id` int(11) NOT NULL AUTO_INCREMENT,
  `lab_test_id` int(11) NOT NULL,
  `file_location` varchar(200) NOT NULL,
  PRIMARY KEY (`report_id`),
  KEY `fk_lab_test_id_reports` (`lab_test_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `lab_reports`
--

INSERT INTO `lab_reports` (`report_id`, `lab_test_id`, `file_location`) VALUES
(1, 7, '995928425.pdf'),
(2, 8, '875967253.pdf'),
(3, 9, '550506044.pdf'),
(4, 10, '879155912.pdf');

-- --------------------------------------------------------

--
-- Table structure for table `lab_tests`
--

DROP TABLE IF EXISTS `lab_tests`;
CREATE TABLE IF NOT EXISTS `lab_tests` (
  `test_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `details` text NOT NULL,
  `date` date DEFAULT NULL,
  `test_status` enum('ACCEPTED','COMPLETED','CANCELLED','PAID') NOT NULL,
  PRIMARY KEY (`test_id`),
  KEY `fk_user_id_tests` (`patient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `lab_tests`
--

INSERT INTO `lab_tests` (`test_id`, `patient_id`, `details`, `date`, `test_status`) VALUES
(7, 21, 'This is the first lab test', '2020-12-06', 'COMPLETED'),
(8, 21, 'This is the first lab test update from the phone!', '2021-01-21', 'COMPLETED'),
(9, 21, 'This is the second lab test from the phone! ', '2021-01-22', 'COMPLETED'),
(10, 21, 'This is my first lab test request!', '2021-01-23', 'COMPLETED'),
(11, 21, 'New lab test ', NULL, 'PAID');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
CREATE TABLE IF NOT EXISTS `payments` (
  `payment_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `payment_for` enum('APPOINTMENT','LAB_TEST') NOT NULL,
  `paid_amount` varchar(255) NOT NULL,
  `stripe_customer_id` varchar(255) NOT NULL,
  `payment_date` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`payment_id`),
  KEY `fk_patient_id_payments` (`patient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`payment_id`, `patient_id`, `payment_for`, `paid_amount`, `stripe_customer_id`, `payment_date`) VALUES
(1, 21, 'APPOINTMENT', '5000', 'cus_IWotWVOIiNGvoJ', '2020-12-07 20:33:38'),
(2, 21, 'LAB_TEST', '7000', 'cus_IWovzk0hhD4UIK', '2020-12-07 20:35:42'),
(3, 21, 'APPOINTMENT', '5000', 'cus_ImonHA8gDmvWKv', '2021-01-19 13:31:50'),
(4, 21, 'APPOINTMENT', '5000', 'pm_1IBOBoLBZWF63k5V4xC6Mvh0', '2021-01-19 23:10:28'),
(5, 21, 'APPOINTMENT', '5000', 'pm_1IBOKYLBZWF63k5VY6kHUS26', '2021-01-19 23:19:30'),
(6, 21, 'LAB_TEST', '7000', 'pm_1IBe2WLBZWF63k5VmkGdpgWG', '2021-01-20 16:05:55'),
(7, 21, 'LAB_TEST', '7000', 'pm_1IBeZ2LBZWF63k5VBONqPusa', '2021-01-20 16:39:32'),
(8, 21, 'APPOINTMENT', '5000', 'pm_1IByrQLBZWF63k5Vu8DvKi0S', '2021-01-21 14:19:53'),
(9, 21, 'LAB_TEST', '7000', 'pm_1IBys3LBZWF63k5VkrfKwMM9', '2021-01-21 14:20:31'),
(10, 21, 'LAB_TEST', '7000', 'pm_1ID9TNLBZWF63k5V9I8VtvB5', '2021-01-24 19:51:54');

-- --------------------------------------------------------

--
-- Table structure for table `prescriptions`
--

DROP TABLE IF EXISTS `prescriptions`;
CREATE TABLE IF NOT EXISTS `prescriptions` (
  `prescription_id` int(11) NOT NULL AUTO_INCREMENT,
  `doctor_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `appointment_id` int(11) NOT NULL,
  `prescription` text NOT NULL,
  `prescription_status` enum('PENDING','SHIPPED','RECEIVED','COMPLETED') NOT NULL,
  `prescription_location` text DEFAULT NULL,
  PRIMARY KEY (`prescription_id`),
  KEY `fk_doctor_id_prescriptions` (`doctor_id`),
  KEY `fk_patient_id_prescriptions` (`patient_id`),
  KEY `fk_appointment_id_prescriptions` (`appointment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `prescriptions`
--

INSERT INTO `prescriptions` (`prescription_id`, `doctor_id`, `patient_id`, `appointment_id`, `prescription`, `prescription_status`, `prescription_location`) VALUES
(1, 18, 21, 24, 'This is the prescription', 'COMPLETED', 'Updated location'),
(2, 18, 21, 25, 'This is the prescription for the app This is the prescription for the app This is the prescription for the app', 'RECEIVED', 'Dispatched from the Hospital'),
(3, 18, 21, 30, 'Test Prescription for video', 'RECEIVED', 'Updated location');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `full_name` varchar(200) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(200) NOT NULL,
  `contact` varchar(10) NOT NULL,
  `address` text DEFAULT NULL,
  `password` varchar(250) NOT NULL,
  `user_type` enum('ADMIN','DOCTOR','NURSE','STAFF','PATIENT') NOT NULL,
  `user_status` enum('ACTIVE','BLOCKED') NOT NULL DEFAULT 'ACTIVE',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `full_name`, `username`, `email`, `contact`, `address`, `password`, `user_type`, `user_status`) VALUES
(1, 'Admin Account', 'admin', 'admin@gmail.com', '0774235521', '', '202cb962ac59075b964b07152d234b70', 'ADMIN', 'ACTIVE'),
(18, 'Test Doctor 1', 'doctor1', 'doctor1@gmail.com', '0548184254', NULL, '202cb962ac59075b964b07152d234b70', 'DOCTOR', 'ACTIVE'),
(19, 'Test Nurse 1', 'nurse1', 'nurse1@gmail.com', '0548184254', NULL, '202cb962ac59075b964b07152d234b70', 'NURSE', 'ACTIVE'),
(20, 'Test Staff 1', 'staff1', 'staff1@gmail.com', '0548184254', NULL, '202cb962ac59075b964b07152d234b70', 'STAFF', 'ACTIVE'),
(21, 'Test Patient 1', 'patient1', 'patient1@gmail.com', '0548184254', 'Test address lane, Test address, Colombo', '202cb962ac59075b964b07152d234b70', 'PATIENT', 'ACTIVE'),
(22, 'Test Patient 2', 'patient2', 'patient2@gmail.com', '0725312355', '2B, 2nd Lane, Bambalapitiya', '202cb962ac59075b964b07152d234b70', 'PATIENT', 'ACTIVE'),
(23, 'Test Doctor 2', 'doctor2', 'doctor2@gmail.com', '0548555554', NULL, '202cb962ac59075b964b07152d234b70', 'DOCTOR', 'ACTIVE');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `fk_doctor_id` FOREIGN KEY (`doctor_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `fk_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `lab_reports`
--
ALTER TABLE `lab_reports`
  ADD CONSTRAINT `fk_lab_test_id_reports` FOREIGN KEY (`lab_test_id`) REFERENCES `lab_tests` (`test_id`);

--
-- Constraints for table `lab_tests`
--
ALTER TABLE `lab_tests`
  ADD CONSTRAINT `fk_user_id_tests` FOREIGN KEY (`patient_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `fk_patient_id_payments` FOREIGN KEY (`patient_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `prescriptions`
--
ALTER TABLE `prescriptions`
  ADD CONSTRAINT `fk_appointment_id_prescriptions` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`appointment_id`),
  ADD CONSTRAINT `fk_doctor_id_prescriptions` FOREIGN KEY (`doctor_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `fk_patient_id_prescriptions` FOREIGN KEY (`patient_id`) REFERENCES `users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
