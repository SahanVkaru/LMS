-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3308
-- Generation Time: Oct 30, 2023 at 04:21 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lms`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddLabSheet` (IN `labsheet_id` CHAR(9), IN `title` VARCHAR(255), IN `due_date` DATETIME, IN `course_code` CHAR(7))   BEGIN
  INSERT INTO labsheet (labsheet_id, title, due_date, course_code)
  VALUES (labsheet_id, title, due_date, course_code);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddPastpapers` (IN `paper_title` VARCHAR(255), IN `year` YEAR, IN `level` CHAR(6), IN `semester` CHAR(4), IN `course_code` CHAR(7))   BEGIN 
	INSERT INTO Past_Papers (paper_title, year, level, semester, course_code)
	VALUES (paper_title, year, level, semester, course_code );
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CA_DETAILS_of_a_COURSE` (IN `Course_code` CHAR(7))   BEGIN
	select * FROM ca_eligibility c where c.Course_code = Course_code;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CA_DETAILS_of_a_Course_for_STUDENT` (IN `STUDENT_Reg_no` CHAR(6), IN `Course_code` CHAR(7))   BEGIN
select * FROM ca_eligibility c 
where c.Course_code = Course_code AND c.STUDENT_Reg_no = STUDENT_Reg_no ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CA_DETAILS_of_a__batch` (IN `batch` INT(4))   BEGIN
SELECT c.* FROM ca_eligibility c,student s 
WHERE s.Entrance_year = batch AND s.Reg_no = c.STUDENT_Reg_no;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CA_DETAILS_of_a__STUDENT` (IN `STUDENT_Reg_no` CHAR(6))   BEGIN
select * FROM ca_eligibility c 
where c.STUDENT_Reg_no = STUDENT_Reg_no ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Create_users_account` (IN `usertype` VARCHAR(30), IN `username` CHAR(5), IN `password` VARCHAR(30))   BEGIN
    DECLARE i INT;
    DECLARE create_user_sql VARCHAR(255);
    DECLARE selectusername VARCHAR(255);
    DECLARE grant_select_sql VARCHAR(255);
    DECLARE revoke_select_sql VARCHAR(255);
	

    SET create_user_sql = CONCAT('CREATE USER ', username, '@''localhost'' IDENTIFIED BY ''', password, ''';');

    
    SET @create_user_sql = create_user_sql;
    PREPARE create_user_stmt FROM @create_user_sql;
    EXECUTE create_user_stmt;
    DEALLOCATE PREPARE create_user_stmt;


    SET grant_select_sql = CONCAT('GRANT ALL PRIVILEGES ON final.* TO ', username, '@''localhost'';');
    SET revoke_select_sql = CONCAT('REVOKE GRANT OPTION ON final.* FROM ', username, '@''localhost'';');


    SET @privilleges=grant_select_sql;
    PREPARE grant_select FROM @privilleges;
    EXECUTE grant_select;
    DEALLOCATE PREPARE grant_select;


    SET @privilleges=revoke_select_sql;
    PREPARE revoke_select FROM @privilleges;
    EXECUTE revoke_select;
    DEALLOCATE PREPARE revoke_select;

    SELECT staff_no INTO selectusername FROM staff WHERE staff_no = username;

    INSERT INTO staff_account (Staff_account_type, Staff_user_name, Staff_password) VALUES (usertype, username, password);

  
    SET i = ROW_COUNT();

  
    IF i = 0 THEN
        SELECT "User not found";
    ELSE
        SELECT "Successful insert account";
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Create_users_lec_account` (IN `usertype` VARCHAR(30), IN `username` CHAR(5), IN `password` VARCHAR(30))   BEGIN
    DECLARE i INT;
    DECLARE create_user_sql VARCHAR(255);
    DECLARE selectusername VARCHAR(255);
    DECLARE grant_select_sql VARCHAR(255);
    DECLARE revoke_select_sql VARCHAR(255);
	

    SET create_user_sql = CONCAT('CREATE USER ', username, '@''localhost'' IDENTIFIED BY ''', password, ''';');

    
    SET @create_user_sql = create_user_sql;
    PREPARE create_user_stmt FROM @create_user_sql;
    EXECUTE create_user_stmt;
    DEALLOCATE PREPARE create_user_stmt;


    SET grant_select_sql = CONCAT('GRANT ALL PRIVILEGES ON lms.* TO ', username, '@''localhost'';');
    SET revoke_select_sql = CONCAT('REVOKE GRANT OPTION ON lms.* FROM ', username, '@''localhost'';');


    SET @privilleges=grant_select_sql;
    PREPARE grant_select FROM @privilleges;
    EXECUTE grant_select;
    DEALLOCATE PREPARE grant_select;


    SET @privilleges=revoke_select_sql;
    PREPARE revoke_select FROM @privilleges;
    EXECUTE revoke_select;
    DEALLOCATE PREPARE revoke_select;

    SELECT staff_no INTO selectusername FROM staff WHERE staff_no = username;

    INSERT INTO staff_account (Staff_account_type, Staff_user_name, Staff_password) VALUES (usertype, username, password);

  
    SET i = ROW_COUNT();

  
    IF i = 0 THEN
        SELECT "User not found";
    ELSE
        SELECT "Successful insert account";
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Create_users_tec_account` (IN `usertype` VARCHAR(30), IN `username` CHAR(5), IN `password` VARCHAR(30))   BEGIN
    DECLARE i INT;
    DECLARE create_user_sql VARCHAR(255);
    DECLARE selectusername VARCHAR(255);
    DECLARE grant_select_sql VARCHAR(255);
    DECLARE revoke_select_sql VARCHAR(255);
	

    SET create_user_sql = CONCAT('CREATE USER ', username, '@''localhost'' IDENTIFIED BY ''', password, ''';');

    
    SET @create_user_sql = create_user_sql;
    PREPARE create_user_stmt FROM @create_user_sql;
    EXECUTE create_user_stmt;
    DEALLOCATE PREPARE create_user_stmt;


    SET grant_select_sql = CONCAT('GRANT SELECT,CREATE,UPDATE ON lms.* TO ', username, '@''localhost'';');
    SET revoke_select_sql = CONCAT('REVOKE GRANT OPTION ON lms.* FROM ', username, '@''localhost'';');


    SET @privilleges=grant_select_sql;
    PREPARE grant_select FROM @privilleges;
    EXECUTE grant_select;
    DEALLOCATE PREPARE grant_select;


    SET @privilleges=revoke_select_sql;
    PREPARE revoke_select FROM @privilleges;
    EXECUTE revoke_select;
    DEALLOCATE PREPARE revoke_select;

    SELECT staff_no INTO selectusername FROM staff WHERE staff_no = username;

    INSERT INTO staff_account (Staff_account_type, Staff_user_name, Staff_password) VALUES (usertype, username, password);

  
    SET i = ROW_COUNT();

  
    IF i = 0 THEN
        SELECT "User not found";
    ELSE
        SELECT "Successful insert account";
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Credit` ()   BEGIN
    ALTER TABLE course ADD COLUMN Credits INT;


    UPDATE course
    SET Credits = CASE
        WHEN course_code = 'BST1113' THEN 1
        WHEN course_code = 'BST1222' THEN 2
        WHEN course_code = 'BST2113' THEN 3
        WHEN course_code = 'BST2213' THEN 4
        WHEN course_code = 'BST3133' THEN 1
        WHEN course_code = 'BST3222' THEN 2
        WHEN course_code = 'BST4113' THEN 3
        WHEN course_code = 'BST4222' THEN 4
        WHEN course_code = 'ENG1212' THEN 1
        WHEN course_code = 'ET1112' THEN 2
        WHEN course_code = 'ET1223' THEN 3
        WHEN course_code = 'ET2122' THEN 4
        WHEN course_code = 'ET2243' THEN 1
        WHEN course_code = 'ET3112' THEN 2
        WHEN course_code = 'ET3222' THEN 3
        WHEN course_code = 'ET4114' THEN 4
        WHEN course_code = 'ET4242' THEN 1
        WHEN course_code = 'ICT1112' THEN 2
        WHEN course_code = 'ICT1123' THEN 3
        WHEN course_code = 'ICT1242' THEN 4
        WHEN course_code = 'ICT1243' THEN 1
        WHEN course_code = 'ICT1244' THEN 2
        WHEN course_code = 'ICT1245' THEN 3
        WHEN course_code = 'ICT1246' THEN 4
        WHEN course_code = 'ICT1247' THEN 1
        WHEN course_code = 'ICT2112' THEN 2
        WHEN course_code = 'ICT2223' THEN 3
        WHEN course_code = 'ICT3112' THEN 4
        WHEN course_code = 'ICT3234' THEN 1
        WHEN course_code = 'ICT4123' THEN 2
        WHEN course_code = 'ICT4243' THEN 3
        ELSE 4
    END;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `department` (IN `department` VARCHAR(10))   BEGIN
    DECLARE lec_exists INT;
    
    SELECT COUNT(*) INTO lec_exists FROM staffdepartment WHERE Department_name=department;

    IF lec_exists = 0 THEN
        SELECT "Department not found";
    ELSE
        SELECT "Successful Found details";
        SELECT * FROM staffdepartment WHERE department_name = department;
    END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `enrol_stud` (IN `course_code` VARCHAR(7))   BEGIN
	SELECT STUDENT_Reg_no AS 'Students enrolled to the given course'
	FROM student_course
	WHERE COURSE_code = course_code;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `find_attendance_for_a_batch` (IN `batch` INT)   BEGIN
    SELECT a.*
    FROM attendence_detalis a
    JOIN student s ON s.Entrance_year = batch AND s.Reg_no = a.STUDENT_Reg_no;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `find_Result_of_a_course` (IN `Course_code` CHAR(7))   BEGIN
SELECT * FROM result_details r WHERE r.Course_code= Course_code ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `find_Result_of_a_student` (IN `STUDENT_Reg_no` CHAR(6))   BEGIN
SELECT * FROM result_details r 
WHERE r.STUDENT_Reg_no = STUDENT_Reg_no ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `find_Result_of_student_course` (IN `STUDENT_Reg_no` CHAR(6), IN `Course_code` CHAR(7))   BEGIN
SELECT * FROM result_details r 
WHERE r.STUDENT_Reg_no = STUDENT_Reg_no AND  r.Course_code= Course_code ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetLecturerCourses` (IN `lecturerID` INT)   BEGIN
  SELECT c.course_code, c.name
  FROM course c
  WHERE c.department_name = (SELECT department_name FROM Lecturer WHERE lecturer_id = lecturerID);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetStudentCourses` (IN `studentRegNo` CHAR(6))   BEGIN
  SELECT c.course_code, c.name
  FROM Student_Course sc
  JOIN course c ON sc.COURSE_code = c.course_code
  WHERE sc.STUDENT_Reg_no = studentRegNo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Gpv` ()   BEGIN
ALTER TABLE result ADD GPV_Value DECIMAL(3, 1);
UPDATE result SET GPV_Value = ROUND(0.1 + (RAND() * 3.8), 1);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_attendance_data` (IN `Attendance_id` VARCHAR(5), IN `Medical_status` BOOLEAN, IN `Attendance_status` BOOLEAN, IN `Date` DATE, IN `Course_code` CHAR(7), IN `STUDENT_Reg_no` CHAR(6))   BEGIN
    INSERT INTO attendance(Attendance_id, Medical_status, Attendance_status, Date, Course_code, STUDENT_Reg_no)
    VALUES (Attendance_id, Medical_status, Attendance_status, Date, Course_code, STUDENT_Reg_no);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lectureAccount` (IN `lecid` CHAR(5))   BEGIN
    DECLARE lec_exists INT;
    
    SELECT COUNT(*) INTO lec_exists FROM LectureAccount WHERE Staff_user_name = lecid;

    IF lec_exists = 0 THEN
        SELECT "Lecture not found";
    ELSE
        SELECT "Successful account details";
        SELECT * FROM LectureAccount WHERE Staff_user_name = lecid;
    END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lectureContact` (IN `lecid` CHAR(5))   BEGIN
    DECLARE lec_exists INT;
    
    SELECT COUNT(*) INTO lec_exists FROM lecturecountact WHERE  staff_no = lecid;

    IF lec_exists = 0 THEN
        SELECT "Lecture not found";
    ELSE
        SELECT "Successful account details";
        SELECT * FROM lecturecountact WHERE staff_no= lecid;
    END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lecture_in_bst` (IN `lecid` CHAR(5))   BEGIN
    DECLARE lec_exists INT;
    
    SELECT COUNT(*) INTO lec_exists FROM staffdepartment WHERE staff_no LIKE "LEC__" AND staff_no=lecid AND Department_name="BST";

    IF lec_exists = 0 THEN
        SELECT "Lecture not found";
    ELSE
        SELECT "Successful Found details";
        SELECT * FROM staffdepartment WHERE staff_no = lecid;
    END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lecture_in_ET` (IN `lecid` CHAR(5))   BEGIN
    DECLARE lec_exists INT;
    
    SELECT COUNT(*) INTO lec_exists FROM staffdepartment WHERE staff_no LIKE "LEC__" AND staff_no=lecid AND Department_name="ET";

    IF lec_exists = 0 THEN
        SELECT "Lecture not found";
    ELSE
        SELECT "Successful Found details";
        SELECT * FROM staffdepartment WHERE staff_no = lecid;
    END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lecture_in_ICT` (IN `lecid` CHAR(5))   BEGIN
    DECLARE lec_exists INT;
    
    SELECT COUNT(*) INTO lec_exists FROM staffdepartment WHERE staff_no LIKE "LEC__" AND staff_no=lecid AND Department_name="ict";

    IF lec_exists = 0 THEN
        SELECT "Lecture not found";
    ELSE
        SELECT "Successful Found details";
        SELECT * FROM staffdepartment WHERE staff_no = lecid;
    END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `staff_insert` (IN `staff_no` CHAR(5), IN `name` VARCHAR(50), IN `position` VARCHAR(20), IN `gender` VARCHAR(6), IN `home_address` VARCHAR(20), IN `street_address` VARCHAR(20), IN `country` VARCHAR(25))   BEGIN

INSERT INTO staff VALUES(staff_no,name,position,gender,home_address,street_address,country);
       
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `StudentPreLab` (IN `studentRegNo` CHAR(6))   BEGIN
  SELECT ls.labsheet_id, ls.title, ls.due_date
  FROM Student_Course sc
  JOIN labsheet ls ON sc.COURSE_code = ls.course_code
  WHERE sc.STUDENT_Reg_no = studentRegNo AND ls.due_date < NOW();
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `StudentUpcomeLab` (IN `studentRegNo` CHAR(6))   BEGIN
  SELECT ls.labsheet_id, ls.title, ls.due_date
  FROM Student_Course sc
  JOIN labsheet ls ON sc.COURSE_code = ls.course_code
  WHERE sc.STUDENT_Reg_no = studentRegNo AND ls.due_date > NOW();
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `stud_count` (IN `Dep_name` VARCHAR(3))   BEGIN
	SELECT COUNT(STUDENT_Reg_no) AS 'Number of Students over all levels within that department'
	FROM Student_department
	WHERE DEPARTMENT_name = Dep_name;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `stud_place` (IN `province_name` VARCHAR(15))   BEGIN
	SELECT 'Enter a city or a province starting from capital letters' AS 'Instructions';
	SELECT Reg_no As 'Student Register Number', First_name AS 'Student First Name', Last_name AS 'Student Last name'
	FROM Student
	WHERE Street_address LIKE province_name;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateacademics` (IN `Reg_No` CHAR(5), IN `dep_name` VARCHAR(10), IN `course_code` CHAR(7))   BEGIN
	UPDATE student_department SET DEPARTMENT_name=dep_name WHERE STUDENT_Reg_no=Reg_NO;
	UPDATE student_course SET COURSE_code=course_code WHERE STUDENT_Reg_no = Reg_No;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updatepassword` (IN `username` CHAR(5), IN `password` VARCHAR(30))   BEGIN
    DECLARE i INT;
    
    UPDATE staff_account
    SET staff_password = password
    WHERE Staff_user_name = username;
    
   
    SET i = ROW_COUNT();
    
    IF i = 0 THEN
        SELECT "User not found";
    ELSE
        SELECT "Password updated";
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `assement`
--

CREATE TABLE `assement` (
  `Submisson_id` char(5) NOT NULL,
  `Assement_type` varchar(30) DEFAULT NULL,
  `Score` int(11) DEFAULT NULL,
  `Due_date` datetime DEFAULT NULL,
  `Submission_date` datetime DEFAULT NULL,
  `Attendance_id_FK` char(5) NOT NULL,
  `Course_code` char(7) NOT NULL,
  `STUDENT_Reg_no` char(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `assement`
--

INSERT INTO `assement` (`Submisson_id`, `Assement_type`, `Score`, `Due_date`, `Submission_date`, `Attendance_id_FK`, `Course_code`, `STUDENT_Reg_no`) VALUES
('S0001', 'Homework', 95, '2023-11-05 00:00:00', '2023-11-04 00:00:00', 'A0001', 'ICT4123', 'TG0200'),
('S0002', 'MID_exam', 96, '2023-11-10 00:00:00', '2023-11-04 00:00:00', 'A0001', 'ICT4123', 'TG0200'),
('S0003', 'MID_exam', 88, '2023-11-10 00:00:00', '2023-11-03 00:00:00', 'A0002', 'ICT4123', 'TG0203'),
('S0004', 'Homework', 92, '2023-11-12 00:00:00', '2023-11-04 00:00:00', 'A0003', 'ICT4123', 'TG0207');

-- --------------------------------------------------------

--
-- Stand-in structure for view `assement_details`
-- (See below for the actual view)
--
CREATE TABLE `assement_details` (
`Submisson_id` char(5)
,`Assement_type` varchar(30)
,`Score` int(11)
,`Due_date` datetime
,`Submission_date` datetime
,`Attendance_id_FK` char(5)
,`Course_code` char(7)
,`STUDENT_Reg_no` char(6)
,`ATTENDECE_for_Assement` varchar(10)
);

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `Attendance_id` char(5) NOT NULL,
  `Medical_status` tinyint(1) DEFAULT NULL,
  `Attendance_status` tinyint(1) DEFAULT NULL,
  `Date` date DEFAULT NULL,
  `Course_code` char(7) NOT NULL,
  `STUDENT_Reg_no` char(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`Attendance_id`, `Medical_status`, `Attendance_status`, `Date`, `Course_code`, `STUDENT_Reg_no`) VALUES
('A0001', 1, 0, '2023-10-25', 'ICT4243', 'TG0200'),
('A0002', 0, 0, '2023-10-25', 'ICT4123', 'TG0200'),
('A0003', 0, 1, '2023-10-25', 'ICT4123', 'TG0203'),
('A0004', 0, 1, '2023-10-25', 'ICT4123', 'TG0207'),
('A0005', 1, 0, '2023-10-25', 'ICT4243', 'TG0240'),
('A0006', 1, 0, '2023-10-30', 'ICT4123', 'TG0200');

-- --------------------------------------------------------

--
-- Stand-in structure for view `attendence_detalis`
-- (See below for the actual view)
--
CREATE TABLE `attendence_detalis` (
`STUDENT_Reg_no` char(6)
,`Course_code` char(7)
,`Attendance_Count` decimal(22,0)
,`Attendance_AS_A_presentage` decimal(29,4)
,`ATTENDANCE_Eligibility` varchar(12)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `ca_eligibility`
-- (See below for the actual view)
--
CREATE TABLE `ca_eligibility` (
`STUDENT_Reg_no` char(6)
,`Course_code` char(7)
,`Num_Assessments` bigint(21)
,`Final_CA_MARKES` decimal(36,4)
,`CA_Eligibility` varchar(12)
);

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `course_code` char(7) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `course_hours` decimal(10,0) DEFAULT NULL,
  `department_name` varchar(10) DEFAULT NULL,
  `Credits` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `course`
--

INSERT INTO `course` (`course_code`, `name`, `course_hours`, `department_name`, `Credits`) VALUES
('BST1113', 'Introduction to Biological Systems', 45, 'BST', 1),
('BST1222', 'Bioinformatics', 45, 'BST', 2),
('BST2113', 'Biochemistry', 60, 'BST', 3),
('BST2213', 'Plant Biotechnology', 60, 'BST', 4),
('BST3133', 'Food Biotechnology', 40, 'BST', 1),
('BST3222', 'Stem Cell Biology', 45, 'BST', 2),
('BST4113', 'Pharmacology and Drug Development', 40, 'BST', 3),
('BST4222', 'Biosecurity and Biosafety', 45, 'BST', 4),
('ENG1212', 'English II', 30, 'MDS', 1),
('ET1112', 'Engineering Fundamentals', 45, 'ET', 2),
('ET1223', 'Technical Drawing and Blueprint Reading', 38, 'ET', 3),
('ET2122', 'Fluid Mechanics', 42, 'ET', 4),
('ET2243', 'Mechanical Design and Analysis', 40, 'ET', 1),
('ET3112', 'Engineering Project Management', 40, 'ET', 2),
('ET3222', 'Computer Networks for Engineers', 60, 'ET', 3),
('ET4114', 'Robotics and Automation', 80, 'ET', 4),
('ET4242', 'Advanced Manufacturing Processes', 40, 'ET', 1),
('ICT1112', 'Introduction to Programming', 45, 'ICT', 2),
('ICT1123', 'Web Development Fundamentals', 30, 'ICT', 3),
('ICT1242', 'Computer Architecture', 30, 'ICT', 4),
('ICT1243', 'Database Management Systems', 30, 'ICT', 1),
('ICT1244', 'Database Management Systems Practicum', 60, 'ICT', 2),
('ICT1245', 'Computer Networks', 60, 'ICT', 3),
('ICT1246', 'Discrete Mathematics', 45, 'ICT', 4),
('ICT1247', 'Server-Side Web Development', 60, 'ICT', 1),
('ICT2112', 'Software Development Fundamentals', 45, 'ICT', 2),
('ICT2223', 'Object-Oriented Programming', 45, 'ICT', 3),
('ICT3112', 'Database Administration', 42, 'ICT', 4),
('ICT3234', 'Machine Learning and AI', 45, 'ICT', 1),
('ICT4123', 'Cybersecurity Management', 38, 'ICT', 2),
('ICT4243', 'Ethical Hacking and Penetration Testing', 38, 'ICT', 3);

-- --------------------------------------------------------

--
-- Stand-in structure for view `coursedetailsview`
-- (See below for the actual view)
--
CREATE TABLE `coursedetailsview` (
`COURSE_code` char(10)
,`STUDENT_Reg_no` char(6)
,`name` varchar(255)
);

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `Name` varchar(10) NOT NULL,
  `Location` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`Name`, `Location`) VALUES
('BST', 'Faculty of Technology'),
('ET', 'Faculty of Technology'),
('ICT', 'Faculty of Technology'),
('MDS', 'Faculty of Technology');

-- --------------------------------------------------------

--
-- Table structure for table `labsheet`
--

CREATE TABLE `labsheet` (
  `labsheet_id` char(9) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `due_date` datetime DEFAULT NULL,
  `course_code` char(7) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `labsheet`
--

INSERT INTO `labsheet` (`labsheet_id`, `title`, `due_date`, `course_code`) VALUES
('BST111303', 'Introduction to Biological Systems Practical 03', '2023-11-20 16:00:00', 'BST1113'),
('BST122212', 'Bioinformatics Practical 12', '2023-11-21 17:00:00', 'BST1222'),
('BST211317', 'Biochemistry Practical 17', '2023-11-22 18:00:00', 'BST2113'),
('BST221206', 'Plant Biotechnology Practical 06', '2023-11-23 19:00:00', 'BST2213'),
('BST313401', 'Food Biotechnology Practical 01', '2023-11-24 20:00:00', 'BST3133'),
('BST322312', 'Stem Cell Biology Practical 12', '2023-11-25 21:00:00', 'BST3222'),
('BST411209', 'Pharmacology and Drug Development Practical 09', '2023-11-26 22:00:00', 'BST4113'),
('BST422210', 'Biosecurity and Biosafety Practical 10', '2023-11-27 23:00:00', 'BST4222'),
('ENG121213', 'English II Practical 13', '2023-11-03 13:00:00', 'ENG1212'),
('ET111203', 'Engineering Fundamentals Practical 03', '2023-11-12 22:00:00', 'ET1112'),
('ET122312', 'Technical Drawing and Blueprint Reading Practical 12', '2023-11-13 23:00:00', 'ET1223'),
('ET212215', 'Fluid Mechanics Practical 15', '2023-11-14 10:00:00', 'ET2122'),
('ET224308', 'Mechanical Design and Analysis Practical 08', '2023-11-15 11:00:00', 'ET2243'),
('ET311210', 'Engineering Project Management Practical 10', '2023-11-16 12:00:00', 'ET3112'),
('ET322203', 'Computer Networks for Engineers Practical 03', '2023-11-17 13:00:00', 'ET3222'),
('ET411410', 'Robotics and Automation Practical 10', '2023-11-18 14:00:00', 'ET4114'),
('ET424214', 'Advanced Manufacturing Processes Practical 14', '2023-11-19 15:00:00', 'ET4242'),
('ICT111202', 'Introduction to Programming Practical 02', '2023-11-04 14:00:00', 'ICT1112'),
('ICT112317', 'Web Development Fundamentals Practical 17', '2023-11-05 15:00:00', 'ICT1123'),
('ICT124201', 'Computer Architecture Practical 01', '2023-11-01 15:00:00', 'ICT1242'),
('ICT124312', 'Database Management Systems Practical 12', '2023-11-24 00:00:00', 'ICT1243'),
('ICT124424', 'Database Management Systems Practicum 24', '2023-12-06 09:30:00', 'ICT1244'),
('ICT124536', 'Computer Networks Practical 36', '2023-12-18 19:15:00', 'ICT1245'),
('ICT124648', 'Discrete Mathematics Practical 48', '2023-12-30 13:45:00', 'ICT1246'),
('ICT124760', 'Server-Side Web Development Practical 60', '2024-01-11 08:30:00', 'ICT1247'),
('ICT211215', 'Software Development Fundamentals Practical 15', '2023-11-06 16:00:00', 'ICT2112'),
('ICT222314', 'Object-Oriented Programming Practical 14', '2023-11-07 17:00:00', 'ICT2223'),
('ICT311206', 'Database Administration Practical 06', '2023-11-08 18:00:00', 'ICT3112'),
('ICT323401', 'Machine Learning and AI Practical 01', '2023-11-09 19:00:00', 'ICT3234'),
('ICT412312', 'Cybersecurity Management Practical 12', '2023-11-10 20:00:00', 'ICT4123'),
('ICT424309', 'Ethical Hacking and Penetration Testing Practical 09', '2023-11-11 21:00:00', 'ICT4243'),
('ICT424310', 'TEST Lab Sheet', '2023-12-31 14:00:00', 'ICT4243');

-- --------------------------------------------------------

--
-- Stand-in structure for view `lectureaccount`
-- (See below for the actual view)
--
CREATE TABLE `lectureaccount` (
`Staff_user_name` char(5)
,`Name` varchar(25)
,`Staff_account_type` varchar(30)
,`Staff_password` varchar(30)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `lecturecountact`
-- (See below for the actual view)
--
CREATE TABLE `lecturecountact` (
`staff_no` char(5)
,`telephone` char(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `level`
-- (See below for the actual view)
--
CREATE TABLE `level` (
`Entrance_year` year(4)
,`Level` varchar(7)
,`StudentCount` bigint(21)
);

-- --------------------------------------------------------

--
-- Table structure for table `past_papers`
--

CREATE TABLE `past_papers` (
  `past_paper_index` int(3) NOT NULL,
  `paper_title` varchar(255) NOT NULL,
  `year` year(4) NOT NULL,
  `level` char(6) NOT NULL,
  `semester` char(4) NOT NULL,
  `course_code` char(7) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `past_papers`
--

INSERT INTO `past_papers` (`past_paper_index`, `paper_title`, `year`, `level`, `semester`, `course_code`) VALUES
(1, 'Computer Architecture 2015 Level 1 Semester 2', '2015', 'level1', 'sem2', 'ICT1242'),
(2, 'Database Management Systems 2016 Level 1 Semester 2', '2016', 'level1', 'sem2', 'ICT1243'),
(3, 'Database Management Systems Practicum 2017 Level 1 Semester 2', '2017', 'level1', 'sem2', 'ICT1244'),
(4, 'Computer Networks 2018 Level 1 Semester 2', '2018', 'level1', 'sem2', 'ICT1245'),
(5, 'Discrete Mathematics 2019 Level 1 Semester 2', '2019', 'level1', 'sem2', 'ICT1246'),
(6, 'Server-Side Web Development 2020 Level 1 Semester 2', '2020', 'level1', 'sem2', 'ICT1247'),
(7, 'English II 2021 Level 1 Semester 2', '2021', 'level2', 'sem1', 'ENG1212'),
(8, 'Introduction to Programming 2015 Level 1 Semester 1', '2015', 'level1', 'sem1', 'ICT1112'),
(9, 'Web Development Fundamentals 2016 Level 1 Semester 1', '2016', 'level1', 'sem1', 'ICT1123'),
(10, 'Software Development Fundamentals 2017 Level 2 Semester 1', '2017', 'level2', 'sem1', 'ICT2112'),
(11, 'Object-Oriented Programming 2018 Level 2 Semester 2', '2018', 'level2', 'sem2', 'ICT2223'),
(12, 'Database Administration 2019 Level 3 Semester 1', '2019', 'level3', 'sem1', 'ICT3112'),
(13, 'Machine Learning and AI 2020 Level 3 Semester 2', '2020', 'level3', 'sem2', 'ICT3234'),
(14, 'Cybersecurity Management 2021 Level 4 Semester 1', '2021', 'level4', 'sem1', 'ICT4123'),
(15, 'Ethical Hacking and Penetration Testing 2015 Level 4 Semester 2', '2015', 'level4', 'sem2', 'ICT4243'),
(16, 'Engineering Fundamentals 2016 Level 1 Semester 1', '2016', 'level1', 'sem1', 'ET1112'),
(17, 'Technical Drawing and Blueprint Reading 2017 Level 1 Semester 2', '2017', 'level1', 'sem2', 'ET1223'),
(18, 'Fluid Mechanics 2018 Level 2 Semester 1', '2018', 'level2', 'sem1', 'ET2122'),
(19, 'Mechanical Design and Analysis 2019 Level 2 Semester 2', '2019', 'level2', 'sem2', 'ET2243'),
(20, 'Engineering Project Management 2020 Level 3 Semester 1', '2020', 'level3', 'sem1', 'ET3112'),
(21, 'Computer Networks for Engineers 2021 Level 3 Semester 2', '2021', 'level3', 'sem2', 'ET3222'),
(22, 'Robotics and Automation 2015 Level 4 Semester 1', '2015', 'level4', 'sem1', 'ET4114'),
(23, 'Advanced Manufacturing Processes 2016 Level 4 Semester 2', '2016', 'level4', 'sem2', 'ET4242'),
(24, 'Introduction to Biological Systems 2017 Level 1 Semester 1', '2017', 'level1', 'sem1', 'BST1113'),
(25, 'Bioinformatics 2018 Level 1 Semester 2', '2018', 'level1', 'sem2', 'BST1222'),
(26, 'Biochemistry 2019 Level 2 Semester 1', '2019', 'level2', 'sem1', 'BST2113'),
(27, 'Plant Biotechnology 2020 Level 2 Semester 2', '2020', 'level2', 'sem2', 'BST2213'),
(28, 'Food Biotechnology 2021 Level 3 Semester 1', '2021', 'level3', 'sem1', 'BST3133'),
(29, 'Stem Cell Biology 2015 Level 3 Semester 2', '2015', 'level3', 'sem2', 'BST3222'),
(30, 'Pharmacology and Drug Development 2016 Level 4 Semester 1', '2016', 'level4', 'sem1', 'BST4113'),
(31, 'Biosecurity and Biosafety 2017 Level 4 Semester 2', '2017', 'level4', 'sem2', 'BST4222'),
(32, 'TEST Paper 1', '2022', 'level4', 'sem1', 'ICT4243');

-- --------------------------------------------------------

--
-- Table structure for table `repeat_student`
--

CREATE TABLE `repeat_student` (
  `RESULT_STUDENT_Reg_no` char(6) NOT NULL,
  `RESULT_Course_code` char(7) NOT NULL,
  `Repeat_count` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `repeat_student`
--

INSERT INTO `repeat_student` (`RESULT_STUDENT_Reg_no`, `RESULT_Course_code`, `Repeat_count`) VALUES
('TG0280', 'ET4114', 1),
('TG0340', 'ET4242', 1),
('TG0400', 'ICT3112', 1),
('TG0811', 'BST2113', 1);

-- --------------------------------------------------------

--
-- Table structure for table `result`
--

CREATE TABLE `result` (
  `STUDENT_Reg_no` char(6) NOT NULL,
  `Course_code` char(7) NOT NULL,
  `Marks` int(11) DEFAULT NULL,
  `GPV_Value` decimal(3,1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `result`
--

INSERT INTO `result` (`STUDENT_Reg_no`, `Course_code`, `Marks`, `GPV_Value`) VALUES
('TG0200', 'ICT4243', 85, 0.3),
('TG0203', 'ICT4123', 92, 3.7),
('TG0207', 'ICT4123', 78, 2.5),
('TG0240', 'ICT4243', 86, 1.1),
('TG0251', 'ICT4243', 93, 1.7),
('TG0267', 'BST4113', 76, 1.4),
('TG0280', 'ET4114', 88, 1.8),
('TG0291', 'ICT4123', 72, 0.7),
('TG0300', 'BST4113', 90, 1.8),
('TG0305', 'BST4113', 79, 3.2),
('TG0320', 'ICT4243', 87, 2.7),
('TG0340', 'ET4242', 78, 0.2),
('TG0355', 'ET4114', 95, 0.5),
('TG0400', 'ICT3112', 89, 1.7),
('TG0420', 'BST3222', 75, 3.2),
('TG0450', 'ICT3234', 87, 2.9),
('TG0478', 'ICT3112', 30, 1.3),
('TG0478', 'ICT3234', 25, 1.2),
('TG0502', 'BST3133', 79, 2.3),
('TG0503', 'ET3112', 40, 3.9),
('TG0601', 'ICT2112', 30, 1.1),
('TG0650', 'ICT2223', 87, 1.2),
('TG0678', 'ET2243', 93, 2.5),
('TG0701', 'ICT2223', 85, 1.2),
('TG0756', 'BST2113', 25, 2.1),
('TG0789', 'ET2243', 76, 3.1),
('TG0800', 'BST2213', 89, 1.6),
('TG0811', 'BST2113', 23, 2.4),
('TG0900', 'ET2122', 87, 3.2),
('TG0998', 'ET2122', 16, 1.3);

-- --------------------------------------------------------

--
-- Stand-in structure for view `result_details`
-- (See below for the actual view)
--
CREATE TABLE `result_details` (
`STUDENT_Reg_no` char(6)
,`First_name` varchar(25)
,`Course_code` char(7)
,`Marks` int(11)
,`grade` varchar(1)
,`repet_or_not` varchar(6)
,`repet_count` varchar(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `Staff_no` char(5) NOT NULL,
  `Name` varchar(25) DEFAULT NULL,
  `Position` varchar(20) DEFAULT NULL,
  `Gender` varchar(6) DEFAULT NULL,
  `Home_address` varchar(30) DEFAULT NULL,
  `Street_address` varchar(20) DEFAULT NULL,
  `Country` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`Staff_no`, `Name`, `Position`, `Gender`, `Home_address`, `Street_address`, `Country`) VALUES
('ADM01', 'Sahan Viduranaga', 'Administrator', 'MALE', 'No 57', 'Kalawana', 'Sri Lanka'),
('DEA01', 'Nimala Fernando', 'Dean', 'MALE', '123 Main Street', 'Cityville', 'Sri Lanka'),
('LEC01', 'Michael Johnson', 'Lecturer', 'MALE', '789 Oak Drive', 'Villagetown', 'United Kindom '),
('LEC02', 'Alice Williams', 'Lecturer', 'FEMALE', '987 Pine Lane', 'Countryside', 'United State'),
('LEC03', 'Dilani Silva', 'Lecturer', 'FEMALE', '101 Maple Drive', 'Valleyville', 'Sri Lanka'),
('LEC04', 'Samadhi Jayasinghe', 'Lecturer', 'FEMALE', '123 Oak Lane', 'Mountainside', 'Sri Lanka'),
('TEO01', 'Jane Smith', 'Technical Officer', 'FEMALE', '456 Elm Avenue', 'Townsville', 'Amarica'),
('TEO02', 'Kamal Perera', 'Technical Officer', 'MALE', '42 Lake Road', 'Harbor City', 'Sri Lanka'),
('TEO03', 'Ranjan Rajapakse', 'Technical Officer', 'MALE', '88 Red Avenue', 'Hometown', 'Sri Lanka');

-- --------------------------------------------------------

--
-- Stand-in structure for view `staffdepartment`
-- (See below for the actual view)
--
CREATE TABLE `staffdepartment` (
`staff_no` char(5)
,`Name` varchar(25)
,`Position` varchar(20)
,`Department_name` varchar(10)
);

-- --------------------------------------------------------

--
-- Table structure for table `staff_account`
--

CREATE TABLE `staff_account` (
  `Staff_account_type` varchar(30) DEFAULT NULL,
  `Staff_user_name` char(5) NOT NULL,
  `Staff_password` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff_account`
--

INSERT INTO `staff_account` (`Staff_account_type`, `Staff_user_name`, `Staff_password`) VALUES
('Administrator Account', 'ADM01', 'adminpass123'),
('Dean Account', 'DEA01', 'deanpass432'),
('Lecturer Account', 'LEC01', 'lecturerpass456'),
('Lecturer Account', 'LEC02', 'lecturer2pass987'),
('Lecturer Account', 'LEC05', 'lecturer5pass123'),
('Lecturer Account', 'LEC06', 'lecturer6pass456'),
('Lecturer Account', 'LEC07', 'lecturer7pass789'),
('Lecturer Account', 'LEC08', 'lecturer8pass321'),
('Lecturer Account', 'LEC09', 'lecturer9pass654'),
('Lecturer Account', 'LEC10', 'lecturer10pass987'),
('Teaching Assistant Account', 'TEO01', 'tauser789');

-- --------------------------------------------------------

--
-- Table structure for table `staff_department`
--

CREATE TABLE `staff_department` (
  `Staff_no` char(5) NOT NULL,
  `Department_name` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff_department`
--

INSERT INTO `staff_department` (`Staff_no`, `Department_name`) VALUES
('LEC02', 'ET'),
('TEO01', 'ET'),
('TEO02', 'BST');

-- --------------------------------------------------------

--
-- Table structure for table `staff_telephone`
--

CREATE TABLE `staff_telephone` (
  `Staff_no` char(5) NOT NULL,
  `Telephone` char(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff_telephone`
--

INSERT INTO `staff_telephone` (`Staff_no`, `Telephone`) VALUES
('LEC01', '01154321987'),
('ADM01', '07123456789'),
('DEA01', '07198765432'),
('ADM01', '07534567890'),
('TEO01', '08112345678');

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `Reg_no` char(6) NOT NULL,
  `First_name` varchar(25) NOT NULL,
  `Last_name` varchar(25) NOT NULL,
  `Email` varchar(30) NOT NULL,
  `Home_address` varchar(30) NOT NULL,
  `Street_address` varchar(50) NOT NULL,
  `Country` varchar(25) NOT NULL,
  `Entrance_year` year(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`Reg_no`, `First_name`, `Last_name`, `Email`, `Home_address`, `Street_address`, `Country`, `Entrance_year`) VALUES
('TG0200', 'Kasun', 'Kavihara', 'kaskavi45@gmail.com', 'No23', 'Anuradhapura - Samagi Mawatha', 'Sri Lanka', '2018'),
('TG0203', 'Samadhi', 'Tharuka', 'SamaTharu78@gmail.com', 'No512/34', 'Colombo - Issac Newton Road', 'Sri Lanka', '2018'),
('TG0207', 'Hirukshan', 'Krishnan', 'Krish99@gmail.com', 'No98', 'Jaffna - Mahendran Road', 'Sri Lanka', '2018'),
('TG0240', 'Shehan', 'Ranidu', 'SheRanid23@gmail.com', 'No1', 'Ratnapura - Mahagamasekara Road', 'Sri Lanka', '2018'),
('TG0251', 'Keshika', 'Ruwanthi', 'Ruwi1999@gmail.com', 'No8/67', 'Mathale - Pansala Road', 'Sri Lanka', '2018'),
('TG0267', 'Chrish', 'Edward', 'CrishED2001@gmail.com', 'No245/B', 'London - Charles Lane', 'Britain', '2018'),
('TG0280', 'Mohomad', 'Arkesh', 'Arch98@gmail.com', 'No65', 'Pannipitiya - Mosque Road', 'Sri Lanka', '2018'),
('TG0291', 'Piyumi', 'Kaveesha', 'kaviiPiyuu2000@gmail.com', 'No79', 'Mathara - Temple Road', 'Sri Lanka', '2018'),
('TG0300', 'Buddhika', 'Prasad', 'BuddhiSD88@gmail.com', 'No145', 'Piliyandala - Senanayaka Mawatha', 'Sri Lanka', '2018'),
('TG0305', 'Pathum', 'Kaveesha', 'PathuKavi99@gmail.com', 'No50', 'Galle - Hospital Road', 'Sri Lanka', '2018'),
('TG0320', 'Kasuni', 'Poornima', 'Kasuniporr11@gmail.com', 'No56/C', 'Kandy - Maligawa Para', 'Sri Lanka', '2018'),
('TG0340', 'Tamilchandran', 'Balakrishnam', 'Baall56@gmail.com', 'No34', 'Kilinochchi - Main Street', 'Sri Lanka', '2018'),
('TG0355', 'Leyla', 'Madison', 'LeyMad89@gmail.com', 'No576/C', 'Los Angles - Kent Road', 'USA', '2018'),
('TG0400', 'Shayne', 'Alhamdri', 'ShayAli90@gmail.com', 'No55', 'Maradana - Alwis road', 'Sri Lanka', '2019'),
('TG0420', 'Naveen', 'Rajapakse', 'navraja98@gmail.com', 'No67', 'Kandy - Hill Street', 'Sri Lanka', '2019'),
('TG0450', 'Lakshmi', 'Kumari', 'kumari99@gmail.com', 'No12', 'Kandy - Temple Street', 'Sri Lanka', '2019'),
('TG0478', 'Rajiv', 'Patel', 'rajiv91@email.com', 'No9', 'Jaffna - New Town road', 'Sri Lanka', '2019'),
('TG0502', 'Ahmed', 'Abdullah', 'aabdul12@email.com', 'No34', 'Hikkaduwa - Beach road', 'Sri Lanka', '2019'),
('TG0503', 'Chamara', 'Fonseka', 'chamara.fonseka@gmail.com', 'No567', 'Matara - Beach Road', 'Sri Lanka', '2019'),
('TG0601', 'Dilhara', 'Wijesinghe', 'dilhwijesinghe@gmail.com', 'No890', 'Trincomalee - Main Street', 'Sri Lanka', '2020'),
('TG0650', 'Saman', 'Perera', 'samanperera@gmail.com', 'No12', 'Anuradhapura - Main Road', 'Sri Lanka', '2020'),
('TG0678', 'Thilani', 'Weerasinghe', 'thilweerasinghe@gmail.com', 'No45', 'Jaffna - KKS Road', 'Sri Lanka', '2020'),
('TG0701', 'Nimanthi', 'Fernando', 'nimanthi.f@gmail.com', 'No876', 'Negombo - Main Street', 'Sri Lanka', '2020'),
('TG0756', 'Lasitha', 'Gunasekara', 'lasitha.gunasekara@gmail.com', 'No89', 'Kandy - Dalada Veediya', 'Sri Lanka', '2020'),
('TG0789', 'Ishan', 'Silva', 'ishan.silva@gmail.com', 'No67', 'Galle - Magalle Fort', 'Sri Lanka', '2020'),
('TG0800', 'Sithara', 'Rathnayake', 'sithara.rathnayake@gmail.com', 'No345', 'Trincomalee - Beach Road', 'Sri Lanka', '2020'),
('TG0811', 'Kamal', 'Perera', 'kamal.perera@gmail.com', 'No765', 'Anuradhapura - Sacred City', 'Sri Lanka', '2020'),
('TG0900', 'Dinithi', 'Weerasinghe', 'dinithi.weerasinghe@gmail.com', 'No101', 'Jaffna - Nallur Road', 'Sri Lanka', '2020'),
('TG0998', 'Prabath', 'Fernando', 'prabath.f@gmail.com', 'No111', 'Negombo - Poruthota Road', 'Sri Lanka', '2020'),
('TG1010', 'Nuwan', 'Gunasekara', 'nuwan.gunasekara@gmail.com', 'No77', 'Kandy - Saranankara Road', 'Sri Lanka', '2021'),
('TG1027', 'Krishna', 'Suren', 'balamKrsh@gmail.com', 'No98', 'Kandy - Ganedran Road', 'Sri Lanka', '2021'),
('TG1036', 'Upeksha', 'Ishini', 'Upekshaish@gmail.com', 'No12', 'Ratnapura - Main Road', 'Sri Lanka', '2021'),
('TG1067', 'Dumindu', 'Gawesha', 'Dumi99@gmail.com', 'No4', 'Biyagama - Wolcott Road', 'Sri Lanka', '2021'),
('TG1100', 'Hashan', 'Kavindu', 'HashKavi@gmail.com', 'No75', 'Polonnaruwa - Mahesh Road', 'Sri Lanka', '2021'),
('TG1145', 'Mohomad', 'Abeen', 'Abii88@gmail.com', 'No12', 'Kandy - Temple Road', 'Sri Lanka', '2021'),
('TG1198', 'Buddhika', 'Gayan', 'BuddhiGaya34@gmail.com', 'No56', 'Kegalle - Main Road', 'Sri Lanka', '2021');

-- --------------------------------------------------------

--
-- Stand-in structure for view `studentcourses`
-- (See below for the actual view)
--
CREATE TABLE `studentcourses` (
`Reg_no` char(6)
,`First_name` varchar(25)
,`Last_name` varchar(25)
,`course_code` char(7)
,`name` varchar(255)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `studentlabsheets`
-- (See below for the actual view)
--
CREATE TABLE `studentlabsheets` (
`Reg_no` char(6)
,`First_name` varchar(25)
,`Last_name` varchar(25)
,`labsheet_id` char(9)
,`title` varchar(255)
,`due_date` datetime
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `studentpastpapers`
-- (See below for the actual view)
--
CREATE TABLE `studentpastpapers` (
`Reg_no` char(6)
,`First_name` varchar(25)
,`Last_name` varchar(25)
,`past_paper_index` int(3)
,`paper_title` varchar(255)
,`year` year(4)
,`level` char(6)
,`semester` char(4)
);

-- --------------------------------------------------------

--
-- Table structure for table `student_account`
--

CREATE TABLE `student_account` (
  `STUDENT_USERNAME` char(6) NOT NULL,
  `STUDENT_Account_type` varchar(30) NOT NULL,
  `STUDENT_Password` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_account`
--

INSERT INTO `student_account` (`STUDENT_USERNAME`, `STUDENT_Account_type`, `STUDENT_Password`) VALUES
('TG0200', 'internal', 'password1'),
('TG0203', 'external', 'password2'),
('TG0207', 'internal', 'password3'),
('TG0240', 'external', 'password4'),
('TG0251', 'internal', 'password5'),
('TG0267', 'external', 'password6'),
('TG0280', 'internal', 'password7'),
('TG0291', 'external', 'password8'),
('TG0300', 'internal', 'password9'),
('TG0305', 'external', 'password10'),
('TG0320', 'internal', 'password11'),
('TG0340', 'external', 'password12'),
('TG0355', 'internal', 'password13'),
('TG0400', 'external', 'password14'),
('TG0420', 'internal', 'password15'),
('TG0450', 'external', 'password16'),
('TG0478', 'internal', 'password17'),
('TG0502', 'external', 'password18'),
('TG0503', 'internal', 'password19'),
('TG0601', 'external', 'password20'),
('TG0650', 'internal', 'password21'),
('TG0678', 'external', 'password22'),
('TG0701', 'internal', 'password23'),
('TG0756', 'external', 'password24'),
('TG0789', 'internal', 'password25'),
('TG0800', 'external', 'password26'),
('TG0811', 'internal', 'password27'),
('TG0900', 'external', 'password28'),
('TG0998', 'internal', 'password29'),
('TG1010', 'external', 'password30'),
('TG1027', 'internal', 'password31'),
('TG1036', 'external', 'password32'),
('TG1067', 'internal', 'password33'),
('TG1100', 'external', 'password34'),
('TG1145', 'internal', 'password35'),
('TG1198', 'external', 'password36');

-- --------------------------------------------------------

--
-- Table structure for table `student_course`
--

CREATE TABLE `student_course` (
  `STUDENT_Reg_no` char(6) NOT NULL,
  `COURSE_code` char(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_course`
--

INSERT INTO `student_course` (`STUDENT_Reg_no`, `COURSE_code`) VALUES
('TG0200', 'ICT4243'),
('TG0200', 'ICT4123'),
('TG0203', 'ICT4123'),
('TG0207', 'ICT4123'),
('TG0240', 'ICT4243'),
('TG0251', 'ICT4243'),
('TG0267', 'BST4113'),
('TG0280', 'ET4114'),
('TG0291', 'ICT4123'),
('TG0300', 'BST4113'),
('TG0305', 'BST4113'),
('TG0320', 'ICT4243'),
('TG0340', 'ET4242'),
('TG0355', 'ET4114'),
('TG0400', 'ICT3112'),
('TG0420', 'BST3222'),
('TG0450', 'ICT3234'),
('TG0478', 'ICT3234'),
('TG0478', 'ICT3112'),
('TG0502', 'BST3133'),
('TG0503', 'ET3112'),
('TG0601', 'ICT2112'),
('TG0650', 'ICT2223'),
('TG0678', 'ET2243'),
('TG0701', 'ICT2223'),
('TG0756', 'BST2113'),
('TG0789', 'ET2243'),
('TG0800', 'BST2213'),
('TG0811', 'BST2113'),
('TG0900', 'ET2122'),
('TG0998', 'ET2122'),
('TG0998', 'ET2243'),
('TG1010', 'BST1222'),
('TG1027', 'BST1113'),
('TG1036', 'ET1112'),
('TG1067', 'BST1222'),
('TG1100', 'ICT1242'),
('TG1145', 'ICT1242'),
('TG1198', 'BST1222');

-- --------------------------------------------------------

--
-- Table structure for table `student_department`
--

CREATE TABLE `student_department` (
  `STUDENT_Reg_no` char(6) NOT NULL,
  `DEPARTMENT_name` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_department`
--

INSERT INTO `student_department` (`STUDENT_Reg_no`, `DEPARTMENT_name`) VALUES
('TG0200', 'ICT'),
('TG0203', 'ICT'),
('TG0207', 'ICT'),
('TG0240', 'ICT'),
('TG0251', 'ICT'),
('TG0267', 'BST'),
('TG0280', 'ET'),
('TG0291', 'ICT'),
('TG0300', 'BST'),
('TG0305', 'BST'),
('TG0320', 'ICT'),
('TG0340', 'ET'),
('TG0355', 'ET'),
('TG0400', 'ICT'),
('TG0420', 'BST'),
('TG0450', 'ICT'),
('TG0478', 'ICT'),
('TG0502', 'BST'),
('TG0503', 'ET'),
('TG0601', 'ICT'),
('TG0650', 'ICT'),
('TG0678', 'ET'),
('TG0701', 'ICT'),
('TG0756', 'BST'),
('TG0789', 'ET'),
('TG0800', 'BST'),
('TG0811', 'BST'),
('TG0900', 'ET'),
('TG0998', 'ET'),
('TG1010', 'BST'),
('TG1027', 'BST'),
('TG1036', 'ET'),
('TG1067', 'BST'),
('TG1100', 'ICT'),
('TG1145', 'ICT'),
('TG1198', 'BST');

-- --------------------------------------------------------

--
-- Table structure for table `student_login`
--

CREATE TABLE `student_login` (
  `Reg_no` char(6) NOT NULL,
  `Last_login` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_login`
--

INSERT INTO `student_login` (`Reg_no`, `Last_login`) VALUES
('TG0200', '2023-10-25 15:30:00'),
('TG0203', '2023-10-25 22:20:00'),
('TG0207', '2023-10-26 08:45:00'),
('TG0240', '2023-10-26 14:15:00'),
('TG0251', '2023-10-27 09:30:00'),
('TG0267', '2023-10-28 12:10:00'),
('TG0280', '2023-10-29 17:25:00'),
('TG0291', '2023-10-30 11:55:00'),
('TG0300', '2023-10-31 16:40:00'),
('TG0305', '2023-11-01 18:20:00'),
('TG0320', '2023-11-02 10:15:00'),
('TG0340', '2023-11-03 23:05:00'),
('TG0355', '2023-11-04 07:30:00'),
('TG0400', '2023-11-05 19:45:00'),
('TG0420', '2023-11-06 14:55:00'),
('TG0450', '2023-11-07 16:20:00'),
('TG0478', '2023-11-08 21:35:00'),
('TG0502', '2023-11-09 10:40:00'),
('TG0503', '2023-11-10 13:50:00'),
('TG0601', '2023-11-11 08:15:00'),
('TG0650', '2023-11-12 17:05:00'),
('TG0678', '2023-11-13 09:25:00'),
('TG0701', '2023-11-14 22:40:00'),
('TG0756', '2023-11-15 12:30:00'),
('TG0789', '2023-11-16 19:50:00'),
('TG0800', '2023-11-17 15:10:00'),
('TG0811', '2023-11-18 18:45:00'),
('TG0900', '2023-11-19 20:20:00'),
('TG0998', '2023-11-20 11:05:00'),
('TG1010', '2023-11-21 15:30:00'),
('TG1027', '2023-11-21 14:30:00'),
('TG1036', '2023-11-21 16:30:00'),
('TG1067', '2023-11-21 18:30:00'),
('TG1100', '2023-11-21 17:30:00'),
('TG1145', '2023-11-21 14:30:00'),
('TG1198', '2023-11-21 13:30:00');

-- --------------------------------------------------------

--
-- Structure for view `assement_details`
--
DROP TABLE IF EXISTS `assement_details`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `assement_details`  AS SELECT `asse`.`Submisson_id` AS `Submisson_id`, `asse`.`Assement_type` AS `Assement_type`, `asse`.`Score` AS `Score`, `asse`.`Due_date` AS `Due_date`, `asse`.`Submission_date` AS `Submission_date`, `asse`.`Attendance_id_FK` AS `Attendance_id_FK`, `asse`.`Course_code` AS `Course_code`, `asse`.`STUDENT_Reg_no` AS `STUDENT_Reg_no`, CASE WHEN `a`.`Attendance_status` = 1 OR `a`.`Medical_status` = 1 THEN 'attend' ELSE 'not_attend' END AS `ATTENDECE_for_Assement` FROM (`assement` `asse` join `attendance` `a`) WHERE `asse`.`Attendance_id_FK` = `a`.`Attendance_id` ;

-- --------------------------------------------------------

--
-- Structure for view `attendence_detalis`
--
DROP TABLE IF EXISTS `attendence_detalis`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `attendence_detalis`  AS SELECT `a`.`STUDENT_Reg_no` AS `STUDENT_Reg_no`, `a`.`Course_code` AS `Course_code`, sum(case when `a`.`Attendance_status` = 1 or `a`.`Medical_status` = 1 then 1 else 0 end) AS `Attendance_Count`, sum(case when `a`.`Attendance_status` = 1 or `a`.`Medical_status` = 1 then 1 else 0 end) / 15 * 100 AS `Attendance_AS_A_presentage`, CASE WHEN sum(case when `a`.`Attendance_status` = 1 OR `a`.`Medical_status` = 1 then 1 else 0 end) / 15 * 100 >= 80 THEN 'eligible' ELSE 'not eligible' END AS `ATTENDANCE_Eligibility` FROM `attendance` AS `a` GROUP BY `a`.`STUDENT_Reg_no`, `a`.`Course_code` ;

-- --------------------------------------------------------

--
-- Structure for view `ca_eligibility`
--
DROP TABLE IF EXISTS `ca_eligibility`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `ca_eligibility`  AS SELECT `assement_details`.`STUDENT_Reg_no` AS `STUDENT_Reg_no`, `assement_details`.`Course_code` AS `Course_code`, count(`assement_details`.`Assement_type`) AS `Num_Assessments`, sum(case when `assement_details`.`Assement_type` = 'Quize' and `assement_details`.`ATTENDECE_for_Assement` = 'attend' then `assement_details`.`Score` / 4 when `assement_details`.`Assement_type` = 'MID_exam' and `assement_details`.`ATTENDECE_for_Assement` = 'attend' then `assement_details`.`Score` / 2 else 0 end) AS `Final_CA_MARKES`, CASE WHEN sum(case when `assement_details`.`Assement_type` = 'Quize' AND `assement_details`.`ATTENDECE_for_Assement` = 'attend' then `assement_details`.`Score` / 4 when `assement_details`.`Assement_type` = 'MID_exam' AND `assement_details`.`ATTENDECE_for_Assement` = 'attend' then `assement_details`.`Score` / 2 else 0 end) >= 50 THEN 'eligible' ELSE 'not eligible' END AS `CA_Eligibility` FROM `assement_details` WHERE `assement_details`.`Assement_type` = 'MID_exam' OR `assement_details`.`Assement_type` = 'Quize' GROUP BY `assement_details`.`STUDENT_Reg_no`, `assement_details`.`Course_code` ;

-- --------------------------------------------------------

--
-- Structure for view `coursedetailsview`
--
DROP TABLE IF EXISTS `coursedetailsview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `coursedetailsview`  AS SELECT `student_course`.`COURSE_code` AS `COURSE_code`, `student_course`.`STUDENT_Reg_no` AS `STUDENT_Reg_no`, `course`.`name` AS `name` FROM (`student_course` join `course` on(`student_course`.`COURSE_code` = `course`.`course_code`)) ;

-- --------------------------------------------------------

--
-- Structure for view `lectureaccount`
--
DROP TABLE IF EXISTS `lectureaccount`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `lectureaccount`  AS SELECT `staff_account`.`Staff_user_name` AS `Staff_user_name`, `staff`.`Name` AS `Name`, `staff_account`.`Staff_account_type` AS `Staff_account_type`, `staff_account`.`Staff_password` AS `Staff_password` FROM (`staff` join `staff_account`) WHERE `staff_account`.`Staff_user_name` = `staff`.`Staff_no` ;

-- --------------------------------------------------------

--
-- Structure for view `lecturecountact`
--
DROP TABLE IF EXISTS `lecturecountact`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `lecturecountact`  AS SELECT `staff_telephone`.`Staff_no` AS `staff_no`, `staff_telephone`.`Telephone` AS `telephone` FROM `staff_telephone` ;

-- --------------------------------------------------------

--
-- Structure for view `level`
--
DROP TABLE IF EXISTS `level`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `level`  AS SELECT `student`.`Entrance_year` AS `Entrance_year`, CASE WHEN `student`.`Entrance_year` = '2018' THEN 'Level 4' WHEN `student`.`Entrance_year` = '2019' THEN 'Level 3' WHEN `student`.`Entrance_year` = '2020' THEN 'Level 2' WHEN `student`.`Entrance_year` = '2021' THEN 'Level 1' ELSE 0 END AS `Level`, count(0) AS `StudentCount` FROM `student` GROUP BY `student`.`Entrance_year`, CASE WHEN `student`.`Entrance_year` = '2018' THEN 'Level 4' WHEN `student`.`Entrance_year` = '2019' THEN 'Level 3' WHEN `student`.`Entrance_year` = '2020' THEN 'Level 2' WHEN `student`.`Entrance_year` = '2021' THEN 'Level 1' ELSE 0 END ORDER BY CASE WHEN `student`.`Entrance_year` = '2018' THEN 'Level 4' WHEN `student`.`Entrance_year` = '2019' THEN 'Level 3' WHEN `student`.`Entrance_year` = '2020' THEN 'Level 2' WHEN `student`.`Entrance_year` = '2021' THEN 'Level 1' ELSE 0 END ASC ;

-- --------------------------------------------------------

--
-- Structure for view `result_details`
--
DROP TABLE IF EXISTS `result_details`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `result_details`  AS SELECT `r`.`STUDENT_Reg_no` AS `STUDENT_Reg_no`, `s`.`First_name` AS `First_name`, `c`.`course_code` AS `Course_code`, `r`.`Marks` AS `Marks`, CASE WHEN `r`.`Marks` >= 90 THEN 'A' WHEN `r`.`Marks` >= 80 THEN 'B' WHEN `r`.`Marks` >= 70 THEN 'C' WHEN `r`.`Marks` >= 60 THEN 'D' ELSE 'F' END AS `grade`, CASE WHEN `rs`.`RESULT_STUDENT_Reg_no` = `r`.`STUDENT_Reg_no` THEN 'repeat' ELSE 'PASS' END AS `repet_or_not`, CASE WHEN `rs`.`Repeat_count` is null THEN '0' ELSE `rs`.`Repeat_count` END AS `repet_count` FROM (((`student` `s` join `result` `r` on(`s`.`Reg_no` = `r`.`STUDENT_Reg_no`)) join `course` `c` on(`c`.`course_code` = `r`.`Course_code`)) left join `repeat_student` `rs` on(`rs`.`RESULT_STUDENT_Reg_no` = `r`.`STUDENT_Reg_no`)) ;

-- --------------------------------------------------------

--
-- Structure for view `staffdepartment`
--
DROP TABLE IF EXISTS `staffdepartment`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `staffdepartment`  AS SELECT `staff`.`Staff_no` AS `staff_no`, `staff`.`Name` AS `Name`, `staff`.`Position` AS `Position`, `staff_department`.`Department_name` AS `Department_name` FROM (`staff_department` left join `staff` on(`staff`.`Staff_no` = `staff_department`.`Staff_no`)) ;

-- --------------------------------------------------------

--
-- Structure for view `studentcourses`
--
DROP TABLE IF EXISTS `studentcourses`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `studentcourses`  AS SELECT `s`.`Reg_no` AS `Reg_no`, `s`.`First_name` AS `First_name`, `s`.`Last_name` AS `Last_name`, `c`.`course_code` AS `course_code`, `c`.`name` AS `name` FROM ((`student` `s` join `student_course` `sc` on(`s`.`Reg_no` = `sc`.`STUDENT_Reg_no`)) join `course` `c` on(`sc`.`COURSE_code` = `c`.`course_code`)) ;

-- --------------------------------------------------------

--
-- Structure for view `studentlabsheets`
--
DROP TABLE IF EXISTS `studentlabsheets`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `studentlabsheets`  AS SELECT `s`.`Reg_no` AS `Reg_no`, `s`.`First_name` AS `First_name`, `s`.`Last_name` AS `Last_name`, `ls`.`labsheet_id` AS `labsheet_id`, `ls`.`title` AS `title`, `ls`.`due_date` AS `due_date` FROM ((`student` `s` join `student_course` `sc` on(`s`.`Reg_no` = `sc`.`STUDENT_Reg_no`)) join `labsheet` `ls` on(`sc`.`COURSE_code` = `ls`.`course_code`)) ;

-- --------------------------------------------------------

--
-- Structure for view `studentpastpapers`
--
DROP TABLE IF EXISTS `studentpastpapers`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `studentpastpapers`  AS SELECT `s`.`Reg_no` AS `Reg_no`, `s`.`First_name` AS `First_name`, `s`.`Last_name` AS `Last_name`, `pp`.`past_paper_index` AS `past_paper_index`, `pp`.`paper_title` AS `paper_title`, `pp`.`year` AS `year`, `pp`.`level` AS `level`, `pp`.`semester` AS `semester` FROM ((`student` `s` join `student_course` `sc` on(`s`.`Reg_no` = `sc`.`STUDENT_Reg_no`)) join `past_papers` `pp` on(`sc`.`COURSE_code` = `pp`.`course_code`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assement`
--
ALTER TABLE `assement`
  ADD PRIMARY KEY (`Submisson_id`),
  ADD KEY `Course_code` (`Course_code`),
  ADD KEY `STUDENT_Reg_no` (`STUDENT_Reg_no`),
  ADD KEY `Attendance_id_FK` (`Attendance_id_FK`);

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`Attendance_id`),
  ADD KEY `STUDENT_Reg_no` (`STUDENT_Reg_no`),
  ADD KEY `Course_code` (`Course_code`);

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`course_code`),
  ADD KEY `department_name` (`department_name`);

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`Name`);

--
-- Indexes for table `labsheet`
--
ALTER TABLE `labsheet`
  ADD PRIMARY KEY (`labsheet_id`),
  ADD KEY `course_code` (`course_code`);

--
-- Indexes for table `past_papers`
--
ALTER TABLE `past_papers`
  ADD PRIMARY KEY (`past_paper_index`),
  ADD KEY `course_code` (`course_code`);

--
-- Indexes for table `repeat_student`
--
ALTER TABLE `repeat_student`
  ADD PRIMARY KEY (`RESULT_STUDENT_Reg_no`,`RESULT_Course_code`),
  ADD KEY `RESULT_Course_code` (`RESULT_Course_code`);

--
-- Indexes for table `result`
--
ALTER TABLE `result`
  ADD PRIMARY KEY (`STUDENT_Reg_no`,`Course_code`),
  ADD KEY `Course_code` (`Course_code`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`Staff_no`);

--
-- Indexes for table `staff_account`
--
ALTER TABLE `staff_account`
  ADD PRIMARY KEY (`Staff_user_name`);

--
-- Indexes for table `staff_department`
--
ALTER TABLE `staff_department`
  ADD PRIMARY KEY (`Staff_no`,`Department_name`);

--
-- Indexes for table `staff_telephone`
--
ALTER TABLE `staff_telephone`
  ADD PRIMARY KEY (`Telephone`,`Staff_no`),
  ADD KEY `Staff_no` (`Staff_no`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`Reg_no`);

--
-- Indexes for table `student_account`
--
ALTER TABLE `student_account`
  ADD PRIMARY KEY (`STUDENT_USERNAME`);

--
-- Indexes for table `student_course`
--
ALTER TABLE `student_course`
  ADD KEY `STUDENT_Reg_no` (`STUDENT_Reg_no`),
  ADD KEY `COURSE_code` (`COURSE_code`);

--
-- Indexes for table `student_department`
--
ALTER TABLE `student_department`
  ADD KEY `STUDENT_Reg_no` (`STUDENT_Reg_no`),
  ADD KEY `DEPARTMENT_name` (`DEPARTMENT_name`);

--
-- Indexes for table `student_login`
--
ALTER TABLE `student_login`
  ADD PRIMARY KEY (`Reg_no`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `past_papers`
--
ALTER TABLE `past_papers`
  MODIFY `past_paper_index` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `assement`
--
ALTER TABLE `assement`
  ADD CONSTRAINT `assement_ibfk_1` FOREIGN KEY (`Attendance_id_FK`) REFERENCES `attendance` (`Attendance_id`),
  ADD CONSTRAINT `assement_ibfk_2` FOREIGN KEY (`Course_code`) REFERENCES `course` (`course_code`),
  ADD CONSTRAINT `assement_ibfk_3` FOREIGN KEY (`STUDENT_Reg_no`) REFERENCES `student` (`Reg_no`),
  ADD CONSTRAINT `assement_ibfk_4` FOREIGN KEY (`Attendance_id_FK`) REFERENCES `attendance` (`Attendance_id`);

--
-- Constraints for table `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`STUDENT_Reg_no`) REFERENCES `student` (`Reg_no`),
  ADD CONSTRAINT `attendance_ibfk_2` FOREIGN KEY (`Course_code`) REFERENCES `course` (`course_code`);

--
-- Constraints for table `course`
--
ALTER TABLE `course`
  ADD CONSTRAINT `course_ibfk_1` FOREIGN KEY (`department_name`) REFERENCES `department` (`Name`);

--
-- Constraints for table `labsheet`
--
ALTER TABLE `labsheet`
  ADD CONSTRAINT `labsheet_ibfk_1` FOREIGN KEY (`course_code`) REFERENCES `course` (`course_code`);

--
-- Constraints for table `past_papers`
--
ALTER TABLE `past_papers`
  ADD CONSTRAINT `past_papers_ibfk_1` FOREIGN KEY (`course_code`) REFERENCES `course` (`course_code`);

--
-- Constraints for table `repeat_student`
--
ALTER TABLE `repeat_student`
  ADD CONSTRAINT `repeat_student_ibfk_1` FOREIGN KEY (`RESULT_STUDENT_Reg_no`) REFERENCES `result` (`STUDENT_Reg_no`),
  ADD CONSTRAINT `repeat_student_ibfk_2` FOREIGN KEY (`RESULT_Course_code`) REFERENCES `result` (`Course_code`);

--
-- Constraints for table `result`
--
ALTER TABLE `result`
  ADD CONSTRAINT `result_ibfk_1` FOREIGN KEY (`STUDENT_Reg_no`) REFERENCES `student` (`Reg_no`),
  ADD CONSTRAINT `result_ibfk_2` FOREIGN KEY (`Course_code`) REFERENCES `course` (`course_code`);

--
-- Constraints for table `staff_account`
--
ALTER TABLE `staff_account`
  ADD CONSTRAINT `staff_account_ibfk_1` FOREIGN KEY (`Staff_user_name`) REFERENCES `staff` (`Staff_no`);

--
-- Constraints for table `staff_department`
--
ALTER TABLE `staff_department`
  ADD CONSTRAINT `staff_department_ibfk_1` FOREIGN KEY (`Staff_no`) REFERENCES `staff` (`Staff_no`);

--
-- Constraints for table `staff_telephone`
--
ALTER TABLE `staff_telephone`
  ADD CONSTRAINT `staff_telephone_ibfk_1` FOREIGN KEY (`Staff_no`) REFERENCES `staff` (`Staff_no`);

--
-- Constraints for table `student_account`
--
ALTER TABLE `student_account`
  ADD CONSTRAINT `student_account_ibfk_1` FOREIGN KEY (`STUDENT_USERNAME`) REFERENCES `student` (`Reg_no`);

--
-- Constraints for table `student_course`
--
ALTER TABLE `student_course`
  ADD CONSTRAINT `student_course_ibfk_1` FOREIGN KEY (`STUDENT_Reg_no`) REFERENCES `student` (`Reg_no`),
  ADD CONSTRAINT `student_course_ibfk_2` FOREIGN KEY (`COURSE_code`) REFERENCES `course` (`course_code`);

--
-- Constraints for table `student_department`
--
ALTER TABLE `student_department`
  ADD CONSTRAINT `student_department_ibfk_1` FOREIGN KEY (`STUDENT_Reg_no`) REFERENCES `student` (`Reg_no`),
  ADD CONSTRAINT `student_department_ibfk_2` FOREIGN KEY (`DEPARTMENT_name`) REFERENCES `department` (`Name`);

--
-- Constraints for table `student_login`
--
ALTER TABLE `student_login`
  ADD CONSTRAINT `student_login_ibfk_1` FOREIGN KEY (`Reg_no`) REFERENCES `student` (`Reg_no`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
