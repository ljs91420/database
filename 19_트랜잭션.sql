-- 19_트랜잭션.sql

/*
    # 트랜잭션(Transaction)
    
        - 하나의 작업 단위(e.g. 송금)
        - 데이터베이스는 하나의 트랜잭션에 속한 모든 쿼리문이 정상적으로 수행되는 경우에만 변경사항을 확정지을 수 있는 기능을 제공한다.(All or Nothing)
        - 트랜잭션을 관리하기 위한 키워드로는 COMMIT, ROLLBACK, SAVEPOINT, ROLLBACK TO를 사용한다.
        - 하나의 트랜잭션은 마지막으로 실행된 커밋으로부터 새로운 커밋을 실행하기 전까지 실행되는 모든 DML문을 의미한다.
          (DDL, DCL은 트랜잭션의 관리를 받지 않는다.)
*/

SELECT * FROM fruits;

CREATE TABLE sales (
    sale_date DATE,
    purchase NUMBER(9),
    sales NUMBER(9),
    refund NUMBER(9)
);

-- 판매가 발생했다고 가정(사과가 10개 팔림)

-- 1. 사과의 재고가 줄어들어야 한다.
UPDATE fruits SET qty = qty - 10 WHERE fname = '사과';
ROLLBACK;

-- 2. 오늘의 판매 내역 테이블에 사과가 10개 팔렸다고 등록해줘야 한다.

-- 3. 오늘의 누적 매출액이 증가해야 한다.(INSERT인지 UPDATE인지는 자바쪽에서 구분 가능)
INSERT INTO sales(sales_date, purchase, sales, refund) VALUES(TO_CHAR(sysdate, 'YY-MM-DD'), 0, 0, 0);

UPDATE sales SET sales = sales + (SELECT price FROM fruits WHERE fname = '사과') * 10 WHERE sale_date = TO_CHAR(sysdate, 'YY-MM-DD');

SELECT TO_CHAR(sysdate, 'YY-MM-DD') FROM dual;

SELECT * FROM sales;
DELETE FROM sales;

COMMIT;

-- SAVEPOINT, ROLLBACK TO 사용
SELECT * FROM fruits;

UPDATE fruits SET qty = qty + 20 WHERE fname = '사과';

COMMIT;

UPDATE fruits SET qty = qty + 20 WHERE fname = '사과';
SAVEPOINT purchase1;

UPDATE fruits SET qty = qty + 20 WHERE fname = '사과';
SAVEPOINT purchase2;

UPDATE fruits SET qty = qty + 20 WHERE fname = '사과';
SAVEPOINT purchase3;

-- 세이브포인트를 사용해서 단계별 롤백을 진행할 수 있다.
SELECT * FROM fruits;

-- 한 번 이전의 세이브포인트로 돌아갔다면 이후의 세이브포인트로 다시 돌아갈 수는 없다.
ROLLBACK TO purchase2;
ROLLBACK TO purchase3;
ROLLBACK; -- 세이브포인트를 모두 무시하고 가장 최근 커밋 상태로 돌아간다.