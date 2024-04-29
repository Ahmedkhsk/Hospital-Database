-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Hospital
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Hospital` ;

-- -----------------------------------------------------
-- Schema Hospital
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Hospital` DEFAULT CHARACTER SET utf8 ;
SHOW WARNINGS;
USE `Hospital` ;

-- -----------------------------------------------------
-- Table `Hospital`.`Room`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hospital`.`Room` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Hospital`.`Room` (
  `RNum` INT NOT NULL,
  `Capacity` INT NULL,
  PRIMARY KEY (`RNum`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Hospital`.`Patient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hospital`.`Patient` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Hospital`.`Patient` (
  `PSSN` INT NOT NULL,
  `Name` VARCHAR(30) NULL,
  `Gender` VARCHAR(5) NULL,
  `phone` INT NULL,
  `Email` VARCHAR(35) NULL,
  `Room_Num` INT NOT NULL,
  PRIMARY KEY (`PSSN`),
  INDEX `fk_patient_room1_idx` (`Room_Num` ASC),
  CONSTRAINT `fk_patient_room1`
    FOREIGN KEY (`Room_Num`)
    REFERENCES `Hospital`.`Room` (`RNum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Hospital`.`Department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hospital`.`Department` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Hospital`.`Department` (
  `DNum` INT NOT NULL,
  `Mgr_SSN` INT NOT NULL,
  `Name` VARCHAR(40) NULL,
  PRIMARY KEY (`DNum`),
  INDEX `fk_Department_Doctor1_idx` (`Mgr_SSN` ASC),
  CONSTRAINT `fk_Department_Doctor1`
    FOREIGN KEY (`Mgr_SSN`)
    REFERENCES `Hospital`.`Doctor` (`DSSN`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Hospital`.`Doctor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hospital`.`Doctor` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Hospital`.`Doctor` (
  `DSSN` INT NOT NULL,
  `Specialization` INT NOT NULL,
  `Name` VARCHAR(30) NULL,
  `Email` VARCHAR(30) NULL,
  `Phone` INT NULL,
  `Salary` INT NULL,
  `Gender` VARCHAR(5) NULL,
  PRIMARY KEY (`DSSN`),
  INDEX `fk_doctor_department1_idx` (`Specialization` ASC),
  CONSTRAINT `fk_doctor_department1`
    FOREIGN KEY (`Specialization`)
    REFERENCES `Hospital`.`Department` (`DNum`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Hospital`.`Prescription`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hospital`.`Prescription` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Hospital`.`Prescription` (
  `PID` INT NOT NULL,
  `Date` DATE NULL,
  PRIMARY KEY (`PID`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Hospital`.`Nurse`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hospital`.`Nurse` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Hospital`.`Nurse` (
  `NID` INT NOT NULL,
  `Name` VARCHAR(30) NULL,
  `Shift_Time` VARCHAR(10) NULL,
  `Salary` INT NULL,
  PRIMARY KEY (`NID`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Hospital`.`Medical_Test`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hospital`.`Medical_Test` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Hospital`.`Medical_Test` (
  `MID` INT NOT NULL,
  `Name` VARCHAR(25) NULL,
  PRIMARY KEY (`MID`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Hospital`.`Emergency`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hospital`.`Emergency` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Hospital`.`Emergency` (
  `ENum` INT NOT NULL,
  PRIMARY KEY (`ENum`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Hospital`.`Treat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hospital`.`Treat` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Hospital`.`Treat` (
  `Doctor_SSN` INT NOT NULL,
  `Emergency_Num` INT NOT NULL,
  `Patient_SSN` INT NOT NULL,
  PRIMARY KEY (`Doctor_SSN`, `Emergency_Num`, `Patient_SSN`),
  INDEX `fk_treat_Doctor1_idx` (`Doctor_SSN` ASC),
  INDEX `fk_treat_Patient1_idx` (`Patient_SSN` ASC),
  CONSTRAINT `fk_treat_Emergency1`
    FOREIGN KEY (`Emergency_Num`)
    REFERENCES `Hospital`.`Emergency` (`ENum`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_treat_Doctor1`
    FOREIGN KEY (`Doctor_SSN`)
    REFERENCES `Hospital`.`Doctor` (`DSSN`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_treat_Patient1`
    FOREIGN KEY (`Patient_SSN`)
    REFERENCES `Hospital`.`Patient` (`PSSN`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Hospital`.`Describe_d`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hospital`.`Describe_d` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Hospital`.`Describe_d` (
  `Patient_SSN` INT NOT NULL,
  `Doctor_SSN` INT NOT NULL,
  `Prescription_ID` INT NOT NULL,
  `Medical_Test_ID` INT NOT NULL,
  `Test_Result` VARCHAR(10) NULL,
  PRIMARY KEY (`Patient_SSN`, `Doctor_SSN`, `Prescription_ID`, `Medical_Test_ID`),
  INDEX `fk_describe_Prescription1_idx` (`Prescription_ID` ASC),
  INDEX `fk_describe_medical_Test1_idx` (`Medical_Test_ID` ASC),
  INDEX `fk_describe_doctor1_idx` (`Doctor_SSN` ASC),
  INDEX `fk_describe_patient1_idx` (`Patient_SSN` ASC),
  CONSTRAINT `fk_describe_Prescription1`
    FOREIGN KEY (`Prescription_ID`)
    REFERENCES `Hospital`.`Prescription` (`PID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_describe_medical_Test1`
    FOREIGN KEY (`Medical_Test_ID`)
    REFERENCES `Hospital`.`Medical_Test` (`MID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_describe_doctor1`
    FOREIGN KEY (`Doctor_SSN`)
    REFERENCES `Hospital`.`Doctor` (`DSSN`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_describe_patient1`
    FOREIGN KEY (`Patient_SSN`)
    REFERENCES `Hospital`.`Patient` (`PSSN`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Hospital`.`Nurse_has_Room`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hospital`.`Nurse_has_Room` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Hospital`.`Nurse_has_Room` (
  `Nurse_ID` INT NOT NULL,
  `Room_num` INT NOT NULL,
  PRIMARY KEY (`Nurse_ID`, `Room_num`),
  INDEX `fk_Nurse_has_Room_Room1_idx` (`Room_num` ASC),
  INDEX `fk_Nurse_has_Room_Nurse1_idx` (`Nurse_ID` ASC),
  CONSTRAINT `fk_Nurse_has_Room_Nurse1`
    FOREIGN KEY (`Nurse_ID`)
    REFERENCES `Hospital`.`Nurse` (`NID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Nurse_has_Room_Room1`
    FOREIGN KEY (`Room_num`)
    REFERENCES `Hospital`.`Room` (`RNum`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Hospital`.`Payment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hospital`.`Payment` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Hospital`.`Payment` (
  `Payment_ID` INT NOT NULL,
  `Price` INT NULL,
  `Patient_SSN` INT NOT NULL,
  PRIMARY KEY (`Payment_ID`),
  INDEX `fk_Payment_Patient1_idx` (`Patient_SSN` ASC),
  CONSTRAINT `fk_Payment_Patient1`
    FOREIGN KEY (`Patient_SSN`)
    REFERENCES `Hospital`.`Patient` (`PSSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Hospital`.`Medicne`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hospital`.`Medicne` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Hospital`.`Medicne` (
  `Code` INT NOT NULL,
  `Name` VARCHAR(15) NULL,
  PRIMARY KEY (`Code`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Hospital`.`has`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hospital`.`has` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Hospital`.`has` (
  `Medicne_Code` INT NOT NULL,
  `Prescription_ID` INT NOT NULL,
  `Dosage` INT NULL,
  PRIMARY KEY (`Medicne_Code`, `Prescription_ID`),
  INDEX `fk_medicne_has_prescription_prescription1_idx` (`Prescription_ID` ASC),
  INDEX `fk_medicne_has_prescription_medicne1_idx` (`Medicne_Code` ASC),
  CONSTRAINT `fk_medicne_has_prescription_medicne1`
    FOREIGN KEY (`Medicne_Code`)
    REFERENCES `Hospital`.`Medicne` (`Code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_medicne_has_prescription_prescription1`
    FOREIGN KEY (`Prescription_ID`)
    REFERENCES `Hospital`.`Prescription` (`PID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Data for table `Hospital`.`Room`
-- -----------------------------------------------------
START TRANSACTION;
USE `Hospital`;
INSERT INTO `Hospital`.`Room` (`RNum`, `Capacity`) VALUES (100, 3);
INSERT INTO `Hospital`.`Room` (`RNum`, `Capacity`) VALUES (101, 4);
INSERT INTO `Hospital`.`Room` (`RNum`, `Capacity`) VALUES (102, 2);
INSERT INTO `Hospital`.`Room` (`RNum`, `Capacity`) VALUES (103, 1);
INSERT INTO `Hospital`.`Room` (`RNum`, `Capacity`) VALUES (104, 1);
INSERT INTO `Hospital`.`Room` (`RNum`, `Capacity`) VALUES (105, 1);
INSERT INTO `Hospital`.`Room` (`RNum`, `Capacity`) VALUES (106, 4);
INSERT INTO `Hospital`.`Room` (`RNum`, `Capacity`) VALUES (107, 3);
INSERT INTO `Hospital`.`Room` (`RNum`, `Capacity`) VALUES (108, 2);
INSERT INTO `Hospital`.`Room` (`RNum`, `Capacity`) VALUES (109, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Hospital`.`Patient`
-- -----------------------------------------------------
START TRANSACTION;
USE `Hospital`;
INSERT INTO `Hospital`.`Patient` (`PSSN`, `Name`, `Gender`, `phone`, `Email`, `Room_Num`) VALUES (32345678, 'mohamed khalaf', 'm', 011234544, 'uiio@gmail.com', 100);
INSERT INTO `Hospital`.`Patient` (`PSSN`, `Name`, `Gender`, `phone`, `Email`, `Room_Num`) VALUES (22343345, 'toqa hussien', 'f', 011178766, 'to@gmail.com', 100);
INSERT INTO `Hospital`.`Patient` (`PSSN`, `Name`, `Gender`, `phone`, `Email`, `Room_Num`) VALUES (43644555, 'sara ali', 'f', 011223244, 'mof@gmail.com', 100);
INSERT INTO `Hospital`.`Patient` (`PSSN`, `Name`, `Gender`, `phone`, `Email`, `Room_Num`) VALUES (23334344, 'fathi abdo', 'm', 010023323, 'ioo@gmail.com', 101);
INSERT INTO `Hospital`.`Patient` (`PSSN`, `Name`, `Gender`, `phone`, `Email`, `Room_Num`) VALUES (23332344, 'nader yonan', 'm', 011123234, 'opko@gmail.com', 102);
INSERT INTO `Hospital`.`Patient` (`PSSN`, `Name`, `Gender`, `phone`, `Email`, `Room_Num`) VALUES (65445444, 'basmala tareak', 'f', 011453323, 'ttyo@gmail.com', 103);
INSERT INTO `Hospital`.`Patient` (`PSSN`, `Name`, `Gender`, `phone`, `Email`, `Room_Num`) VALUES (84393234, 'fadoa yasser', 'f', 012233244, 'iio@gmail.com', 106);
INSERT INTO `Hospital`.`Patient` (`PSSN`, `Name`, `Gender`, `phone`, `Email`, `Room_Num`) VALUES (09348944, 'sonds said', 'f', 012223234, 'sonds2@gmail.com', 107);
INSERT INTO `Hospital`.`Patient` (`PSSN`, `Name`, `Gender`, `phone`, `Email`, `Room_Num`) VALUES (89954974, 'yasser khadry', 'm', 012122345, 'yasser_k@gmail.com', 108);
INSERT INTO `Hospital`.`Patient` (`PSSN`, `Name`, `Gender`, `phone`, `Email`, `Room_Num`) VALUES (77482893, 'sam morsy', 'm', 011234546, 'sam_m@gmail.com', 107);
INSERT INTO `Hospital`.`Patient` (`PSSN`, `Name`, `Gender`, `phone`, `Email`, `Room_Num`) VALUES (75849302, 'mohamed salah', 'm', 011223345, 'm_salah@gmail.com', 109);
INSERT INTO `Hospital`.`Patient` (`PSSN`, `Name`, `Gender`, `phone`, `Email`, `Room_Num`) VALUES (46342345, 'walaa abdo', 'f', 011233556, 'w_abdo@gmail.com', 107);
INSERT INTO `Hospital`.`Patient` (`PSSN`, `Name`, `Gender`, `phone`, `Email`, `Room_Num`) VALUES (94885873, 'sahar adel', 'f', 012334345, 'saha_45@gmail.com', 109);
INSERT INTO `Hospital`.`Patient` (`PSSN`, `Name`, `Gender`, `phone`, `Email`, `Room_Num`) VALUES (89438934, 'laila mohamed', 'f', 012234455, 'laila223@gmail.com', 108);
INSERT INTO `Hospital`.`Patient` (`PSSN`, `Name`, `Gender`, `phone`, `Email`, `Room_Num`) VALUES (00450958, 'nermen foaud', 'f', 011232334, 'ne_foaud@gmail.com', 101);
INSERT INTO `Hospital`.`Patient` (`PSSN`, `Name`, `Gender`, `phone`, `Email`, `Room_Num`) VALUES (23343455, 'ahmed gamal', 'm', 012112334, 'tpo@gmail.com', 101);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Hospital`.`Department`
-- -----------------------------------------------------
START TRANSACTION;
USE `Hospital`;
INSERT INTO `Hospital`.`Department` (`DNum`, `Mgr_SSN`, `Name`) VALUES (1, 304012345, 'internal medicine');
INSERT INTO `Hospital`.`Department` (`DNum`, `Mgr_SSN`, `Name`) VALUES (2, 203023894, 'surgery');
INSERT INTO `Hospital`.`Department` (`DNum`, `Mgr_SSN`, `Name`) VALUES (3, 302012356, 'pediatric');
INSERT INTO `Hospital`.`Department` (`DNum`, `Mgr_SSN`, `Name`) VALUES (4, 305512345, 'obstetrics & gynaecology');
INSERT INTO `Hospital`.`Department` (`DNum`, `Mgr_SSN`, `Name`) VALUES (5, 302212345, 'ophthalmologist');
INSERT INTO `Hospital`.`Department` (`DNum`, `Mgr_SSN`, `Name`) VALUES (6, 401123678, 'ear ,nose and throat');
INSERT INTO `Hospital`.`Department` (`DNum`, `Mgr_SSN`, `Name`) VALUES (7, 379247945, 'dermatology');
INSERT INTO `Hospital`.`Department` (`DNum`, `Mgr_SSN`, `Name`) VALUES (8, 323443553, 'radiology');
INSERT INTO `Hospital`.`Department` (`DNum`, `Mgr_SSN`, `Name`) VALUES (9, 585748334, 'psychiatry');
INSERT INTO `Hospital`.`Department` (`DNum`, `Mgr_SSN`, `Name`) VALUES (10, 234789765, 'dentistry');
INSERT INTO `Hospital`.`Department` (`DNum`, `Mgr_SSN`, `Name`) VALUES (11, 556777655, 'cardiology');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Hospital`.`Doctor`
-- -----------------------------------------------------
START TRANSACTION;
USE `Hospital`;
INSERT INTO `Hospital`.`Doctor` (`DSSN`, `Specialization`, `Name`, `Email`, `Phone`, `Salary`, `Gender`) VALUES (304012345, 1, 'aya hussein ', 'aya123@gamil.com', 01145312652, 25000, 'f');
INSERT INTO `Hospital`.`Doctor` (`DSSN`, `Specialization`, `Name`, `Email`, `Phone`, `Salary`, `Gender`) VALUES (203023894, 2, 'radwa reda', 'radwa23@gamil.com', 01002281468, 30000, 'f');
INSERT INTO `Hospital`.`Doctor` (`DSSN`, `Specialization`, `Name`, `Email`, `Phone`, `Salary`, `Gender`) VALUES (302012356, 3, 'ahmed khaled', 'ahmed222@gamil.com', 01128618718, 50000, 'm');
INSERT INTO `Hospital`.`Doctor` (`DSSN`, `Specialization`, `Name`, `Email`, `Phone`, `Salary`, `Gender`) VALUES (305512345, 4, 'mohamed fawzy', 'null', 01209706233, 25000, 'm');
INSERT INTO `Hospital`.`Doctor` (`DSSN`, `Specialization`, `Name`, `Email`, `Phone`, `Salary`, `Gender`) VALUES (302212345, 5, 'hussein khaled', 'hussein2234@gamil.com', 01543532542, 30000, 'm');
INSERT INTO `Hospital`.`Doctor` (`DSSN`, `Specialization`, `Name`, `Email`, `Phone`, `Salary`, `Gender`) VALUES (401123678, 6, 'manar ahmed', 'manar4563@gamil.com', 01117525722, 35000, 'f');
INSERT INTO `Hospital`.`Doctor` (`DSSN`, `Specialization`, `Name`, `Email`, `Phone`, `Salary`, `Gender`) VALUES (379247945, 7, 'basmala ahmed', 'manwq@gamil.com', 01007656434, 20000, 'f');
INSERT INTO `Hospital`.`Doctor` (`DSSN`, `Specialization`, `Name`, `Email`, `Phone`, `Salary`, `Gender`) VALUES (323443553, 8, 'walaa adel', 'null', 01222323445, 40000, 'f');
INSERT INTO `Hospital`.`Doctor` (`DSSN`, `Specialization`, `Name`, `Email`, `Phone`, `Salary`, `Gender`) VALUES (585748334, 9, 'sama khaled', 'sama@gamil.com', 01256789890, 45000, 'f');
INSERT INTO `Hospital`.`Doctor` (`DSSN`, `Specialization`, `Name`, `Email`, `Phone`, `Salary`, `Gender`) VALUES (234789765, 10, 'omar shawky', 'omar@gamil.com', 01167589797, 30000, 'm');
INSERT INTO `Hospital`.`Doctor` (`DSSN`, `Specialization`, `Name`, `Email`, `Phone`, `Salary`, `Gender`) VALUES (556777655, 11, 'aseel shrif ', 'null', 01007674456, 26000, 'f');
INSERT INTO `Hospital`.`Doctor` (`DSSN`, `Specialization`, `Name`, `Email`, `Phone`, `Salary`, `Gender`) VALUES (454565656, 5, 'tia ahmed', 'ti@gamil.com', 01276786798, 10000, 'f');
INSERT INTO `Hospital`.`Doctor` (`DSSN`, `Specialization`, `Name`, `Email`, `Phone`, `Salary`, `Gender`) VALUES (805565667, 6, 'tarek hashim', 'tar@gamil.com', 01576423768, 21000, 'm');
INSERT INTO `Hospital`.`Doctor` (`DSSN`, `Specialization`, `Name`, `Email`, `Phone`, `Salary`, `Gender`) VALUES (546674544, 8, 'esraa tarek', 'esra@gamil.com', 01286743427, 40000, 'f');
INSERT INTO `Hospital`.`Doctor` (`DSSN`, `Specialization`, `Name`, `Email`, `Phone`, `Salary`, `Gender`) VALUES (434312223, 9, 'alaa tarek', 'manar4563@gamil.com', 01006757452, 50500, 'f');
INSERT INTO `Hospital`.`Doctor` (`DSSN`, `Specialization`, `Name`, `Email`, `Phone`, `Salary`, `Gender`) VALUES (322334345, 10, 'shawky khaled', 'shawky_khaled@yahoo.com', 01176977433, 12000, 'm');
INSERT INTO `Hospital`.`Doctor` (`DSSN`, `Specialization`, `Name`, `Email`, `Phone`, `Salary`, `Gender`) VALUES (765767887, 2, 'hassan khaled', 'hassan33@yahoo.com', 01145785434, 35000, 'm');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Hospital`.`Prescription`
-- -----------------------------------------------------
START TRANSACTION;
USE `Hospital`;
INSERT INTO `Hospital`.`Prescription` (`PID`, `Date`) VALUES (1, '2023-10-11');
INSERT INTO `Hospital`.`Prescription` (`PID`, `Date`) VALUES (2, '2021-05-03');
INSERT INTO `Hospital`.`Prescription` (`PID`, `Date`) VALUES (3, '2020-04-06');
INSERT INTO `Hospital`.`Prescription` (`PID`, `Date`) VALUES (4, '2021-03-02');
INSERT INTO `Hospital`.`Prescription` (`PID`, `Date`) VALUES (5, '2023-03-09');
INSERT INTO `Hospital`.`Prescription` (`PID`, `Date`) VALUES (6, '2023-01-01');
INSERT INTO `Hospital`.`Prescription` (`PID`, `Date`) VALUES (7, '2022-03-06');
INSERT INTO `Hospital`.`Prescription` (`PID`, `Date`) VALUES (8, '2023-04-05');
INSERT INTO `Hospital`.`Prescription` (`PID`, `Date`) VALUES (9, '2022-12-24');
INSERT INTO `Hospital`.`Prescription` (`PID`, `Date`) VALUES (10, '2023-11-21');
INSERT INTO `Hospital`.`Prescription` (`PID`, `Date`) VALUES (11, '2021-11-20');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Hospital`.`Nurse`
-- -----------------------------------------------------
START TRANSACTION;
USE `Hospital`;
INSERT INTO `Hospital`.`Nurse` (`NID`, `Name`, `Shift_Time`, `Salary`) VALUES (1, 'heba mohamed', 'night', 5000);
INSERT INTO `Hospital`.`Nurse` (`NID`, `Name`, `Shift_Time`, `Salary`) VALUES (2, 'ahmed morsy', 'night', 4500);
INSERT INTO `Hospital`.`Nurse` (`NID`, `Name`, `Shift_Time`, `Salary`) VALUES (3, 'rehab kamal', 'morning', 5300);
INSERT INTO `Hospital`.`Nurse` (`NID`, `Name`, `Shift_Time`, `Salary`) VALUES (4, 'basant aref', 'night', 6050);
INSERT INTO `Hospital`.`Nurse` (`NID`, `Name`, `Shift_Time`, `Salary`) VALUES (5, 'khaled wanees', 'morning', 7150);
INSERT INTO `Hospital`.`Nurse` (`NID`, `Name`, `Shift_Time`, `Salary`) VALUES (6, 'malak grges', 'morning', 8200);
INSERT INTO `Hospital`.`Nurse` (`NID`, `Name`, `Shift_Time`, `Salary`) VALUES (7, 'ebrahiem ahmed', 'night', 6500);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Hospital`.`Medical_Test`
-- -----------------------------------------------------
START TRANSACTION;
USE `Hospital`;
INSERT INTO `Hospital`.`Medical_Test` (`MID`, `Name`) VALUES (11, 'cbc');
INSERT INTO `Hospital`.`Medical_Test` (`MID`, `Name`) VALUES (12, 'libid profile');
INSERT INTO `Hospital`.`Medical_Test` (`MID`, `Name`) VALUES (13, 'leidny funcon');
INSERT INTO `Hospital`.`Medical_Test` (`MID`, `Name`) VALUES (14, 'lver function');
INSERT INTO `Hospital`.`Medical_Test` (`MID`, `Name`) VALUES (15, 'npv');
INSERT INTO `Hospital`.`Medical_Test` (`MID`, `Name`) VALUES (16, 'hcv');
INSERT INTO `Hospital`.`Medical_Test` (`MID`, `Name`) VALUES (17, 'rh');
INSERT INTO `Hospital`.`Medical_Test` (`MID`, `Name`) VALUES (18, 'asot');
INSERT INTO `Hospital`.`Medical_Test` (`MID`, `Name`) VALUES (19, 'crp');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Hospital`.`Emergency`
-- -----------------------------------------------------
START TRANSACTION;
USE `Hospital`;
INSERT INTO `Hospital`.`Emergency` (`ENum`) VALUES (1);
INSERT INTO `Hospital`.`Emergency` (`ENum`) VALUES (2);
INSERT INTO `Hospital`.`Emergency` (`ENum`) VALUES (3);
INSERT INTO `Hospital`.`Emergency` (`ENum`) VALUES (4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Hospital`.`Treat`
-- -----------------------------------------------------
START TRANSACTION;
USE `Hospital`;
INSERT INTO `Hospital`.`Treat` (`Doctor_SSN`, `Emergency_Num`, `Patient_SSN`) VALUES (304012345, 1, 32345678);
INSERT INTO `Hospital`.`Treat` (`Doctor_SSN`, `Emergency_Num`, `Patient_SSN`) VALUES (203023894, 1, 22343345);
INSERT INTO `Hospital`.`Treat` (`Doctor_SSN`, `Emergency_Num`, `Patient_SSN`) VALUES (302012356, 2, 09348944);
INSERT INTO `Hospital`.`Treat` (`Doctor_SSN`, `Emergency_Num`, `Patient_SSN`) VALUES (401123678, 3, 89954974);
INSERT INTO `Hospital`.`Treat` (`Doctor_SSN`, `Emergency_Num`, `Patient_SSN`) VALUES (379247945, 3, 77482893);
INSERT INTO `Hospital`.`Treat` (`Doctor_SSN`, `Emergency_Num`, `Patient_SSN`) VALUES (585748334, 4, 75849302);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Hospital`.`Describe_d`
-- -----------------------------------------------------
START TRANSACTION;
USE `Hospital`;
INSERT INTO `Hospital`.`Describe_d` (`Patient_SSN`, `Doctor_SSN`, `Prescription_ID`, `Medical_Test_ID`, `Test_Result`) VALUES (84393234, 302212345, 1, 15, 'upnormal');
INSERT INTO `Hospital`.`Describe_d` (`Patient_SSN`, `Doctor_SSN`, `Prescription_ID`, `Medical_Test_ID`, `Test_Result`) VALUES (09348944, 305512345, 2, 16, 'normal');
INSERT INTO `Hospital`.`Describe_d` (`Patient_SSN`, `Doctor_SSN`, `Prescription_ID`, `Medical_Test_ID`, `Test_Result`) VALUES (46342345, 805565667, 3, 15, 'normal');
INSERT INTO `Hospital`.`Describe_d` (`Patient_SSN`, `Doctor_SSN`, `Prescription_ID`, `Medical_Test_ID`, `Test_Result`) VALUES (94885873, 546674544, 5, 11, 'normal');
INSERT INTO `Hospital`.`Describe_d` (`Patient_SSN`, `Doctor_SSN`, `Prescription_ID`, `Medical_Test_ID`, `Test_Result`) VALUES (89438934, 434312223, 4, 12, 'normal');
INSERT INTO `Hospital`.`Describe_d` (`Patient_SSN`, `Doctor_SSN`, `Prescription_ID`, `Medical_Test_ID`, `Test_Result`) VALUES (00450958, 322334345, 7, 13, 'upnormal');
INSERT INTO `Hospital`.`Describe_d` (`Patient_SSN`, `Doctor_SSN`, `Prescription_ID`, `Medical_Test_ID`, `Test_Result`) VALUES (23343455, 765767887, 6, 14, 'upnormal');
INSERT INTO `Hospital`.`Describe_d` (`Patient_SSN`, `Doctor_SSN`, `Prescription_ID`, `Medical_Test_ID`, `Test_Result`) VALUES (43644555, 323443553, 8, 17, 'normal');
INSERT INTO `Hospital`.`Describe_d` (`Patient_SSN`, `Doctor_SSN`, `Prescription_ID`, `Medical_Test_ID`, `Test_Result`) VALUES (23334344, 556777655, 9, 18, 'upnormal');
INSERT INTO `Hospital`.`Describe_d` (`Patient_SSN`, `Doctor_SSN`, `Prescription_ID`, `Medical_Test_ID`, `Test_Result`) VALUES (23332344, 805565667, 10, 19, 'normal');
INSERT INTO `Hospital`.`Describe_d` (`Patient_SSN`, `Doctor_SSN`, `Prescription_ID`, `Medical_Test_ID`, `Test_Result`) VALUES (65445444, 454565656, 11, 12, 'upnormal');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Hospital`.`Nurse_has_Room`
-- -----------------------------------------------------
START TRANSACTION;
USE `Hospital`;
INSERT INTO `Hospital`.`Nurse_has_Room` (`Nurse_ID`, `Room_num`) VALUES (1, 100);
INSERT INTO `Hospital`.`Nurse_has_Room` (`Nurse_ID`, `Room_num`) VALUES (2, 101);
INSERT INTO `Hospital`.`Nurse_has_Room` (`Nurse_ID`, `Room_num`) VALUES (3, 102);
INSERT INTO `Hospital`.`Nurse_has_Room` (`Nurse_ID`, `Room_num`) VALUES (4, 103);
INSERT INTO `Hospital`.`Nurse_has_Room` (`Nurse_ID`, `Room_num`) VALUES (5, 104);
INSERT INTO `Hospital`.`Nurse_has_Room` (`Nurse_ID`, `Room_num`) VALUES (6, 105);
INSERT INTO `Hospital`.`Nurse_has_Room` (`Nurse_ID`, `Room_num`) VALUES (7, 106);
INSERT INTO `Hospital`.`Nurse_has_Room` (`Nurse_ID`, `Room_num`) VALUES (2, 107);
INSERT INTO `Hospital`.`Nurse_has_Room` (`Nurse_ID`, `Room_num`) VALUES (3, 108);
INSERT INTO `Hospital`.`Nurse_has_Room` (`Nurse_ID`, `Room_num`) VALUES (5, 109);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Hospital`.`Payment`
-- -----------------------------------------------------
START TRANSACTION;
USE `Hospital`;
INSERT INTO `Hospital`.`Payment` (`Payment_ID`, `Price`, `Patient_SSN`) VALUES (10, 500, 32345678);
INSERT INTO `Hospital`.`Payment` (`Payment_ID`, `Price`, `Patient_SSN`) VALUES (20, 300, 22343345);
INSERT INTO `Hospital`.`Payment` (`Payment_ID`, `Price`, `Patient_SSN`) VALUES (30, 400, 43644555);
INSERT INTO `Hospital`.`Payment` (`Payment_ID`, `Price`, `Patient_SSN`) VALUES (40, 500, 23334344);
INSERT INTO `Hospital`.`Payment` (`Payment_ID`, `Price`, `Patient_SSN`) VALUES (50, 600, 23332344);
INSERT INTO `Hospital`.`Payment` (`Payment_ID`, `Price`, `Patient_SSN`) VALUES (60, 700, 65445444);
INSERT INTO `Hospital`.`Payment` (`Payment_ID`, `Price`, `Patient_SSN`) VALUES (70, 900, 84393234);
INSERT INTO `Hospital`.`Payment` (`Payment_ID`, `Price`, `Patient_SSN`) VALUES (80, 100, 09348944);
INSERT INTO `Hospital`.`Payment` (`Payment_ID`, `Price`, `Patient_SSN`) VALUES (90, 1000, 89954974);
INSERT INTO `Hospital`.`Payment` (`Payment_ID`, `Price`, `Patient_SSN`) VALUES (100, 200, 77482893);
INSERT INTO `Hospital`.`Payment` (`Payment_ID`, `Price`, `Patient_SSN`) VALUES (110, 250, 75849302);
INSERT INTO `Hospital`.`Payment` (`Payment_ID`, `Price`, `Patient_SSN`) VALUES (120, 300, 46342345);
INSERT INTO `Hospital`.`Payment` (`Payment_ID`, `Price`, `Patient_SSN`) VALUES (130, 400, 94885873);
INSERT INTO `Hospital`.`Payment` (`Payment_ID`, `Price`, `Patient_SSN`) VALUES (140, 1200, 89438934);
INSERT INTO `Hospital`.`Payment` (`Payment_ID`, `Price`, `Patient_SSN`) VALUES (150, 650, 00450958);
INSERT INTO `Hospital`.`Payment` (`Payment_ID`, `Price`, `Patient_SSN`) VALUES (160, 800, 23343455);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Hospital`.`Medicne`
-- -----------------------------------------------------
START TRANSACTION;
USE `Hospital`;
INSERT INTO `Hospital`.`Medicne` (`Code`, `Name`) VALUES (2341, 'antinal');
INSERT INTO `Hospital`.`Medicne` (`Code`, `Name`) VALUES (7654, 'flagel');
INSERT INTO `Hospital`.`Medicne` (`Code`, `Name`) VALUES (0987, 'asposeed');
INSERT INTO `Hospital`.`Medicne` (`Code`, `Name`) VALUES (3578, 'congestal');
INSERT INTO `Hospital`.`Medicne` (`Code`, `Name`) VALUES (9753, 'panadol');
INSERT INTO `Hospital`.`Medicne` (`Code`, `Name`) VALUES (0099, 'paramol');
INSERT INTO `Hospital`.`Medicne` (`Code`, `Name`) VALUES (8090, 'one two three');
INSERT INTO `Hospital`.`Medicne` (`Code`, `Name`) VALUES (4455, 'renal s');
INSERT INTO `Hospital`.`Medicne` (`Code`, `Name`) VALUES (6331, 'targ');
INSERT INTO `Hospital`.`Medicne` (`Code`, `Name`) VALUES (7676, 'adol');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Hospital`.`has`
-- -----------------------------------------------------
START TRANSACTION;
USE `Hospital`;
INSERT INTO `Hospital`.`has` (`Medicne_Code`, `Prescription_ID`, `Dosage`) VALUES (2341, 1, 2);
INSERT INTO `Hospital`.`has` (`Medicne_Code`, `Prescription_ID`, `Dosage`) VALUES (7654, 2, 3);
INSERT INTO `Hospital`.`has` (`Medicne_Code`, `Prescription_ID`, `Dosage`) VALUES (0987, 3, 2);
INSERT INTO `Hospital`.`has` (`Medicne_Code`, `Prescription_ID`, `Dosage`) VALUES (3578, 4, 1);
INSERT INTO `Hospital`.`has` (`Medicne_Code`, `Prescription_ID`, `Dosage`) VALUES (9753, 5, 2);
INSERT INTO `Hospital`.`has` (`Medicne_Code`, `Prescription_ID`, `Dosage`) VALUES (0099, 6, 3);
INSERT INTO `Hospital`.`has` (`Medicne_Code`, `Prescription_ID`, `Dosage`) VALUES (8090, 7, 4);
INSERT INTO `Hospital`.`has` (`Medicne_Code`, `Prescription_ID`, `Dosage`) VALUES (4455, 8, 2);
INSERT INTO `Hospital`.`has` (`Medicne_Code`, `Prescription_ID`, `Dosage`) VALUES (6331, 9, 3);
INSERT INTO `Hospital`.`has` (`Medicne_Code`, `Prescription_ID`, `Dosage`) VALUES (7676, 7, 1);

COMMIT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
