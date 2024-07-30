CREATE TABLE members (
    login_id VARCHAR2(10) PRIMARY KEY,
    email VARCHAR2(20),
    pw VARCHAR2(20),
    register_date DATE,
    member_state VARCHAR2(10),
    agreement VARCHAR2(10),
    sns_login VARCHAR2(30),
    access_date DATE,
    update_pw_date DATE
);

DROP TABLE members;

SELECT * FROM tabs;

SELECT * FROM departments;