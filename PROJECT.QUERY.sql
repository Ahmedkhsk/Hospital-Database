-- Some queries on one table
-- __________________________________________________________
-- Retrieve the nurse who has a second letter of his/her name is letter A and shift time
select n.name 'Nurse',shift_Time
 from nurse n WHERE name like '_a%';
 
 -- __________________________________________________________
 
-- Increase the salary for each doctor  whose salary is more than 25000 by adding 10% of the last salary
set sql_safe_updates=0;
update docor 
set salary = salary + salary *.010
where salary <25000;

-- __________________________________________________________

-- Retrieve the department of “dermatology” , “ cardiology” and the SSN of their manager  
select name , mgr_ssn 
from Department 
where name = 'dermatology' or name ='cardiology';

-- __________________________________________________________

-- Retrieve the name and gender of each doctor doesn’t have an email
select name , gender , email 
from doctor 
where email is null;

-- __________________________________________________________
-- Some queries on many tables
-- __________________________________________________________

-- Retrieve  the name of patient and his medicine
select   distinct me.Name as "medicine", p.Name "patient"
from Patient p , Describe_d de,Medicne me, prescription pr, has h
where p.PSSN= de.Patient_SSN  and de.Prescription_id =h.Prescription_id and me.Code = h.Medicne_Code;

-- __________________________________________________________

-- Retrieve name patient whose names contain the letter a, his doctor , number of room , name of medicine ,  name of medical test , dateof prescrption
select p.Name 'Patient', d.Name 'Doctor', r.RNum, m.Name 'Medicine' , me.Name 'name of medical test', pr.Date
from Patient p, Doctor d , Describe_d f , Room r, Prescription pr, Medicne m ,has h,Medical_test me
where p.Name like '%a%' and p.Room_Num=r.RNum and p.PSSN=f.Patient_SSN and d.DSSN=f.Doctor_SSN 
AND MID=f.Medical_Test_ID and PID=f.Prescription_ID and PID=h.Prescription_ID and m.Code =h.Medicne_Code;

-- __________________________________________________________

-- Retrieve the name of doctor , his patient  , his specialization and  total payments 
select distinct d.Name "doctor", n.Name as "Specialization" ,p.Name "patient",pa.Price
from Describe_d de , Doctor d, Patient p , Payment pa , Department n
where p.PSSN= de.Patient_SSN and d.DSSN =de.Doctor_SSN and pa.Patient_SSN =p.PSSN and d.Specialization=n.DNum;

-- __________________________________________________________

-- Retrieve each manger of each department and his salary
select  d.Name as "Doctor" ,de.Name as "Department", d.Salary
from Doctor d,Department de
Where   de.Mgr_SSN=d.DSSN  ;

-- __________________________________________________________

-- Retrieve all doctor and if he has a patient or not
select p.Name 'Patient' ,d.Name 'Doctor'
from patient p  join describe_d  on p.PSSN=Patient_SSN 
right outer join Doctor d on Doctor_SSN=DSSN;

-- __________________________________________________________

-- Retrieve all the patient in emergency and he treated by any doctor and doctor,s Specialization
select p.Name as "patient in emergency" , d.Name "doctor" , de.Name as "Specialization"
from patient p , treat t ,emergency e , doctor d , department de 
where p.PSSN = t.Patient_SSN and e.ENum = t.Emergency_Num 
and d.DSSN = t.Doctor_SSN and de.Dnum = d.Specialization ;

-- __________________________________________________________

-- Retrieve  all the patient who have a medical test=“npv”
select p.name 'patient',m.name 
from patient p, describe_d d,medical_test m
where p.pssn=patient_SSN and m.MID=d.Medical_Test_ID
and m.name = 'npv';

-- __________________________________________________________
-- Some queries use aggregate ,group by ,and having
-- __________________________________________________________

-- Retrieve all nurses and the number of room they serve 
select n.Name , count(*) as 'number of room'
from Nurse n join Nurse_Has_Room on NID= Nurse_ID join Room on RNum=Room_num
group by n.Name order by COUNT(*);

-- __________________________________________________________

-- Retrieve each doctor and his department and how many patients has he diagnosed with
 
select d.Name as 'Doctor' , count(*) as 'numbrer of the patient treated by doctor ', de.Name as 'Specialization'
from Doctor  d, Describe_d b,patient p,  Department de
where PSSN=b.Patient_SSN and  d.DSSN=b.Doctor_SSn  and DNum=Specialization
group by d.Name ;

-- __________________________________________________________

-- Retrieve the patient , his room and capacity has room
select p.Name as "patient",r.RNum 'Room Number' ,Capacity
from Patient p , Room r
where r.RNum=p.Room_Num 
order by RNUM;

-- __________________________________________________________

-- Retrieve patient name and his number of medicne  
select p.Name , count(M.code) as "num of medicne"
from patient p , describe_d d, prescription pr , has h , medicne m
where p.PSSN = d.Patient_SSN and d.Prescription_ID = pr.PID 
and pr.PID=h.Prescription_ID and h.Medicne_Code=m.Code 
group by m.Name ;

-- __________________________________________________________

-- Retrieve  the name and the salary of each doctor whose name contains the letter N and sort them by gender
select salary , gender , name 
from doctor 
where name like ('%n%')
order by gender;

-- __________________________________________________________

-- Retrieve the number of room and his patient
select Rnum, count(p.Pssn) 'number of patient'
from Room , Patient p
where Rnum= p.Room_num
group by Room_num;
-- __________________________________________________________

-- Retrieve how many doctor in each department
select d.Name as "Department" , count(*) as "number of doctor in each department"
from department d , doctor de
where d.DNum = de.Specialization
group by d.Name ;
-- __________________________________________________________
-- nested 
-- __________________________________________________________

-- Retrieve  the salary of the doctor where the salary more than average salary
select name,salary
from doctor
having salary > (select avg(salary)from doctor);

-- __________________________________________________________
-- Retrieve the doctor has the highest salary 
select d.Name 'Doctor',d.salary 'highest salary'
from Doctor d
where salary = (select max(Salary) from Doctor) ;
-- __________________________________________________________
