


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
-- �̸� ����
--------------------------------------------------------------------------------
SELECT S.STAFF_NO, STAFF_NAME, DECODE(substr(jumin_no, 8, 1), '1', '��',  '2', '��', '3', '��', '4', '��') as "JUMIN_NO", DEPARTMENT_NAME, GRADUATE_DAY
FROM STAFF S
JOIN CODE_DEPARTMENT D ON (S.DEPARTMENT_CODE = D.DEPARTMENT_CODE)
WHERE STAFF_NAME LIKE '%' || '��' || '%'
;

--------------------------------------------------------------------------------
-- ���� ����
--------------------------------------------------------------------------------
SELECT S.STAFF_NO, STAFF_NAME, DECODE(substr(jumin_no, 8, 1), '1', '��',  '2', '��', '3', '��', '4', '��') as "JUMIN_NO", DEPARTMENT_NAME, GRADUATE_DAY
FROM STAFF S
JOIN CODE_DEPARTMENT D ON (S.DEPARTMENT_CODE = D.DEPARTMENT_CODE)
WHERE SUBSTR(JUMIN_NO, 8, 1) IN (1, 3);



--------------------------------------------------------------------------------
-- �μ� ����
--------------------------------------------------------------------------------
SELECT S.STAFF_NO, STAFF_NAME, DECODE(substr(jumin_no, 8, 1), '1', '��',  '2', '��', '3', '��', '4', '��') as "JUMIN_NO", DEPARTMENT_NAME, GRADUATE_DAY
FROM STAFF S
JOIN CODE_DEPARTMENT D ON (S.DEPARTMENT_CODE = D.DEPARTMENT_CODE)
WHERE S.DEPARTMENT_CODE IN (SELECT DEPARTMENT_CODE FROM CODE_DEPARTMENT WHERE DEPARTMENT_NAME = '�ݵ�ü�����');


--------------------------------------------------------------------------------
-- �з� ����
--------------------------------------------------------------------------------
SELECT S.STAFF_NO, STAFF_NAME, DECODE(substr(jumin_no, 8, 1), '1', '��',  '2', '��', '3', '��', '4', '��') as "JUMIN_NO", DEPARTMENT_NAME, GRADUATE_DAY
FROM STAFF S
JOIN CODE_DEPARTMENT D ON (S.DEPARTMENT_CODE = D.DEPARTMENT_CODE)
JOIN CODE_SCHOOL C ON (S.SCHOOL_CODE = C.SCHOOL_CODE)
WHERE S.SCHOOL_CODE IN (SELECT SCHOOL_CODE FROM CODE_SCHOOL WHERE SCHOOL_NAME IN ('����', '��������', '�Ϲݴ���'));


--------------------------------------------------------------------------------
-- ��� ����
--------------------------------------------------------------------------------
SELECT S.STAFF_NO, STAFF_NAME, DECODE(substr(jumin_no, 8, 1), '1', '��',  '2', '��', '3', '��', '4', '��') as "JUMIN_NO", DEPARTMENT_NAME, GRADUATE_DAY
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
-- ������ ����
--------------------------------------------------------------------------------
SELECT S.STAFF_NO, STAFF_NAME, DECODE(substr(jumin_no, 8, 1), '1', '��',  '2', '��', '3', '��', '4', '��') as "JUMIN_NO", DEPARTMENT_NAME, GRADUATE_DAY
FROM STAFF S
JOIN CODE_DEPARTMENT D ON (S.DEPARTMENT_CODE = D.DEPARTMENT_CODE)
JOIN CODE_SCHOOL C ON (S.SCHOOL_CODE = C.SCHOOL_CODE)
WHERE GRADUATE_DAY BETWEEN '195502' AND '199908';










