


select S.staff_no, S.staff_name, C.skill_name
from staff S
join staff_skill K on (S.staff_no = K.staff_no)
join code_skill C on (K.skill_code = C.skill_Code);


select staff_no, S.skill_code, skill_name
from staff_skill S
join code_skill C on(S.skill_code = C.skill_code)
where skill_name in ('JSP', 'ASP');


select staff_name
from staff
where staff_no in (


select staff_no
from staff_skill
where skill_code = 2
INTERSECT
select staff_no
from staff_skill
where skill_code = 3

);

commit;



--------------------------------------------------------------------------------
-- 이름 조건
--------------------------------------------------------------------------------
SELECT S.STAFF_NO, STAFF_NAME, DECODE(substr(jumin_no, 8, 1), '1', '남',  '2', '여', '3', '남', '4', '여') as "JUMIN_NO", DEPARTMENT_NAME, GRADUATE_DAY
FROM STAFF S
JOIN CODE_DEPARTMENT D ON (S.DEPARTMENT_CODE = D.DEPARTMENT_CODE)
WHERE STAFF_NAME LIKE '%' || '길' || '%'
;

--------------------------------------------------------------------------------
-- 성별 조건
--------------------------------------------------------------------------------
SELECT S.STAFF_NO, STAFF_NAME, DECODE(substr(jumin_no, 8, 1), '1', '남',  '2', '여', '3', '남', '4', '여') as "JUMIN_NO", DEPARTMENT_NAME, GRADUATE_DAY
FROM STAFF S
JOIN CODE_DEPARTMENT D ON (S.DEPARTMENT_CODE = D.DEPARTMENT_CODE)
WHERE SUBSTR(JUMIN_NO, 8, 1) IN (1, 3);



--------------------------------------------------------------------------------
-- 부서 조건
--------------------------------------------------------------------------------
SELECT S.STAFF_NO, STAFF_NAME, DECODE(substr(jumin_no, 8, 1), '1', '남',  '2', '여', '3', '남', '4', '여') as "JUMIN_NO", DEPARTMENT_NAME, GRADUATE_DAY
FROM STAFF S
JOIN CODE_DEPARTMENT D ON (S.DEPARTMENT_CODE = D.DEPARTMENT_CODE)
WHERE S.DEPARTMENT_CODE IN (SELECT DEPARTMENT_CODE FROM CODE_DEPARTMENT WHERE DEPARTMENT_NAME = '반도체사업부');


--------------------------------------------------------------------------------
-- 학력 조건
--------------------------------------------------------------------------------
SELECT S.STAFF_NO, STAFF_NAME, DECODE(substr(jumin_no, 8, 1), '1', '남',  '2', '여', '3', '남', '4', '여') as "JUMIN_NO", DEPARTMENT_NAME, GRADUATE_DAY
FROM STAFF S
JOIN CODE_DEPARTMENT D ON (S.DEPARTMENT_CODE = D.DEPARTMENT_CODE)
JOIN CODE_SCHOOL C ON (S.SCHOOL_CODE = C.SCHOOL_CODE)
WHERE S.SCHOOL_CODE IN (SELECT SCHOOL_CODE FROM CODE_SCHOOL WHERE SCHOOL_NAME IN ('고졸', '전문대졸', '일반대졸'));


--------------------------------------------------------------------------------
-- 기술 조건
--------------------------------------------------------------------------------
SELECT S.STAFF_NO, STAFF_NAME, DECODE(substr(jumin_no, 8, 1), '1', '남',  '2', '여', '3', '남', '4', '여') as "JUMIN_NO", DEPARTMENT_NAME, GRADUATE_DAY
FROM STAFF S
JOIN CODE_DEPARTMENT D ON (S.DEPARTMENT_CODE = D.DEPARTMENT_CODE)
JOIN CODE_SCHOOL C ON (S.SCHOOL_CODE = C.SCHOOL_CODE)
where staff_no in (
select staff_no
from staff_skill
where skill_code in (select skill_code from code_skill where skill_name = 'ASP')
INTERSECT
select staff_no
from staff_skill
where skill_code in (select skill_code from code_skill where skill_name = 'JSP')
);



--------------------------------------------------------------------------------
-- 졸업일 조건
--------------------------------------------------------------------------------
SELECT S.STAFF_NO, STAFF_NAME, DECODE(substr(jumin_no, 8, 1), '1', '남',  '2', '여', '3', '남', '4', '여') as "JUMIN_NO", DEPARTMENT_NAME, GRADUATE_DAY
FROM STAFF S
JOIN CODE_DEPARTMENT D ON (S.DEPARTMENT_CODE = D.DEPARTMENT_CODE)
JOIN CODE_SCHOOL C ON (S.SCHOOL_CODE = C.SCHOOL_CODE)
WHERE GRADUATE_DAY BETWEEN '195502' AND '199908';


--------------------------------------------------------------------------------
-- 뷰 작성
--------------------------------------------------------------------------------

CREATE OR REPLACE VIEW VW_STAFF
AS 
		SELECT 
		       S.STAFF_NO, 
		       STAFF_NAME, 
		       DECODE(substr(jumin_no, 8, 1), '1', '남',  '2', '여', '3', '남', '4', '여') as "JUMIN_NO",
		       DEPARTMENT_NAME,
		       GRADUATE_DAY,
		       S.SCHOOL_CODE
		  FROM 
		       STAFF S
		  JOIN 
		       CODE_DEPARTMENT D ON (S.DEPARTMENT_CODE = D.DEPARTMENT_CODE)
		  JOIN 
		       CODE_SCHOOL C ON (S.SCHOOL_CODE = C.SCHOOL_CODE);



SELECT * FROM VW_STAFF ORDER BY STAFF_NO DESC;


		SELECT
		       SKILL_NAME
		  FROM
		       STAFF_SKILL S
		  JOIN
		       CODE_SKILL C ON (S.SKILL_CODE = C.SKILL_CODE)
		 WHERE
		       STAFF_NO = 3;    



--------------------------------------------------------------------------------
-- 뷰 작성
--------------------------------------------------------------------------------
create or replace view VW_STAFF_INFO
as
select
S.STAFF_NO,
S.STAFF_NAME,
S.JUMIN_NO,
D.DEPARTMENT_NAME,
CC.SCHOOL_NAME,
CS.SKILL_NAME,
S.GRADUATE_DAY
from
staff S
join code_department D on(S.department_code = D.department_code)
join staff_skill SS on(S.staff_no = SS.staff_no)
join code_skill CS on(SS.skill_code = CS.skill_code)
join code_school CC on(S.school_code = CC.school_code);

SELECT 
STAFF_NO,
STAFF_NAME,
JUMIN_NO,
DEPARTMENT_NAME,
SCHOOL_NAME,
GRADUATE_DAY
FROM VW_STAFF_INFO
WHERE STAFF_NO = 1;

		SELECT
		       SKILL_NAME
		  FROM
		       STAFF_SKILL S
		  JOIN
		       CODE_SKILL C ON (S.SKILL_CODE = C.SKILL_CODE)
		 WHERE
		       STAFF_NO = 1; 


select
S.STAFF_NO,
S.STAFF_NAME,
S.JUMIN_NO,
D.DEPARTMENT_NAME,
CC.SCHOOL_NAME,
S.GRADUATE_DAY
from
staff S
join code_department D on(S.department_code = D.department_code)
join code_school CC on(S.school_code = CC.school_code);

		SELECT
		  	   *
		  FROM
		       VW_STAFF_INFO;
		 WHERE
		       STAFF_NO = 2;

commit;



update
(
select
S.STAFF_NO,
S.STAFF_NAME,
S.JUMIN_NO,
S.DEPARTMENT_CODE,
D.DEPARTMENT_NAME,
S.SCHOOL_CODE,
CC.SCHOOL_NAME,
S.GRADUATE_DAY
from
staff S
join code_department D on(S.department_code = D.department_code)
join code_school CC on(S.school_code = CC.school_code)
)

set 
STAFF_NAME = '일길동',
JUMIN_NO = '123456-1234567',
DEPARTMENT_CODE = (select department_code from code_department where department_name = 'ICT사업부'),
SCHOOL_CODE = (select school_code from code_school where school_name = '일반대졸'),
GRADUATE_DAY = '2021/02'
where STAFF_NO = 1;

commit;




create or replace view VW_STAFF_UPDATE
as
select
S.STAFF_NO,
S.STAFF_NAME,
S.JUMIN_NO,
S.DEPARTMENT_CODE,
S.SCHOOL_CODE,
S.GRADUATE_DAY
from
staff S
join code_department D on(S.department_code = D.department_code)
join code_school CC on(S.school_code = CC.school_code);



UPDATE 
(
select
S.STAFF_NO,
S.STAFF_NAME,
S.JUMIN_NO,
S.DEPARTMENT_CODE,
S.SCHOOL_CODE,
S.GRADUATE_DAY
from
staff S
join code_department D on(S.department_code = D.department_code)
join code_school CC on(S.school_code = CC.school_code)
)
set 
STAFF_NAME = '길동아',
JUMIN_NO = '123456-1234567',
DEPARTMENT_CODE = (select department_code from code_department where department_name = 'ICT사업부'),
SCHOOL_CODE = (select school_code from code_school where school_name = '일반대졸'),
GRADUATE_DAY = '2021/02'
where STAFF_NO = 1;


alter table staff add foreign key (department_code) references code_department(department_code) on delete cascade;

delete cascade from staff where staff_no = 1;



MERGE 
 INTO code_skill
USING dual
   ON (skill_name = 'CSS')
 WHEN NOT MATCHED THEN
      INSERT 
      VALUES(code_skill_seq.nextval, 'CSS');




replace and create view VW_STAFF_INFO
as
		select
				S.STAFF_NO,
				S.STAFF_NAME,
				S.JUMIN_NO,
				D.DEPARTMENT_NAME,
				CC.SCHOOL_NAME,
				CS.SKILL_NAME,
				S.GRADUATE_DAY
		from
				staff S
		join code_department D on(S.department_code = D.department_code)
		join staff_skill SS on(S.staff_no = SS.staff_no)
		join code_skill CS on(SS.skill_code = CS.skill_code)
		join code_school CC on(S.school_code = CC.school_code)
	




