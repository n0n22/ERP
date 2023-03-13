DROP TABLE code_skill CASCADE CONSTRAINTS;
DROP TABLE code_department CASCADE CONSTRAINTS;
DROP TABLE code_school CASCADE CONSTRAINTS;
DROP TABLE staff CASCADE CONSTRAINTS;
DROP TABLE staff_skill CASCADE CONSTRAINTS;


CREATE TABLE code_skill (
	skill_code	number(3)	primary key,
	skill_name	varchar2(20)	NOT NULL unique
);

CREATE TABLE code_department (
	department_code	number(3)	primary key,
	department_name	varchar2(30)	NOT NULL unique
);


CREATE TABLE code_school (
	school_code	number(3)	primary key,
	school_name	varchar2(20)		NOT NULL unique
);



CREATE TABLE staff (
	staff_no	number(3)	primary key,
	staff_name	varchar2(20)	NOT NULL,
	jumin_no	char(14)		    NOT NULL unique,
	school_code	number(3)		NOT NULL references code_school(school_code) on delete cascade,
	department_code	number(3)	NOT NULL references code_department(department_code) on delete cascade,
	graduate_day	char(10)	NOT NULL
);


CREATE TABLE staff_skill (
	staff_skill_no	number(3)	primary key,
	staff_no  	number(3)		NOT NULL references staff(staff_no) on delete cascade,
	skill_code	number(3)		NOT NULL references code_skill(skill_code) on delete cascade
);



DROP SEQUENCE CODE_SKILL_SEQ;
DROP SEQUENCE CODE_DEPARTMENT_SEQ;
DROP SEQUENCE CODE_SCHOOL_SEQ;
DROP SEQUENCE STAFF_SEQ;
DROP SEQUENCE STAFF_SKILL_SEQ;

CREATE SEQUENCE CODE_SKILL_SEQ;
CREATE SEQUENCE CODE_DEPARTMENT_SEQ;
CREATE SEQUENCE CODE_SCHOOL_SEQ;
CREATE SEQUENCE STAFF_SEQ;
CREATE SEQUENCE STAFF_SKILL_SEQ;


commit;


INSERT INTO CODE_SKILL VALUES(CODE_SKILL_SEQ.NEXTVAL, 'Java');
INSERT INTO CODE_SKILL VALUES(CODE_SKILL_SEQ.NEXTVAL, 'JSP');
INSERT INTO CODE_SKILL VALUES(CODE_SKILL_SEQ.NEXTVAL, 'ASP');
INSERT INTO CODE_SKILL VALUES(CODE_SKILL_SEQ.NEXTVAL, 'PHP');
INSERT INTO CODE_SKILL VALUES(CODE_SKILL_SEQ.NEXTVAL, 'Delphi');

commit;

INSERT INTO CODE_DEPARTMENT VALUES(CODE_DEPARTMENT_SEQ.NEXTVAL, 'ICT사업부');
INSERT INTO CODE_DEPARTMENT VALUES(CODE_DEPARTMENT_SEQ.NEXTVAL, '디지털트윈사업부');
INSERT INTO CODE_DEPARTMENT VALUES(CODE_DEPARTMENT_SEQ.NEXTVAL, 'SI사업부');
INSERT INTO CODE_DEPARTMENT VALUES(CODE_DEPARTMENT_SEQ.NEXTVAL, '반도체사업부');
INSERT INTO CODE_DEPARTMENT VALUES(CODE_DEPARTMENT_SEQ.NEXTVAL, '기업부설연구소');
INSERT INTO CODE_DEPARTMENT VALUES(CODE_DEPARTMENT_SEQ.NEXTVAL, '전략기획팀');
INSERT INTO CODE_DEPARTMENT VALUES(CODE_DEPARTMENT_SEQ.NEXTVAL, '경영지원팀');

commit;

INSERT INTO CODE_SCHOOL VALUES(CODE_SCHOOL_SEQ.NEXTVAL, '고졸');
INSERT INTO CODE_SCHOOL VALUES(CODE_SCHOOL_SEQ.NEXTVAL, '전문대졸');
INSERT INTO CODE_SCHOOL VALUES(CODE_SCHOOL_SEQ.NEXTVAL, '일반대졸');

commit;

