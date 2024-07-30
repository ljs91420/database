-- 24_시퀀스.sql

/*
    # 시퀀스
    
        - 기본키 컬럼에 값으로 사용할 수 있는 숫자를 순서대로 생성해주는 DB오브젝트
        - 직접 중복되지 않는 값을 찾을 필요 없이 시퀀스를 사용하면 편리하다.
        - 시퀀스는 user_sequences, all_sequences 데이터 딕셔너리 뷰로 확인할 수 있다.
        
          CREATE SEQUENCE 시퀀스명
                            [START WITH n] - 시퀀스의 시작 번호 설정
                            [INCREMENT BY n] - 시퀀스의 번호 증가값 설정
                            [NOMAXVALUE | MAXVALUE n] - 시퀀스의 최대값 설정
                            [NOMINVALUE | MINVALUE n] - 시퀀스의 최소값 설정
                            [NOCYCLE | CYCLE] - 번호 순환 여부 설정
                            [NOCACHE | CACHE n]; - 번호를 미리 만들어놓을 개수 설정
*/

SELECT * FROM animals;
SELECT MAX(animal_id) FROM animals;

-- 시퀀스 생성
CREATE SEQUENCE animals_seq START WITH 4 INCREMENT BY 1;

-- 시퀀스.nextval : 다음 번호를 사용한다.(다시는 이전 번호로 돌아갈 수 없다)
SELECT animals_seq.nextval FROM dual; -- DUAL : 값이 딱 한 줄 들어있는 테스트용 테이블
SELECT 123 + 123 FROM dual;
SELECT '2' + '4' FROM dual;

-- 시퀀스.currval : 현재 값을 확인할 수 있다.(nextval을 최소 한 번은 호출해야 현재값을 확인할 수 있다.)
SELECT animals_seq.currval FROM dual;

-- 시퀀스 확인용 데이터 딕셔너리 뷰
SELECT * FROM user_sequences;

-- INSERT시 시퀀스를 활용하여 기본키에 중복되는 값이 들어가지 않도록 할 수 있다.
INSERT INTO animals(animal_id, animal_name, animal_age) VALUES(animals_seq.nextval, '독수리', 2);

SELECT * FROM animals ORDER BY animal_id;

-- 0부터 시작해서 2씩 증가하면서 순환하는 시퀀스 (최소값 -10, 최대값 10)
CREATE SEQUENCE myseq1 START WITH 0 INCREMENT BY 2 
    MINVALUE -10 MAXVALUE 10 CYCLE NOCACHE;
    
-- INCREMENT BY 2 : 2씩 증가한다.
-- CYCLE : 최대값에 도달하게 되면 최소값으로 순환한다.
-- NOCACHE : 숫자를 미리 생성해두지 않는다.(nextval을 호출할 때마다 다음 숫자를 찾는다.)
SELECT myseq1.nextval FROM dual;

-- # 시퀀스 수정하기 : ALTER SEQUENCE (이후 문법은 CREATE와 같음)
ALTER SEQUENCE myseq1 INCREMENT BY 3 MINVALUE 0 MAXVALUE 90;
SELECT myseq1.nextval FROM dual;

-- # 시퀀스 삭제하기 : DROP SEQUENCE 시퀀스명
DROP SEQUENCE myseq1;