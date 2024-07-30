-- 21_��������.sql

/*
    # ��������
    
        - �������� �پ��� ���Ἲ�� �����ϱ� ���� �����
        
    # ���Ἲ
    
        - �����Ͱ� ������ ���� ��
        - �����ͺ��̽��� �����͸� ���� ���� ���·� �ùٸ��� �����ϴ� ���� ��ǥ�� �Ѵ�.
        
    # ��ü ���Ἲ
    
        - ���̺��� ������ �� �ݵ�� �ϳ��� ���� ������ �� �־�� �Ѵ�.
        - ��ü ���Ἲ�� ��Ű�� ���� ������������ �⺻Ű(PK)�� ����Ѵ�.
    
    # ���� ���Ἲ
    
        - ���� ���� ���迡 �ִ� �����ʹ� ��ȿ�� �����͸� �����ؾ� �Ѵ�.
        - ���� ���Ἲ�� ��Ű�� ���� ������������ �ܷ�Ű(FK)�� ����Ѵ�.
    
    # ������ ���Ἲ
    
        - �ϳ��� �������� �����ϴ� ��ü���� ��� ���� Ÿ���̾�� �Ѵ�.
        - �����ͺ��̽��� ������ ���Ἲ�� ��Ű�� ���� �÷� Ÿ���� ����Ѵ�.
        
    # ������ ���Ἲ
    
        - �����Ͱ� ��Ȯ��, �ϰ���, ��ȿ���� �����ϴ� ��
        - CHECK, NOT NULL ���� ���������� ����� ������ ���Ἲ�� ������ �� �ִ�.
        
    # ������ �����ͺ��̽��� ���� ���ǵ�
    
        - UNIQUE : �ش� �����ο� �ߺ��Ǵ� ���� ������� �ʴ´�.(null�� ���)
        - NOT NULL : �ش� �����ο� null�� ������� �ʴ´�.
        - PRIMARY KEY : NOT NULL + UNIQUE, �� ���̺� �� �ϳ��� ���� ����
        - FOREIGN KEY : �ٸ� PRIMARY KEY �÷� �Ǵ� UNIQUE �÷��� �����ϴ� ���� �߰��� �� �ִ�.
        - CHECK : ���ϴ� ������ ���� �����Ͽ� �ش� ������ �����ϴ� ��쿡�� ������ �߰�
*/

SELECT * FROM employees;

-- ���� ������ ���������� �� �� �ִ� ������ ��ųʸ� ��
SELECT * FROM user_constraints;

/*
    # CONSTRAINT_TYPE
    
        P : Primary Key
        R : References (Foreign Key)
        U : Unique
        C : Check(or Not Null)
*/

-- �ٸ� ������ ��ųʸ� ���...
SELECT * FROM user_tables;
SELECT * FROM all_tables;
SELECT * FROM all_users;

/*
    # ������ ��ųʸ�(Data Dictionary)
        
        - ������ ����
        - DB�� ���� �˾Ƽ� �����Ǵ� �����Ϳ� ���� �����͵�
        - DB ����ڴ� ������ ��ųʸ��� ���� ������ �� ����.
        
    # ������ ��ųʸ� ��
    
        - ������ ��ųʸ��� DB ����ڰ� Ȯ���� �� �ְԲ� �������ִ� ��(View)
        - �տ� user_�� ���� ������ ��ųʸ� ��� ���� ������ ���� �ǹ��Ѵ�.
        - �տ� all_�� ���� ������ ��ųʸ� ��� ��� ������ ���� �ǹ��Ѵ�.
*/

/*
    1. ���̺� ������ ���ÿ� �������� �����ϱ�
    
        (1) �÷��� �÷�Ÿ�� ��������
            (�� �������� �̸��� �������� �ʾƼ� SYS_�� �����ϴ� �ڵ� �̸��� �����ȴ�)
        (2) �÷��� �÷�Ÿ�� CONSTRAINT �������Ǹ� ��������
            (�� �������� �̸��� �����ؾ� �� �߸��ߴ��� ���� �ľ��� �� �ִ�.)
        
*/

CREATE TABLE fruits3 (
    f_id NUMBER(4) PRIMARY KEY, -- �� �÷��� �⺻Ű�� �����Ѵ�.
    f_name VARCHAR2(20) NOT NULL
);

-- ���̺��_�÷���_�������� �������� �������� �̸��� �޾Ƶθ� �߸��� �˾�ä�� ����.
CREATE TABLE fruits3 (
    f_id NUMBER(4) 
        CONSTRAINT fruits3_fid_pk PRIMARY KEY,
    f_name VARCHAR2(20) 
        CONSTRAINT fruits3_fname_uk UNIQUE 
        CONSTRAINT fruits3_fname_nn NOT NULL,
    price NUMBER(5)
        CONSTRAINT fruits3_price_chk CHECK(price >= 0)
);

SELECT * FROM tabs;
SELECT * FROM user_constraints WHERE table_name = 'EMPLOYEES';
SELECT * FROM user_constraints WHERE table_name = 'FRUITS3';

INSERT INTO fruits3 VALUES(1, 'Apple', 1500);
INSERT INTO fruits3 VALUES(2, 'Banana', 2000);
INSERT INTO fruits3 VALUES(1, 'Watermelon', 3000);
INSERT INTO fruits3 VALUES(3, 'û�ۻ��', 3000);
INSERT INTO fruits3 VALUES(4, 'Kiwi', -2000);
INSERT INTO fruits3 VALUES(4, 'Kiwi', null);

SELECT * FROM fruits3;
DROP TABLE fruits3;
PURGE recyclebin;

/*
    2. ���̺� ���� �� �������� �߰��ϱ�(���̺� �����ϱ�)
    
        - ALTER TABLE ���̺�� ADD CONSTRAINT �������Ǹ� ��������(�÷���);
        - ALTER TABLE ���̺�� MODIFY (���̺� ������ ������ ����);
*/

CREATE TABLE fruits4 (
    f_id NUMBER(4),
    f_name VARCHAR2(20)
);

ALTER TABLE fruits4 ADD CONSTRAINT f4_fid_pk PRIMARY KEY(f_id);

ALTER TABLE fruits4 MODIFY(
    f_name VARCHAR2(35)
        CONSTRAINT f4_fname_uk UNIQUE
        CONSTRAINT f4_fname_nn NOT NULL
);

SELECT * FROM user_constraints WHERE table_name = 'FRUITS4';

/*
    3. �������� �����ϱ�
    
        (1) ���̺��� �����ϸ� �����ִ� �������ǵ鵵 �Բ� �����ȴ�.
        (2) ALTER TABLE ���̺�� DROP CONSTRAINT �������Ǹ�;
            (�� �ڵ� ������ �̸� SYS_�� ���� �������Ǹ��� ������ �� ����������.)
*/

ALTER TABLE fruits4 DROP CONSTRAINT f4_fid_pk;

-- �⺻Ű ���������� �����ؼ� f_id�� �ߺ����� ���� �� �ְ� �Ǿ���.
INSERT INTO fruits4 VALUES(1, 'Orange');
INSERT INTO fruits4 VALUES(1, 'Kiwi');

SELECT * FROM fruits4;

/*
    4. ���̺� �������� �������� �߰��ϱ�
    
        - �÷��� ��� ������ �Ŀ� ���̺� ������ ���ο��� ���������� �ļ��ϴ� ���
        - DEFAULT, NOT NULL�� ���̺� �������� ������ �� ����, �ϴ���� �÷� �������� �����ؾ� �Ѵ�.
*/

CREATE TABLE coffee(
    coffee_id NUMBER(4),
    coffee_name VARCHAR2(30)
        CONSTRAINT coffee_name_nn NOT NULL,
    coffee_price NUMBER(6) DEFAULT 0,
    CONSTRAINT coffee_cid_pk PRIMARY KEY(coffee_id),
    CONSTRAINT coffee_price_chk CHECK(coffee_price >= 0),
    CONSTRAINT coffee_name_uk UNIQUE(coffee_name)
);

SELECT * FROM user_constraints WHERE table_name = 'COFFEE';

/*
    # �ܷ�Ű �߰��ϱ�
    
        - �ܷ�Ű ���������� �ٸ� �������ǵ�� �ٸ��� �����Ϸ��� �ٸ� �÷��� �̸� �����ؾ� �Ѵ�.
        - �����Ϸ��� �ٸ� �÷�(�θ�Ű)�� UNIQUE �Ǵ� PRIMARY KEY ���������� �ɷ��־�� �Ѵ�.
        - �ܷ�Ű�� ������ �÷����� �θ�Ű�� �����ϴ� �� �Ǵ� null�� ����Ѵ�.
*/

SELECT * FROM employees;
SELECT * FROM departments;

-- 1. �÷� �������� �ܷ�Ű �����ϱ�
--    CONSTRAINT �������Ǹ� REFERENCES �θ����̺��(�θ��÷���)
CREATE TABLE coffee2(
    c_id NUMBER(4) CONSTRAINT c2_cid_pk PRIMARY KEY,
    c_name VARCHAR2(20),
    country_id CHAR(2) CONSTRAINT c2_country_id_fk REFERENCES countries(country_id)
);

-- �ܷ�Ű ���� ������ ������Ű�� ����
INSERT INTO coffee2 VALUES(1, 'Americano', 'KR');
INSERT INTO coffee2 VALUES(1, 'Americano', 'MX');

SELECT * FROM countries;
SELECT * FROM coffee2;
SELECT * FROM coffee2 INNER JOIN countries USING(country_id);

-- 2. ���̺� ���� �� �ܷ�Ű ���߿� �߰��ϱ�
CREATE TABLE coffee3 (
    coffee_id NUMBER(4),
    coffee_name VARCHAR2(20),
    country_id CHAR(2)
);

-- ALTER TABLE ���̺�� ADD CONSTRAINT �������Ǹ� FOREIGN KEY(�ڽ�Ű�̸�) REFERENCES �θ����̺�(�θ��÷�)
ALTER TABLE coffee3 ADD CONSTRAINT c3_country_id_fk FOREIGN KEY(country_id) REFERENCES countries(country_id);

INSERT INTO coffee3 VALUES(null, null, 'KR');
INSERT INTO coffee3 VALUES(null, null, 'EN');
INSERT INTO coffee3 VALUES(null, null, 'JP');

SELECT * FROM coffee3;

-- 3. ���̺� �������� �ܷ�Ű �߰��ϱ�
CREATE TABLE coffee4 (
    coffee_id NUMBER(4),
    coffee_name VARCHAR2(20),
    employee_id NUMBER(6),
    CONSTRAINT c4_coffee_id_pk PRIMARY KEY(coffee_id),
    CONSTRAINT c4_employee_id_fk FOREIGN KEY(employee_id) REFERENCES employees(emplyee_id)
);

SELECT * FROM user_constraints WHERE lower(table_name) = 'coffee4';

INSERT INTO coffee4 VALUES(1, '��', 100);
INSERT INTO coffee4 VALUES(2, '��ī', 100);

SELECT * FROM coffee4 INNER JOIN employees USING(employee_id);

-- 1. 1:N ������ ���̺��� 2�� ����(�������� ����)
CREATE TABLE companies (
    company_name VARCHAR2(10) CONSTRAINT company_name_nn NOT NULL,
    owner_name VARCHAR2(30) CONSTRAINT owner_name_nn NOT NULL,
    country_id CHAR(2) CONSTRAINT country_id_fk REFERENCES countries(country_id)
);

CREATE TABLE smartphones (
    model_id VARCHAR2(10) CONSTRAINT model_id_pk PRIMARY KEY,
    company_name VARCHAR2(10) CONSTRAINT company_name_nn NOT NULL,
    model_name VARCHAR2(10) CONSTRAINT model_name_nn NOT NULL
);

-- 2. INSERT�� ���� ������ �߰�
INSERT INTO companies(company_name, owner_name, country_id) VALUES('Apple', '�� ��', 'US');
INSERT INTO companies(company_name, owner_name, country_id) VALUES('HUAWEI', '��������', 'CN');
INSERT INTO companies(company_name, owner_name, country_id) VALUES('SONY', '��ô� ����ġ��', 'JP');

-- 3. ������ JOIN�Ͽ� ��ȸ�غ���