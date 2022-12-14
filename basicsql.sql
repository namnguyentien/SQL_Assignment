create table faculty (
	id number primary key,
	name nvarchar2(30) not null
);

-- subject (Môn học)
create table subject(
	id number primary key,
	name nvarchar2(100) not null,
	lesson_quantity number(2,0) not null -- tổng số tiết học
);

-- student (Sinh viên)
create table student (
	id number primary key,
	name nvarchar2(30) not null,
	gender nvarchar2(10) not null, -- giới tính
	birthday date not null,
	hometown nvarchar2(100) not null, -- quê quán
	scholarship number, -- học bổng
	faculty_id number not null constraint faculty_id references faculty(id) -- mã khoa
);

-- exam management (Bảng điểm)
create table exam_management(
	id number primary key,
	student_id number not null constraint student_id references student(id),
	subject_id number not null constraint subject_id references subject(id),
	number_of_exam_taking number not null, -- số lần thi (thi trên 1 lần được gọi là thi lại) 
	mark number(4,2) not null -- điểm
);



/*================================================*/

/* II. INSERT SAMPLE DATA */

-- subject
insert into subject (id, name, lesson_quantity) values (1, n'Cơ sở dữ liệu', 45);
insert into subject values (2, n'Trí tuệ nhân tạo', 45);
insert into subject values (3, n'Truyền tin', 45);
insert into subject values (4, n'Đồ họa', 60);
insert into subject values (5, n'Văn phạm', 45);


-- faculty
insert into faculty values (1, n'Anh - Văn');
insert into faculty values (2, n'Tin học');
insert into faculty values (3, n'Triết học');
insert into faculty values (4, n'Vật lý');


-- student
insert into student values (1, n'Nguyễn Thị Hải', n'Nữ', to_date('19900223', 'YYYYMMDD'), 'Hà Nội', 130000, 2);
insert into student values (2, n'Trần Văn Chính', n'Nam', to_date('19921224', 'YYYYMMDD'), 'Bình Định', 150000, 4);
insert into student values (3, n'Lê Thu Yến', n'Nữ', to_date('19900221', 'YYYYMMDD'), 'TP HCM', 150000, 2);
insert into student values (4, n'Lê Hải Yến', n'Nữ', to_date('19900221', 'YYYYMMDD'), 'TP HCM', 170000, 2);
insert into student values (5, n'Trần Anh Tuấn', n'Nam', to_date('19901220', 'YYYYMMDD'), 'Hà Nội', 180000, 1);
insert into student values (6, n'Trần Thanh Mai', n'Nữ', to_date('19910812', 'YYYYMMDD'), 'Hải Phòng', null, 3);
insert into student values (7, n'Trần Thị Thu Thủy', n'Nữ', to_date('19910102', 'YYYYMMDD'), 'Hải Phòng', 10000, 1);


-- exam_management
insert into exam_management values (1, 1, 1, 1, 3);
insert into exam_management values (2, 1, 1, 2, 6);
insert into exam_management values (3, 1, 2, 2, 6);
insert into exam_management values (4, 1, 3, 1, 5);
insert into exam_management values (5, 2, 1, 1, 4.5);
insert into exam_management values (6, 2, 1, 2, 7);
insert into exam_management values (7, 2, 3, 1, 10);
insert into exam_management values (8, 2, 5, 1, 9);
insert into exam_management values (9, 3, 1, 1, 2);
insert into exam_management values (10, 3, 1, 2, 5);
insert into exam_management values (11, 3, 3, 1, 2.5);
insert into exam_management values (12, 3, 3, 2, 4);
insert into exam_management values (13, 4, 5, 2, 10);
insert into exam_management values (14, 5, 1, 1, 7);
insert into exam_management values (15, 5, 3, 1, 2.5);
insert into exam_management values (16, 5, 3, 2, 5);
insert into exam_management values (17, 6, 2, 1, 6);
insert into exam_management values (18, 6, 4, 1, 10);



/*================================================*/
--1. Liệt kê danh sách sinh viên sắp xếp theo thứ tự:
--      a. id tăng dần
--      b. giới tính
--      c. ngày sinh TĂNG DẦN và học bổng GIẢM DẦN
SELECT * FROM STUDENT
ORDER BY ID;

SELECT * FROM STUDENT
ORDER BY GENDER; 


SELECT * FROM STUDENT
ORDER BY BIRTHDAY ASC
, SCHOLARSHIP DESC ;


-- 2. Môn học có tên bắt đầu bằng chữ 'T'
SELECT * FROM SUBJECT
WHERE NAME LIKE 'T%';
-- 3. Sinh viên có chữ cái cuối cùng trong tên là 'i'
SELECT * FROM STUDENT
WHERE NAME LIKE '%i';
-- 4. Những khoa có ký tự thứ hai của tên khoa có chứa chữ 'n'
SELECT * FROM FACULTY
WHERE NAME LIKE '_n%';
-- 5. Sinh viên trong tên có từ 'Thị'
SELECT * FROM STUDENT
WHERE NAME LIKE '%Thị%';
-- 6. Sinh viên có ký tự đầu tiên của tên nằm trong khoảng từ 'a' đến 'm', sắp xếp theo họ tên sinh viên
SELECT * FROM student
WHERE name between 'A' and 'M'
ORDER by name asc;
-- 7. Sinh viên có học bổng lớn hơn 100000, sắp xếp theo mã khoa giảm dần
SELECT * FROM STUDENT
WHERE SCHOLARSHIP >'100000'
ORDER BY FACULTY_ID DESC;
-- 8. Sinh viên có học bổng từ 150000 trở lên và sinh ở Hà Nội
SELECT * FROM STUDENT
WHERE SCHOLARSHIP >'150000'
AND HOMETOWN = 'Hà Nội';

-- 9. Những sinh viên có ngày sinh từ ngày 01/01/1991 đến ngày 05/06/1992

SELECT * FROM STUDENT
WHERE BIRTHDAY BETWEEN TO_DATE ('01/01/1991', 'dd/mm/yyyy')
AND TO_DATE ('05/06/1992', 'dd/mm/yyyy');
-- 10. Những sinh viên có học bổng từ 80000 đến 150000
SELECT * FROM STUDENT
WHERE SCHOLARSHIP BETWEEN '80000' AND '150000';
-- 11. Những môn học có số tiết lớn hơn 30 và nhỏ hơn 45
SELECT * FROM SUBJECT
WHERE LESSON_QUANTITY > '30' AND LESSON_QUANTITY<'45';

--SELECT * FROM STUDENT
--WHERE NAME LIKE '%Thị%'
--ORDER BY NAME;


------------------------------------------------------------

/********* B. CALCULATION QUERY *********/

-- 1. Cho biết thông tin về mức học bổng của các sinh viên, gồm: Mã sinh viên, Giới tính, Mã 
		-- khoa, Mức học bổng. Trong đó, mức học bổng sẽ hiển thị là “Học bổng cao” nếu giá trị 
		-- của học bổng lớn hơn 500,000 và ngược lại hiển thị là “Mức trung bình”.
        select id as "Mã sinh viên",gender as "Gioi tinh", faculty_id as "Mã khoa",
        case 
        when scholarship > 500000 then 'Học bổng cao' 
        else 'Mức trung bình' 
        end as "Mức học bổng"
from student;
		
-- 2. Tính tổng số sinh viên của toàn trường

select count(student.id)as "Tổng số sinh viên" from student;

-- 3. Tính tổng số sinh viên nam và tổng số sinh viên nữ.

select count(student.id) as "Tổng số sinh viên nam" from student
where gender like 'Nam';

select
  count(case when gender='Nam' then 1 end) as "Tổng số sinh viên nam",
  count(case when gender='Nữ' then 1 end) as "Tổng số sinh viên nữ"
from student;

-- 4. Tính tổng số sinh viên từng khoa
SELECT faculty_id as "Ma khoa", count(id) as "Tong sinh viên"
FROM student
group by faculty_id;   

-- 5. Tính tổng số sinh viên của từng môn học
SELECT name as "Tên môn hoc", count(distinct student_id) as "Tong sinh viên"
FROM exam_management ex,subject su
where ex.subject_id = su.id
group by name;
-- 6. Tính số lượng môn học mà sinh viên đã học
select count(distinct  subject_id)as "Tong so môn hoc"
from exam_management;
-- 7. Tổng số học bổng của mỗi khoa	
select faculty_id as "Ma khoa",sum(scholarship) as"Tong hoc bong"
from student
group by faculty_id;
-- 8. Cho biết học bổng cao nhất của mỗi khoa
select faculty_id as "Mã khoa",max(scholarship) as" Học bổng cao nhất"
from student
group by faculty_id;
-- 9. Cho biết tổng số sinh viên nam và tổng số sinh viên nữ của mỗi khoa
SELECT faculty_id as "Ma khoa",  count(case gender when N'Nam'then 1 else 0 end) as"Tong sinh viên nam" ,count(case gender when N'N?'then 1 else 0 end) as"Tong sinh viên nu"
FROM student
group by faculty_id;
--CÂU10 Cho bi?t s? lư?ng sinh viên theo tung đo tuoi
select EXTRACT(YEAR from CURRENT_TIMESTAMP)-EXTRACT(YEAR from birthday) as "Độ tuổi",count(id) as "Số sinh viên"
from student
group by EXTRACT(YEAR from CURRENT_TIMESTAMP)-EXTRACT(YEAR from birthday);

--CÂU 11 Cho biết những nơi nào có ít nhất 2 sinh viên đang theo học tại trường

select hometown as "Nơi sinh",count(id)as "Số sinh viên"
from student
group by hometown
having count(id)>=2;

--CÂU 12  Cho biết nh?ng sinh viên thi lại ít nhất 2 lần

select student_id,subject_id,count(number_of_exam_taking) as"Số lần thi lại"
from exam_management 
group by student_id,subject_id
having count(number_of_exam_taking)>=2;

-- 13. Cho biết những sinh viên nam có điểm trung bình lần 1 trên 7.0 
select name as"Tên sinh viên",gender,number_of_exam_taking,avg(mark)as"Điểm trung bình"
from exam_management ex,student sv
where ex.student_id=sv.id and number_of_exam_taking=1 and gender=N'Nam'
group by number_of_exam_taking,gender, name
having avg(mark)>7.0;

--14. Cho biết danh sách các sinh viên rớtt ít nhất 2 môn ở lần thi 1 (rớt môn là điểm thi của môn không quá 4 điểm)

select student_id as"Mã sinh viên",count(subject_id)as"số lượng môn trươt"
from exam_management
where number_of_exam_taking=1 and mark<4
group by student_id
having count(subject_id)>=2;

-- 15. Cho biết danh sách những khoa có nhiều hơn 2 sinh viên nam
select faculty_id as"Mã khoa", k.name,count(sv.id)as"số sinh viên nam"
from student st,faculty fa
where st.faculty_id=fa.id and gender=N'Nam'
group by st.faculty_id,gender,fa.name
having count(st.id)>=2;

-- 16. Cho biết những khoa có 2 sinh viên đạt học bổng từ 200000 đến 300000
select faculty_id as"Mã khoa", fa.name,count(st.id)as"Số sinh viên "
from student st,faculty fa
where st.faculty_id=fa.id and scholarship>100000 and scholarship<300000
group by st.faculty_id,fa.name
having count(st.id)>=2;


-- 17. Cho biết sinh viên nào có học bổng cao nhất
select *
from student
where scholarship =(select max(scholarship) from student);




/********* C. DATE/TIME QUERY *********/

-- 1. Sinh viên có nơi sinh ở Hà Nội và sinh vào tháng 02

SELECT * FROM student WHERE hometown=N'Hà Nội' and EXTRACT(MONTH FROM Birthday) = 2;


-- 2. Sinh viên có tuổi lớn hơn 20
select * from student
where
TRUNC(months_between(sysdate, STUDENT.BIRTHDAY ) / 12,8) > 20;

-- 3. Sinh viên sinh vào mùa xuân năm 1990
SELECT * FROM student WHERE (EXTRACT(MONTH FROM Birthday) in(1,2,3)) and EXTRACT(year FROM Birthday)=1990;


--------------------------------------------------------------
--Danh sách các sinh viên của khoa ANH VĂN và khoa VẬT LÝ
/********* D. JOIN QUERY *********/

-- 1. Danh sách các sinh viên của khoa ANH VĂN và khoa VẬT LÝ

select * from student 
inner join faculty
on student.faculty_id = faculty_id
where faculty.name like 'Anh - Văn' or faculty.name like 'Vật lý';

-- 2. Những sinh viên nam của khoa ANH VĂN và khoa TIN HỌC
select * from student 
inner join faculty
on student.faculty_id = faculty_id
where (faculty.name like 'Anh - Văn' or faculty.name like 'Tin học')and gender like'Nam';

-- 3. Cho biết sinh viên nào có điểm thi lần 1 môn cơ sở dữ liệu cao nhất
select * from(select * from student 
inner join exam_management
on student.id = exam_management.student_id
where (subject_id like '1' )and number_of_exam_taking like'1'
order by mark desc)
where rownum=1;

-- 4. Cho biết sinh viên khoa anh văn có tuổi lớn nhất.

SELECT * FROM(SELECT ID, NAME,BIRTHDAY,FACULTY_ID,(TRUNC(months_between(sysdate, STUDENT.BIRTHDAY ) / 12,8)) AS "TUOI"
FROM STUDENT
WHERE student.faculty_id=1
ORDER BY TUOI DESC)
WHERE ROWNUM=1;

-- 5. Cho biết khoa nào có đông sinh viên nhất
select name from (select student.faculty_id,faculty.name as name,count(*) as "tongsosinhvien" 
from faculty
inner join student
on faculty.id = student.faculty_id
group by faculty.name,student.faculty_id
order by "tongsosinhvien" desc) where rownum =1;

-- 6. Cho biết khoa nào có đông nữ nhất

select name as "Ten Khoa" from (select student.faculty_id,faculty.name as name,count(*) as "tongsosinhvien" from faculty
inner join student
on faculty.id = student.faculty_id
where student.gender like 'Nữ'
group by faculty.name,student.faculty_id
order by "tongsosinhvien" desc) where rownum =1;

-- 7. Cho biết những sinh viên đạt điểm cao nhất trong từng môn

select EXAM_MANAGEMENT.STUDENT_ID,EXAM_MANAGEMENT.SUBJECT_ID,MARK
from EXAM_MANAGEMENT,(select SUBJECT_ID, max(MARK) as maxdiem
    from EXAM_MANAGEMENT
    group by SUBJECT_ID)a
where EXAM_MANAGEMENT.SUBJECT_ID=a.SUBJECT_ID and MARK=a.maxdiem;


SELECT student.name, subject.name, max(mark)as "max"
FROM student st 
    JOIN exam_management ex
     ON st.id = ex.student_id 
     JOIN subject su
     ON su.id = ex.subject_id AND ex.student_id = st.id
WHERE max = ex.max(mark);

-- 8. Cho biết những khoa không có sinh viên học

select *
from faculty
where not exists (select distinct faculty.id
from exam_management,student where exam_management.student_id=student.id and faculty.id=faculty.id);

-- 9. Cho biết sinh viên chưa thi môn cơ sở dữ liệu
select *
from student
where not exists
(select distinct*
from exam_management
where subject_id like '1' and exam_management.student_id=student.id);

-- 10. Cho biết sinh viên nào không thi lần 1 mà có dự thi lần 2
select student_id,student.name
from exam_management ex
inner join student
on student_id = student.id 
where number_of_exam_taking=2 and not exists
(select *
from exam_management
where number_of_exam_taking=1 and student_id=ex.student_id);

-----------------------------------------------------------------------------






















    








