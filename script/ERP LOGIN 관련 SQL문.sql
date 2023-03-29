CREATE TABLE NAVER_LOGIN_USER (
    
    USER_NO NUMBER PRIMARY KEY,
    NAME VARCHAR2(20),
    BIRTHDAY CHAR(5),
    GENDER CHAR(1),
    MOBILE CHAR(13)

);


create sequence naver_user_seq;

drop table naver_login_user;
drop sequence naver_user_seq;

commit;



CREATE TABLE MEMBER (
    MEM_NO NUMBER PRIMARY KEY,
    MEM_EMAIL VARCHAR2(30),
    MEM_PW VARCHAR2(15),
    MEM_NAME VARCHAR2(20),
    MEM_MOBILE CHAR(13)
);

drop SEQUENCE user_seq;
drop table member;
