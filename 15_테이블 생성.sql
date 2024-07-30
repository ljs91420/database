-- 15_���̺� ����.sql

/*
    # CRUD
    
        - ��κ��� ���α׷����� ������ �ִ� ������ ó������ �ٿ� ǥ���� ��
        - Create (������ ����)
        - Read   (������ �б�)
        - Update (������ ����)
        - Delete (������ ����)
        
    # DML (Data Manipulate Language, ������ ���۾�)
    
        - ���̺� ����ִ� �����͸� ������ �� �ִ� ��������
        - INSERT : ���̺� �����͸� �߰��ϴ� ��ɾ�(C)
        - SELECT : ���̺��� �����͸� �д� ��ɾ�(R)
        - UPDATE : ���̺��� �����͸� �����ϴ� ��ɾ�(U)
        - DELETE : ���̺��� �����͸� �����ϴ� ��ɾ�(D)
    
    # DDL (Data Definition Language, ������ ���Ǿ�)
    
        - DB�� ������Ʈ�� �����ϴ� ��ɾ��
        - ���̺�, ������, ��, �ε��� ���� DB ������Ʈ�� �ش��Ѵ�.
        - CREATE : DB ������Ʈ�� ������ �� ����ϴ� ��ɾ�(C)
        - ALTER : �̹� �����ϴ� DB ������Ʈ�� ������ �� ����ϴ� ��ɾ�(U)
        - DROP : �̹� �����ϴ� DB ������Ʈ�� ������ �� ����ϴ� ��ɾ�(D)
                 (�����뿡�� ���� ����)
        - TRUNCATE : DB ������Ʈ ���� ����(���� �Ұ���)
        - SELECT : DB ������Ʈ�� Ȯ���� ���� SELECT���� ����Ѵ�.(R)
                   (e.g. SELECT * FROM tabs)
    
    # DCL (Data Control Language, ������ ���� ��ɾ�)
    
        - DB ����ڿ��� �پ��� ������ �ο��ϰų� ��Ż�� �� �ִ� ��ɾ�
        - GRANT : ���� �ο�
        - REVOKE : ���� ȸ��
*/

SELECT * FROM tab;
SELECT * FROM tabs;

/*
    # ���̺� �����ϱ�
    
    CREATE TABLE ���̺�� (
        �÷��� �÷�Ÿ��,
        �÷��� �÷�Ÿ��,
        ...
    );
*/

CREATE TABLE fruits (
    fruit_name VARCHAR2(20),
    price NUMBER(7)
);

SELECT * FROM fruits;
DESC fruits;

-- # ���̺� ���� : DROP TABLE ���̺��;
DROP TABLE fruits;

-- DROP���� ������ DB ������Ʈ�� �����뿡�� Ȯ���� �� �ְ� ������ �����ϴ�.
SHOW recyclebin;

-- �����뿡 ����ִ� DB ������Ʈ �����ϱ�
FLASHBACK TABLE fruits TO BEFORE DROP;

SELECT * FROM fruits;
DESC fruits;

-- ������ ����(���� ���� �����)
PURGE recyclebin;

-- # ���� ���̺��� �����Ͽ� �� ���̺� �����(���뵵 �Բ� ����)
CREATE TABLE employees2 AS (SELECT * FROM employees);
SELECT * FROM employees2;

-- # ���� ���̺��� ������ �����Ͽ� �� ���̺� �����
CREATE TABLE employees3 AS (SELECT * FROM employees WHERE 1 = 0);
SELECT * FROM employees3;

DROP TABLE employees2;
DROP TABLE employees3;

SHOW recyclebin;

FLASHBACK TABLE employees2 TO BEFORE DROP;
SELECT * FROM employees2;

PURGE recyclebin;

-- ���� : ���� �����ߴ� 1:N ������ ���̺���� ���� �����غ�����.
CREATE TABLE pets (
    animal_registration_number NUMBER(15),
    pet_name VARCHAR2(20),
    weight NUMBER(3,1), 
    sex VARCHAR2(6), 
    breed VARCHAR2(20),
    owner_name VARCHAR2(20),
    phone_number VARCHAR2(20),
    hair_color VARCHAR2(10), 
    birth_date DATE, 
    neutrification VARCHAR2(10), 
    address VARCHAR2(100)
);

DESC pets;
SELECT * FROM pets;

DROP TABLE pets;

PURGE recyclebin;