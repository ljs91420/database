-- 22_테이블 수정하기.sql

/*
    # 테이블에 새 컬럼 추가하기
    
        - ALTER TABLE 테이블명 ADD (컬럼명1 컬럼타입1, ...);
        - 새 컬럼을 추가하면 이미 존재하던 행들은 해당 컬럼값이 기본값(없으면 null)으로 설정된다.
*/

CREATE TABLE animals (
    animal_id NUMBER(4),
    animal_name VARCHAR2(21)
);

INSERT INTO animals VALUES(1, '너구리');
INSERT INTO animals VALUES(2, '복실이');
INSERT INTO animals VALUES(3, '덕구');

SELECT * FROM animals;

ALTER TABLE animals ADD (
    age NUMBER(4),
    gender CHAR(1)
);

ALTER TABLE animals ADD (
    animal_class VARCHAR2(20) default 'dog'
);

/*
    # 테이블의 컬럼 삭제하기
        
        - ALTER TABLE 테이블명 DROP COLUMN 컬럼명;
*/

SELECT * FROM animals;
SELECT * FROM tabs;

ALTER TABLE animals DROP COLUMN gender;
ALTER TABLE animals DROP COLUMN animal_class;

CREATE TABLE countries2 AS (SELECT * FROM countries);

-- 연습 : animals에 countries2 테이블과 연결된 외래키 컬럼 country_id를 추가해보세요.
SELECT * FROM animals;

-- 외래키가 참조하려는 컬럼은 기본키 또는 유니크여야 한다.
ALTER TABLE countries2 ADD CONSTRAINT countries2_country_id_pk PRIMARY KEY(country_id);

ALTER TABLE animals ADD (country_id CHAR(2) CONSTRAINT animals_country_id_fk REFERENCES countries2(country_id));

SELECT * FROM user_constraints WHERE table_name = 'ANIMALS';

INSERT INTO animals VALUES(4, '원숭이', 3, 'JP');
INSERT INTO animals VALUES(5, '코뿔소', 6, 'KR');

SELECT * FROM animals;
SELECT * FROM countries2;

-- 부모키 역할을 하고 있는 컬럼을 삭제할 때는 문제가 발생할 수 있으므로 주의해야 한다.
ALTER TABLE countries2 DROP COLUMN country_id;

/*
    # 테이블의 컬럼 이름 변경하기
    
        - ALTER TABLE 테이블명 RENAME COLUMN 현재이름 TO 바꿀이름;
*/

SELECT * FROM animals;
ALTER TABLE animals RENAME COLUMN age TO animal_age;
ALTER TABLE animals RENAME COLUMN country_id TO nation_id;

SELECT * FROM user_constraints WHERE lower(table_name) = 'animals';

INSERT INTO animals(animal_age, nation_id) VALUES(10, 'EU');
INSERT INTO animals(animal_age, nation_id) VALUES(10, 'CN');

ALTER TABLE countries2 RENAME COLUMN country_id TO nation_id;

/*
    # 테이블의 제약조건 삭제하기
        
        - ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명;
*/

-- 컬럼 이름이 변경되었으므로 제약 조건 이름도 변경해보기
ALTER TABLE animals DROP CONSTRAINT animals_country_id_fk;
ALTER TABLE animals ADD CONSTRAINT animals_nation_id_fk FOREIGN KEY(nation_id) REFERENCES countries2(nation_id);

/*
    # 테이블의 컬럼 수정하기
    
        - ALTER TABLE 테이블명 MODIFY (컬럼1 컬럼타입1 제약조건, ...);
        - 제약조건을 추가할 수도 있었다.
*/

DESC ANIMALS;
ALTER TABLE animals MODIFY (
    animal_age NUMBER(3)
        CONSTRAINT animal_age_must_positive CHECK(animal_age >= 0)
);

DELETE FROM animals;
COMMIT;