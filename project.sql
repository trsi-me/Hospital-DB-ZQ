-- 1. CREATE TABLES (DDL)

CREATE TABLE COVERAGES (
  CoverageID CHAR(10) PRIMARY KEY,
  ProviderName VARCHAR(100) NOT NULL,
  LimitAmount INT NOT NULL );

CREATE TABLE CLIENTS (
  ClientID CHAR(10) PRIMARY KEY,
  GivenName VARCHAR(50)  NOT NULL,
  FamilyName VARCHAR(50)  NOT NULL,
  BirthDate DATE NOT NULL,
  Sex CHAR(1) NOT NULL,    -- 'M' or 'F'
  Phone VARCHAR(15)  NOT NULL,
  AltContact VARCHAR(15)  NOT NULL,
  Residence VARCHAR(255) NOT NULL,
  CoverageID CHAR(10)  NOT NULL,
  FOREIGN KEY (CoverageID) REFERENCES COVERAGES(CoverageID));

CREATE TABLE DOCTORS (
  DoctorID CHAR(10) PRIMARY KEY,
  GivenName VARCHAR(50)  NOT NULL,
  FamilyName VARCHAR(50)  NOT NULL,
  Specialty VARCHAR(100) NOT NULL,
  Mobile  VARCHAR(15)  NOT NULL,
  EmailAddr VARCHAR(100) NOT NULL );

CREATE TABLE CAREGIVERS (
  CaregiverID CHAR(10) PRIMARY KEY,
  GivenName   VARCHAR(50)  NOT NULL,
  FamilyName VARCHAR(50)  NOT NULL,
  ShiftType VARCHAR(10)  NOT NULL,    -- 'Day' | 'Night'
  Mobile VARCHAR(15)  NOT NULL,
  EmailAddr VARCHAR(100) NOT NULL );

CREATE TABLE HOSPITALIZATIONS (
  HospID CHAR(10) PRIMARY KEY,
  ClientID CHAR(10) NOT NULL,
  AdmiDate DATE NOT NULL,
  ReleaseDate DATE NOT NULL,
  Diagnosis VARCHAR(255) NOT NULL,
  AttendingDoc CHAR(10) NOT NULL,
  WardNo VARCHAR(10) NOT NULL,
  FOREIGN KEY (ClientID) REFERENCES CLIENTS(ClientID),
  FOREIGN KEY (AttendingDoc) REFERENCES DOCTORS(DoctorID) );

CREATE TABLE SCHEDULES (
  ScheduleID CHAR(10) PRIMARY KEY,
  ClientID CHAR(10) NOT NULL,
  DoctorID CHAR(10) NOT NULL,
  ScheduledAt DATETIME NOT NULL,
  Status VARCHAR(20) NOT NULL,      -- 'Confirmed','Canceled','Rescheduled'
  FOREIGN KEY (ClientID) REFERENCES CLIENTS(ClientID),
  FOREIGN KEY (DoctorID) REFERENCES DOCTORS(DoctorID) );

CREATE TABLE DIAGNOSTICS (
  TestCode CHAR(10) PRIMARY KEY,
  TestLabel VARCHAR(100) NOT NULL,
  TestInfo VARCHAR(255) NOT NULL );

CREATE TABLE DIAG_RESULTS (
  ResultCode CHAR(10) PRIMARY KEY,
  TestCode CHAR(10) NOT NULL,
  ClientID CHAR(10) NOT NULL,
  DateRecorded DATE NOT NULL,
  Details VARCHAR(255) NOT NULL,
  FOREIGN KEY (TestCode) REFERENCES DIAGNOSTICS(TestCode),
  FOREIGN KEY (ClientID) REFERENCES CLIENTS(ClientID) );

CREATE TABLE DRUGS (
  DrugCode CHAR(10) PRIMARY KEY,
  DrugName VARCHAR(100) NOT NULL,
  Strength VARCHAR(50)  NOT NULL,
  AdminRoute VARCHAR(20)  NOT NULL,      -- 'oral','injectable','infusion'
  Schedule VARCHAR(50)  NOT NULL);

CREATE TABLE PRESCRIPTIONS (
  RXID CHAR(10) PRIMARY KEY,
  ClientID CHAR(10) NOT NULL,
  DoctorID CHAR(10) NOT NULL,
  DrugCode CHAR(10) NOT NULL,
  RXDate DATE NOT NULL,
  Instructions VARCHAR(255) NOT NULL,
  FOREIGN KEY (ClientID) REFERENCES CLIENTS(ClientID),
  FOREIGN KEY (DoctorID) REFERENCES DOCTORS(DoctorID),
  FOREIGN KEY (DrugCode) REFERENCES DRUGS(DrugCode) );

-- 2. INSERT SAMPLE DATA (DML) – 10 ROWS EACH
-- 2.1 COVERAGES
INSERT INTO COVERAGES VALUES
('CV00000001','MedSecure',10000),
('CV00000002','LifeCare',20000),
('CV00000003','HealthPlus',15000),
('CV00000004','SafeHealth',25000),
('CV00000005','WellAssist',12000),
('CV00000006','GuardMedical',30000),
('CV00000007','PrimeHealth', 8000),
('CV00000008','FamilyCover',18000),
('CV00000009','EliteGuard',22000),
('CV00000010','BasicShield',16000);

-- 2.2 CLIENTS
INSERT INTO CLIENTS VALUES
('CL00000001','Omar','AlOtaibi','1980-03-15','M','0501111001','0502222001','Riyadh, AlSina St.','CV00000001'),
('CL00000002','Sara','AlZahrani','1992-07-20','F','0501111002','0502222002','Jeddah, North Rd.','CV00000002'),
('CL00000003','Yara','AlAmri','1985-11-05','F','0501111003','0502222003','Dammam, Sea St.','CV00000003'),
('CL00000004','Faisal','AlHarbi','1975-01-30','M','0501111004','0502222004','Makkah, Hill Rd.','CV00000004'),
('CL00000005','Nora','AlShaikh','2000-05-22','F','0501111005','0502222005','Riyadh, Elm St.','CV00000005'),
('CL00000006','Khalid','AlGhamdi','1990-09-10','M','0501111006','0502222006','Jeddah, Corniche','CV00000006'),
('CL00000007','Lina','AlQahtani','1988-12-12','F','0501111007','0502222007','Dammam, Bay Rd.','CV00000007'),
('CL00000008','Saad','AlOlayan','1978-06-18','M','0501111008','0502222008','Makkah, Market St.','CV00000008'),
('CL00000009','Reem','AlFaris','1995-02-02','F','0501111009','0502222009','Riyadh, Palm Plaza','CV00000009'),
('CL00000010','Hassan','AlMutairi','1982-08-08','M','0501111010','0502222010','Jeddah, Tahlia','CV00000010');

-- 2.3 DOCTORS
INSERT INTO DOCTORS VALUES
('DR00000001','Dalal','Namnaqani','Neurology','0502001001','dalal@med.sa'),
('DR00000002','Sultan','AlAnzi','Cardiology','0502001002','sultan@med.sa'),
('DR00000003','Mona','AlRashid','Pediatrics','0502001003','mona@med.sa'),
('DR00000004','Yousef','AlObaid','Orthopedics','0502001004','yousef@med.sa'),
('DR00000005','Lama','AlZain','Dermatology','0502001005','lama@med.sa'),
('DR00000006','Rana','AlSuhaimi','Neurology','0502001006','rana@med.sa'),
('DR00000007','Adel','AlHarthy','ENT','0502001007','adel@med.sa'),
('DR00000008','Nawal','AlMansour','Gynecology','0502001008','nawal@med.sa'),
('DR00000009','Khalid','AlOthman','Neurology','0502001009','khaled@med.sa'),
('DR00000010','Sara','AlSaleh','Oncology','0502001010','sara@med.sa');

-- 2.4 CAREGIVERS
INSERT INTO CAREGIVERS VALUES
('CG00000001','Amal','AlKhalid','Day','0503002001','amal@med.sa'),
('CG00000002','Huda','AlEssa','Night','0503002002','huda@med.sa'),
('CG00000003','Talal','AlMahdi','Day','0503002003','talal@med.sa'),
('CG00000004','Nada','AlAmir','Night','0503002004','nada@med.sa'),
('CG00000005','Khalid','AlZubaidi','Day','0503002005','khalid@med.sa'),
('CG00000006','Reem','AlHarbi','Night','0503002006','reem@med.sa'),
('CG00000007','Mansour','AlFahad','Day','0503002007','mansour@med.sa'),
('CG00000008','Sara','AlMajed','Night','0503002008','sara@med.sa'),
('CG00000009','Fahad','AlNasser','Day','0503002009','fahad@med.sa'),
('CG00000010','Lulwa','AlSudairi','Night','0503002010','lulwa@med.sa');

-- 2.5 HOSPITALIZATIONS
INSERT INTO HOSPITALIZATIONS VALUES
('HP00000001','CL00000001','2020-03-10','2020-03-20','COVID-19','DR00000001','W101'),
('HP00000002','CL00000002','2021-05-05','2021-05-10','Pneumonia','DR00000002','W202'),
('HP00000003','CL00000003','2019-11-15','2019-11-18','Flu','DR00000003','W303'),
('HP00000004','CL00000004','2020-07-01','2020-07-07','Fracture','DR00000004','W404'),
('HP00000005','CL00000005','2022-01-20','2022-01-25','Dermatitis','DR00000005','W505'),
('HP00000006','CL00000006','2021-09-12','2021-09-15','Cancer','DR00000010','W606'),
('HP00000007','CL00000007','2020-04-22','2020-04-30','Migraine','DR00000001','W707'),
('HP00000008','CL00000008','2018-12-05','2018-12-10','Tonsillitis','DR00000007','W808'),
('HP00000009','CL00000009','2020-02-28','2020-03-05','COVID-19','DR00000009','W909'),
('HP00000010','CL00000010','2021-06-15','2021-06-20','Gynecological','DR00000008','W010');

-- 2.6 SCHEDULES
INSERT INTO SCHEDULES VALUES
('SC00000001','CL00000001','DR00000001','2025-06-01 09:00:00','Confirmed'),
('SC00000002','CL00000002','DR00000002','2025-06-02 10:30:00','Canceled'),
('SC00000003','CL00000003','DR00000003','2025-06-03 11:00:00','Confirmed'),
('SC00000004','CL00000004','DR00000004','2025-06-04 14:00:00','Rescheduled'),
('SC00000005','CL00000005','DR00000005','2025-06-05 08:30:00','Confirmed'),
('SC00000006','CL00000006','DR00000006','2025-06-06 13:00:00','Confirmed'),
('SC00000007','CL00000007','DR00000007','2025-06-07 15:00:00','Canceled'),
('SC00000008','CL00000008','DR00000008','2025-06-08 16:30:00','Confirmed'),
('SC00000009','CL00000009','DR00000009','2025-06-09 12:00:00','Confirmed'),
('SC00000010','CL00000010','DR00000010','2025-06-10 10:00:00','Confirmed');

-- 2.7 DIAGNOSTICS
INSERT INTO DIAGNOSTICS VALUES
('TS00000001','BloodTest','Complete blood count'),
('TS00000002','XRay','Chest radiography'),
('TS00000003','MRI','Brain MRI scan'),
('TS00000004','Ultrasound','Abdominal ultrasound'),
('TS00000005','ECG','Electrocardiogram'),
('TS00000006','CTScan','Head CT scan'),
('TS00000007','UrineTest','Urinalysis'),
('TS00000008','Allergy','Skin prick test'),
('TS00000009','Endoscopy','GI endoscopy'),
('TS00000010','Biopsy','Tissue analysis');

-- 2.8 DIAG_RESULTS
INSERT INTO DIAG_RESULTS VALUES
('DRS0000001','TS00000001','CL00000001','2025-05-01','Normal'),
('DRS0000002','TS00000002','CL00000002','2025-05-02','Clear'),
('DRS0000003','TS00000003','CL00000003','2025-05-03','Mild lesion'),
('DRS0000004','TS00000004','CL00000004','2025-05-04','Normal'),
('DRS0000005','TS00000005','CL00000005','2025-05-05','Arrhythmia'),
('DRS0000006','TS00000006','CL00000006','2025-05-06','Clear'),
('DRS0000007','TS00000007','CL00000007','2025-05-07','Infection'),
('DRS0000008','TS00000008','CL00000008','2025-05-08','Allergic'),
('DRS0000009','TS00000009','CL00000009','2025-05-09','Ulcer'),
('DRS0000010','TS00000010','CL00000010','2025-05-10','Benign');

-- 2.9 DRUGS
INSERT INTO DRUGS VALUES
('DG00000001','Paracetamol','500mg','oral','Every 6h'),
('DG00000002','Ibuprofen','200mg','oral','Every 8h'),
('DG00000003','Amoxicillin','250mg','oral','Every 12h'),
('DG00000004','Morphine','10mg','injectable','PRN'),
('DG00000005','Heparin','5000IU','injectable','Every 8h'),
('DG00000006','Omeprazole','20mg','oral','Once daily'),
('DG00000007','Saline','1000ml','infusion','Once'),
('DG00000008','Ceftriaxone','1g','injectable','Once daily'),
('DG00000009','Metformin','500mg','oral','Twice daily'),
('DG00000010','Insulin','10IU','injectable','Before meals');

-- 2.10 PRESCRIPTIONS
INSERT INTO PRESCRIPTIONS VALUES
('RX00000001','CL00000001','DR00000001','DG00000001','2025-05-01','500mg every 6h'),
('RX00000002','CL00000002','DR00000002','DG00000002','2025-05-02','200mg every 8h'),
('RX00000003','CL00000003','DR00000003','DG00000003','2025-05-03','250mg every 12h'),
('RX00000004','CL00000004','DR00000004','DG00000004','2025-05-04','10mg PRN'),
('RX00000005','CL00000005','DR00000005','DG00000005','2025-05-05','5000IU every 8h'),
('RX00000006','CL00000006','DR00000006','DG00000006','2025-05-06','20mg once daily'),
('RX00000007','CL00000007','DR00000007','DG00000007','2025-05-07','1000ml once'),
('RX00000008','CL00000008','DR00000008','DG00000008','2025-05-08','1g once daily'),
('RX00000009','CL00000009','DR00000009','DG00000009','2025-05-09','500mg twice daily'),
('RX00000010','CL00000010','DR00000010','DG00000010','2025-05-10','10IU before meals');

--
-- 3. QUERIES (a–j)

-- a) Clients admitted in 2020 with COVID-19
SELECT C.* 
FROM CLIENTS C
JOIN HOSPITALIZATIONS H ON C.ClientID = H.ClientID
WHERE YEAR(H.AdmiDate) = 2020
  AND H.Diagnosis LIKE '%COVID-19%';

-- b) All future schedules
SELECT ScheduledAt, Status
FROM SCHEDULES
WHERE ScheduledAt > CURRENT_DATE();

-- c) Admissions by Dr. Namnaqani
SELECT C.GivenName, C.FamilyName, H.AdmiDate, H.ReleaseDate
FROM CLIENTS C
JOIN HOSPITALIZATIONS H ON C.ClientID = H.ClientID
JOIN DOCTORS D ON H.AttendingDoc = D.DoctorID
WHERE D.GivenName = 'Dalal' AND D.FamilyName = 'Namnaqani';

-- d) Doctors in Neurology
SELECT * 
FROM DOCTORS
WHERE Specialty = 'Neurology';

-- e) Day-shift caregiver mobiles
SELECT Mobile
FROM CAREGIVERS
WHERE ShiftType = 'Day';

-- f) Instructions for oral & injectable drugs
SELECT P.Instructions, D.DrugName
FROM PRESCRIPTIONS P
JOIN DRUGS D ON P.DrugCode = D.DrugCode
WHERE D.AdminRoute IN ('oral','injectable');

-- g) Coverages above 15000
SELECT *
FROM COVERAGES
WHERE LimitAmount > 15000;

-- h) TestInfo for clients living in 'Alsadad'
SELECT DI.TestInfo
FROM DIAGNOSTICS DI
JOIN DIAG_RESULTS R ON DI.TestCode = R.TestCode
JOIN CLIENTS C ON R.ClientID = C.ClientID
WHERE C.Residence LIKE '%Alsadad%';

-- i) Doctors confirmed with all female clients
SELECT DISTINCT D.DoctorID, D.GivenName, D.FamilyName
FROM DOCTORS D
WHERE NOT EXISTS (
  SELECT 1 FROM CLIENTS C
  WHERE C.Sex = 'F'
    AND NOT EXISTS (
      SELECT 1 FROM SCHEDULES S
      WHERE S.DoctorID = D.DoctorID
        AND S.ClientID = C.ClientID
        AND S.Status = 'Confirmed' )
);

-- j) Clients with >3 schedules last year
SELECT C.ClientID, C.GivenName, C.FamilyName, COUNT(S.ScheduleID) AS NumSchedules
FROM CLIENTS C
JOIN SCHEDULES S ON C.ClientID = S.ClientID
WHERE S.ScheduledAt >= DATE_SUB(CURRENT_DATE(), INTERVAL 1 YEAR)
GROUP BY C.ClientID, C.GivenName, C.FamilyName
HAVING COUNT(S.ScheduleID) > 3;