-- 16_행 추가, 수정, 삭제.sql

/*
    # 테이블에 행 추가하기
    
        - INSERT INTO 테이블명(컬럼1, 컬럼2, ...) VALUES(값1, 값2, ...)
        - INSERT INTO 테이블명 VALUES (존재하는 모든 컬럼 값을 순서대로);
*/

CREATE TABLE fruits(
    fname VARCHAR2(30),
    price NUMBER(6),
    qty NUMBER(7) default 0 -- 컬럼에 default 설정시 기본값이 된다.
);

DROP TABLE fruits;
PURGE recyclebin;

SELECT * FROM fruits;

INSERT INTO fruits(fname, price, qty) VALUES ('사과', 1000, 30);
-- 모든 컬럼을 다 쓰지 않으면 쓰지 않은 컬럼에는 null 값이 추가된다.
-- default가 설정된 컬럼과 함께 많이 활용되는 방식이다.
INSERT INTO fruits(fname, price) VALUES ('수박', 3000);
-- 행 추가시 컬럼의 순서를 마음대로 지정할 수 있다.
INSERT INTO fruits(price, qty, fname) VALUES (2500, 50, '오렌지');

-- 테이블 컬럼명 생략시 모든 값을 순서에 맞춰 적어줘야 행을 추가할 수 있다.
INSERT INTO fruits VALUES('Mango', 2800, 100);

SELECT * FROM fruits WHERE fname BETWEEN 'A' AND 'ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ';
DESC fruits;

-- 서브 쿼리를 활용한 INSERT (테이블 구조가 동일할 시에만 가능)
CREATE TABLE fruits2 AS (SELECT * FROM fruits WHERE 1 != 1);

SELECT * FROM fruits2;

INSERT INTO fruits2(price) VALUES(1000);
INSERT INTO fruits2 (SELECT * FROM fruits); -- 서브 쿼리를 활용해 값 넣기
INSERT INTO fruits2 (SELECT * FROM fruits2); -- 자가 복제

/*
    # 테이블 행 수정하기
    
        - UPDATE 테이블명 SET 컬럼1=값1, 컬럼2=값2, ... WHERE 조건절;
        - 만약 조건을 지정하지 않으면 모든 행이 수정된다. ※ 주의
*/

COMMIT; -- 현재까지의 테이블 변경사항을 확정짓는다.

SELECT * FROM fruits2;
UPDATE fruits2 SET price = 100; -- 조건을 지정하지 않으면 큰일난다.

ROLLBACK; -- 가장 최근의 커밋 시점으로 돌아간다.

SELECT * FROM fruits2;
UPDATE fruits2 SET price = 1333 WHERE fname = '사과';

/*
    # 테이블 행 삭제하기
    
        - DELETE FROM 테이블명 WHERE 조건;
        - 조건을 지정하지 않으면 모든 행이 삭제된다. ※ 주의
        - 하나의 행만 수정/삭제하기 위해서는 테이블에 반드시 기본키 컬럼이 필요하다.
*/

SELECT * FROM fruits2;

DELETE FROM fruits2; -- 조건을 지정하지 않으면 큰일난다.
ROLLBACK;

DELETE FROM fruits2 WHERE qty = 100;
COMMIT;

-- 연습1 : 어제 본인이 직접 생성했던 테이블 2개에 데이터 넣어보기
CREATE TABLE news (
    news_id NUMBER(15),
    news_title VARCHAR2(200),
    news_content VARCHAR2(3000),
    news_like NUMBER(10),
    news_angry NUMBER(10),
    news_dislike NUMBER(10),
    reporter_id NUMBER(8)
);

INSERT INTO news (news_id, news_title, news_content, news_like, news_angry, news_dislike, reporter_id)
VALUES (123456789012345, '정수장·저류 댐 등 인프라 건설 협력 요청', '마다가스카르 대통령, 水公에 阿 3국 정상, 화성 정수장 방문', 0, 0, 0, 12345678);
INSERT INTO news (news_id, news_title, news_content, news_like, news_angry, news_dislike, reporter_id)
VALUES (234567890123456, '평창읍, 우리동네 나눔가게 3~5호점 현판 게첨', '3호점 스타일헤어샵(대표 이미진), 4호점 삼삼오(대표 전은주), 5호점 전주식당(대표 김순자) 나눔', 
0, 0, 0, 23456789);
INSERT INTO news (news_id, news_title, news_content, news_like, news_angry, news_dislike, reporter_id)
VALUES (345678901234567, '액트지오 고문 "동해 심해 석유·가스 존재 암시 제반요소 갖춰"', '정부세종청사서 기자회견…"유망성 상당히 높다" "성공률 20%는 굉장히 양호하고 높은 수준"', 
4, 7, 60, 34567890);

SELECT * FROM news;

DROP TABLE news;

CREATE TABLE reporters (
    reporter_id NUMBER(8),
    reporter_name VARCHAR2(30),
    reporter_age NUMBER(3),
    reporter_email VARCHAR2(100),
    reporter_field VARCHAR2(30)
);

-- 연습2 : 두 테이블을 JOIN하여 원하는 데이터를 조회해보기