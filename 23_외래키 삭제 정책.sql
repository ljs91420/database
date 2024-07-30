-- 23_외래키 삭제 정책.sql

/*
    # ON DELETE
    
        - 기본적으로는 부모 행(레코드)를 참조하고 있는 자식 행(레코드)가 있을 때는 부모 레코드를 삭제할 수 없다.
        - ON DELETE를 통해 삭제 옵션을 설정하면 부모 레코드를 삭제했을 때의 동작을 설정해둘 수 있다.
        - ON DELETE CASCADE : 부모 레코드를 삭제하면 자식 레코드까지 모두 삭제해버린다.
        - ON DELETE SET NULL : 부모 레코드를 삭제하면 해당 자식 레코드값을 null로 바꾼다.
*/

SELECT * FROM animals;
SELECT * FROM countries2;

INSERT INTO animals VALUES(1, '고양이', 3, 'AR');
INSERT INTO animals VALUES(2, '호랑이', 4, 'AR');
INSERT INTO animals VALUES(3, '강아지', 5, 'AR');
COMMIT;

-- 자식 레코드가 없는 레코드는 잘 지워지지만 
DELETE FROM countries2 WHERE nation_id = 'BE';
ROLLBACK;

-- 자식 레코드가 존재하는 레코드는 지울 수 없게 설정되어 있다.
DELETE FROM countries2 WHERE nation_id = 'AR';

-- 외래키 제약 조건을 변경하기(CASCADE)
ALTER TABLE animals DROP CONSTRAINT animals_country_id_fk;
ALTER TABLE animals ADD CONSTRAINT animals_nation_id_fk FOREIGN KEY(nation_id) REFERENCES countries2(nation_id) ON DELETE CASCADE;

-- 부모키를 삭제하면서 해당 키에 딸린 자식 레코드들까지 삭제해버린다.
DELETE FROM countries2 WHERE nation_id = 'AR';
SELECT * FROM animals;
ROLLBACK;

-- 외래키 제약 조건을 변경하기(SET NULL)
ALTER TABLE animals DROP CONSTRAINT animals_country_id_fk;
ALTER TABLE animals ADD CONSTRAINT animals_nation_id_fk FOREIGN KEY(nation_id) REFERENCES countries2(nation_id) ON DELETE SET NULL;

DELETE FROM countries2 WHERE nation_id = 'AR';
SELECT * FROM animals;
ROLLBACK;