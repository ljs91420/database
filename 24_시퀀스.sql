-- 24_������.sql

/*
    # ������
    
        - �⺻Ű �÷��� ������ ����� �� �ִ� ���ڸ� ������� �������ִ� DB������Ʈ
        - ���� �ߺ����� �ʴ� ���� ã�� �ʿ� ���� �������� ����ϸ� ���ϴ�.
        - �������� user_sequences, all_sequences ������ ��ųʸ� ��� Ȯ���� �� �ִ�.
        
          CREATE SEQUENCE ��������
                            [START WITH n] - �������� ���� ��ȣ ����
                            [INCREMENT BY n] - �������� ��ȣ ������ ����
                            [NOMAXVALUE | MAXVALUE n] - �������� �ִ밪 ����
                            [NOMINVALUE | MINVALUE n] - �������� �ּҰ� ����
                            [NOCYCLE | CYCLE] - ��ȣ ��ȯ ���� ����
                            [NOCACHE | CACHE n]; - ��ȣ�� �̸� �������� ���� ����
*/

SELECT * FROM animals;
SELECT MAX(animal_id) FROM animals;

-- ������ ����
CREATE SEQUENCE animals_seq START WITH 4 INCREMENT BY 1;

-- ������.nextval : ���� ��ȣ�� ����Ѵ�.(�ٽô� ���� ��ȣ�� ���ư� �� ����)
SELECT animals_seq.nextval FROM dual; -- DUAL : ���� �� �� �� ����ִ� �׽�Ʈ�� ���̺�
SELECT 123 + 123 FROM dual;
SELECT '2' + '4' FROM dual;

-- ������.currval : ���� ���� Ȯ���� �� �ִ�.(nextval�� �ּ� �� ���� ȣ���ؾ� ���簪�� Ȯ���� �� �ִ�.)
SELECT animals_seq.currval FROM dual;

-- ������ Ȯ�ο� ������ ��ųʸ� ��
SELECT * FROM user_sequences;

-- INSERT�� �������� Ȱ���Ͽ� �⺻Ű�� �ߺ��Ǵ� ���� ���� �ʵ��� �� �� �ִ�.
INSERT INTO animals(animal_id, animal_name, animal_age) VALUES(animals_seq.nextval, '������', 2);

SELECT * FROM animals ORDER BY animal_id;

-- 0���� �����ؼ� 2�� �����ϸ鼭 ��ȯ�ϴ� ������ (�ּҰ� -10, �ִ밪 10)
CREATE SEQUENCE myseq1 START WITH 0 INCREMENT BY 2 
    MINVALUE -10 MAXVALUE 10 CYCLE NOCACHE;
    
-- INCREMENT BY 2 : 2�� �����Ѵ�.
-- CYCLE : �ִ밪�� �����ϰ� �Ǹ� �ּҰ����� ��ȯ�Ѵ�.
-- NOCACHE : ���ڸ� �̸� �����ص��� �ʴ´�.(nextval�� ȣ���� ������ ���� ���ڸ� ã�´�.)
SELECT myseq1.nextval FROM dual;

-- # ������ �����ϱ� : ALTER SEQUENCE (���� ������ CREATE�� ����)
ALTER SEQUENCE myseq1 INCREMENT BY 3 MINVALUE 0 MAXVALUE 90;
SELECT myseq1.nextval FROM dual;

-- # ������ �����ϱ� : DROP SEQUENCE ��������
DROP SEQUENCE myseq1;