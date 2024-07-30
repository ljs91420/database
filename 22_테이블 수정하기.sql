-- 22_���̺� �����ϱ�.sql

/*
    # ���̺� �� �÷� �߰��ϱ�
    
        - ALTER TABLE ���̺�� ADD (�÷���1 �÷�Ÿ��1, ...);
        - �� �÷��� �߰��ϸ� �̹� �����ϴ� ����� �ش� �÷����� �⺻��(������ null)���� �����ȴ�.
*/

CREATE TABLE animals (
    animal_id NUMBER(4),
    animal_name VARCHAR2(21)
);

INSERT INTO animals VALUES(1, '�ʱ���');
INSERT INTO animals VALUES(2, '������');
INSERT INTO animals VALUES(3, '����');

SELECT * FROM animals;

ALTER TABLE animals ADD (
    age NUMBER(4),
    gender CHAR(1)
);

ALTER TABLE animals ADD (
    animal_class VARCHAR2(20) default 'dog'
);

/*
    # ���̺��� �÷� �����ϱ�
        
        - ALTER TABLE ���̺�� DROP COLUMN �÷���;
*/

SELECT * FROM animals;
SELECT * FROM tabs;

ALTER TABLE animals DROP COLUMN gender;
ALTER TABLE animals DROP COLUMN animal_class;

CREATE TABLE countries2 AS (SELECT * FROM countries);

-- ���� : animals�� countries2 ���̺�� ����� �ܷ�Ű �÷� country_id�� �߰��غ�����.
SELECT * FROM animals;

-- �ܷ�Ű�� �����Ϸ��� �÷��� �⺻Ű �Ǵ� ����ũ���� �Ѵ�.
ALTER TABLE countries2 ADD CONSTRAINT countries2_country_id_pk PRIMARY KEY(country_id);

ALTER TABLE animals ADD (country_id CHAR(2) CONSTRAINT animals_country_id_fk REFERENCES countries2(country_id));

SELECT * FROM user_constraints WHERE table_name = 'ANIMALS';

INSERT INTO animals VALUES(4, '������', 3, 'JP');
INSERT INTO animals VALUES(5, '�ڻԼ�', 6, 'KR');

SELECT * FROM animals;
SELECT * FROM countries2;

-- �θ�Ű ������ �ϰ� �ִ� �÷��� ������ ���� ������ �߻��� �� �����Ƿ� �����ؾ� �Ѵ�.
ALTER TABLE countries2 DROP COLUMN country_id;

/*
    # ���̺��� �÷� �̸� �����ϱ�
    
        - ALTER TABLE ���̺�� RENAME COLUMN �����̸� TO �ٲ��̸�;
*/

SELECT * FROM animals;
ALTER TABLE animals RENAME COLUMN age TO animal_age;
ALTER TABLE animals RENAME COLUMN country_id TO nation_id;

SELECT * FROM user_constraints WHERE lower(table_name) = 'animals';

INSERT INTO animals(animal_age, nation_id) VALUES(10, 'EU');
INSERT INTO animals(animal_age, nation_id) VALUES(10, 'CN');

ALTER TABLE countries2 RENAME COLUMN country_id TO nation_id;

/*
    # ���̺��� �������� �����ϱ�
        
        - ALTER TABLE ���̺�� DROP CONSTRAINT �������Ǹ�;
*/

-- �÷� �̸��� ����Ǿ����Ƿ� ���� ���� �̸��� �����غ���
ALTER TABLE animals DROP CONSTRAINT animals_country_id_fk;
ALTER TABLE animals ADD CONSTRAINT animals_nation_id_fk FOREIGN KEY(nation_id) REFERENCES countries2(nation_id);

/*
    # ���̺��� �÷� �����ϱ�
    
        - ALTER TABLE ���̺�� MODIFY (�÷�1 �÷�Ÿ��1 ��������, ...);
        - ���������� �߰��� ���� �־���.
*/

DESC ANIMALS;
ALTER TABLE animals MODIFY (
    animal_age NUMBER(3)
        CONSTRAINT animal_age_must_positive CHECK(animal_age >= 0)
);

DELETE FROM animals;
COMMIT;