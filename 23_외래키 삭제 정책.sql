-- 23_�ܷ�Ű ���� ��å.sql

/*
    # ON DELETE
    
        - �⺻�����δ� �θ� ��(���ڵ�)�� �����ϰ� �ִ� �ڽ� ��(���ڵ�)�� ���� ���� �θ� ���ڵ带 ������ �� ����.
        - ON DELETE�� ���� ���� �ɼ��� �����ϸ� �θ� ���ڵ带 �������� ���� ������ �����ص� �� �ִ�.
        - ON DELETE CASCADE : �θ� ���ڵ带 �����ϸ� �ڽ� ���ڵ���� ��� �����ع�����.
        - ON DELETE SET NULL : �θ� ���ڵ带 �����ϸ� �ش� �ڽ� ���ڵ尪�� null�� �ٲ۴�.
*/

SELECT * FROM animals;
SELECT * FROM countries2;

INSERT INTO animals VALUES(1, '�����', 3, 'AR');
INSERT INTO animals VALUES(2, 'ȣ����', 4, 'AR');
INSERT INTO animals VALUES(3, '������', 5, 'AR');
COMMIT;

-- �ڽ� ���ڵ尡 ���� ���ڵ�� �� ���������� 
DELETE FROM countries2 WHERE nation_id = 'BE';
ROLLBACK;

-- �ڽ� ���ڵ尡 �����ϴ� ���ڵ�� ���� �� ���� �����Ǿ� �ִ�.
DELETE FROM countries2 WHERE nation_id = 'AR';

-- �ܷ�Ű ���� ������ �����ϱ�(CASCADE)
ALTER TABLE animals DROP CONSTRAINT animals_country_id_fk;
ALTER TABLE animals ADD CONSTRAINT animals_nation_id_fk FOREIGN KEY(nation_id) REFERENCES countries2(nation_id) ON DELETE CASCADE;

-- �θ�Ű�� �����ϸ鼭 �ش� Ű�� ���� �ڽ� ���ڵ����� �����ع�����.
DELETE FROM countries2 WHERE nation_id = 'AR';
SELECT * FROM animals;
ROLLBACK;

-- �ܷ�Ű ���� ������ �����ϱ�(SET NULL)
ALTER TABLE animals DROP CONSTRAINT animals_country_id_fk;
ALTER TABLE animals ADD CONSTRAINT animals_nation_id_fk FOREIGN KEY(nation_id) REFERENCES countries2(nation_id) ON DELETE SET NULL;

DELETE FROM countries2 WHERE nation_id = 'AR';
SELECT * FROM animals;
ROLLBACK;