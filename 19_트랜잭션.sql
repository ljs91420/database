-- 19_Ʈ�����.sql

/*
    # Ʈ�����(Transaction)
    
        - �ϳ��� �۾� ����(e.g. �۱�)
        - �����ͺ��̽��� �ϳ��� Ʈ����ǿ� ���� ��� �������� ���������� ����Ǵ� ��쿡�� ��������� Ȯ������ �� �ִ� ����� �����Ѵ�.(All or Nothing)
        - Ʈ������� �����ϱ� ���� Ű����δ� COMMIT, ROLLBACK, SAVEPOINT, ROLLBACK TO�� ����Ѵ�.
        - �ϳ��� Ʈ������� ���������� ����� Ŀ�����κ��� ���ο� Ŀ���� �����ϱ� ������ ����Ǵ� ��� DML���� �ǹ��Ѵ�.
          (DDL, DCL�� Ʈ������� ������ ���� �ʴ´�.)
*/

SELECT * FROM fruits;

CREATE TABLE sales (
    sale_date DATE,
    purchase NUMBER(9),
    sales NUMBER(9),
    refund NUMBER(9)
);

-- �ǸŰ� �߻��ߴٰ� ����(����� 10�� �ȸ�)

-- 1. ����� ��� �پ���� �Ѵ�.
UPDATE fruits SET qty = qty - 10 WHERE fname = '���';
ROLLBACK;

-- 2. ������ �Ǹ� ���� ���̺� ����� 10�� �ȷȴٰ� �������� �Ѵ�.

-- 3. ������ ���� ������� �����ؾ� �Ѵ�.(INSERT���� UPDATE������ �ڹ��ʿ��� ���� ����)
INSERT INTO sales(sales_date, purchase, sales, refund) VALUES(TO_CHAR(sysdate, 'YY-MM-DD'), 0, 0, 0);

UPDATE sales SET sales = sales + (SELECT price FROM fruits WHERE fname = '���') * 10 WHERE sale_date = TO_CHAR(sysdate, 'YY-MM-DD');

SELECT TO_CHAR(sysdate, 'YY-MM-DD') FROM dual;

SELECT * FROM sales;
DELETE FROM sales;

COMMIT;

-- SAVEPOINT, ROLLBACK TO ���
SELECT * FROM fruits;

UPDATE fruits SET qty = qty + 20 WHERE fname = '���';

COMMIT;

UPDATE fruits SET qty = qty + 20 WHERE fname = '���';
SAVEPOINT purchase1;

UPDATE fruits SET qty = qty + 20 WHERE fname = '���';
SAVEPOINT purchase2;

UPDATE fruits SET qty = qty + 20 WHERE fname = '���';
SAVEPOINT purchase3;

-- ���̺�����Ʈ�� ����ؼ� �ܰ躰 �ѹ��� ������ �� �ִ�.
SELECT * FROM fruits;

-- �� �� ������ ���̺�����Ʈ�� ���ư��ٸ� ������ ���̺�����Ʈ�� �ٽ� ���ư� ���� ����.
ROLLBACK TO purchase2;
ROLLBACK TO purchase3;
ROLLBACK; -- ���̺�����Ʈ�� ��� �����ϰ� ���� �ֱ� Ŀ�� ���·� ���ư���.