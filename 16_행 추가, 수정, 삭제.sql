-- 16_�� �߰�, ����, ����.sql

/*
    # ���̺� �� �߰��ϱ�
    
        - INSERT INTO ���̺��(�÷�1, �÷�2, ...) VALUES(��1, ��2, ...)
        - INSERT INTO ���̺�� VALUES (�����ϴ� ��� �÷� ���� �������);
*/

CREATE TABLE fruits(
    fname VARCHAR2(30),
    price NUMBER(6),
    qty NUMBER(7) default 0 -- �÷��� default ������ �⺻���� �ȴ�.
);

DROP TABLE fruits;
PURGE recyclebin;

SELECT * FROM fruits;

INSERT INTO fruits(fname, price, qty) VALUES ('���', 1000, 30);
-- ��� �÷��� �� ���� ������ ���� ���� �÷����� null ���� �߰��ȴ�.
-- default�� ������ �÷��� �Բ� ���� Ȱ��Ǵ� ����̴�.
INSERT INTO fruits(fname, price) VALUES ('����', 3000);
-- �� �߰��� �÷��� ������ ������� ������ �� �ִ�.
INSERT INTO fruits(price, qty, fname) VALUES (2500, 50, '������');

-- ���̺� �÷��� ������ ��� ���� ������ ���� ������� ���� �߰��� �� �ִ�.
INSERT INTO fruits VALUES('Mango', 2800, 100);

SELECT * FROM fruits WHERE fname BETWEEN 'A' AND 'ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ';
DESC fruits;

-- ���� ������ Ȱ���� INSERT (���̺� ������ ������ �ÿ��� ����)
CREATE TABLE fruits2 AS (SELECT * FROM fruits WHERE 1 != 1);

SELECT * FROM fruits2;

INSERT INTO fruits2(price) VALUES(1000);
INSERT INTO fruits2 (SELECT * FROM fruits); -- ���� ������ Ȱ���� �� �ֱ�
INSERT INTO fruits2 (SELECT * FROM fruits2); -- �ڰ� ����

/*
    # ���̺� �� �����ϱ�
    
        - UPDATE ���̺�� SET �÷�1=��1, �÷�2=��2, ... WHERE ������;
        - ���� ������ �������� ������ ��� ���� �����ȴ�. �� ����
*/

COMMIT; -- ��������� ���̺� ��������� Ȯ�����´�.

SELECT * FROM fruits2;
UPDATE fruits2 SET price = 100; -- ������ �������� ������ ū�ϳ���.

ROLLBACK; -- ���� �ֱ��� Ŀ�� �������� ���ư���.

SELECT * FROM fruits2;
UPDATE fruits2 SET price = 1333 WHERE fname = '���';

/*
    # ���̺� �� �����ϱ�
    
        - DELETE FROM ���̺�� WHERE ����;
        - ������ �������� ������ ��� ���� �����ȴ�. �� ����
        - �ϳ��� �ุ ����/�����ϱ� ���ؼ��� ���̺� �ݵ�� �⺻Ű �÷��� �ʿ��ϴ�.
*/

SELECT * FROM fruits2;

DELETE FROM fruits2; -- ������ �������� ������ ū�ϳ���.
ROLLBACK;

DELETE FROM fruits2 WHERE qty = 100;
COMMIT;

-- ����1 : ���� ������ ���� �����ߴ� ���̺� 2���� ������ �־��
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
VALUES (123456789012345, '�����塤���� �� �� ������ �Ǽ� ���� ��û', '���ٰ���ī�� �����, ��뿡 � 3�� ����, ȭ�� ������ �湮', 0, 0, 0, 12345678);
INSERT INTO news (news_id, news_title, news_content, news_like, news_angry, news_dislike, reporter_id)
VALUES (234567890123456, '��â��, �츮���� �������� 3~5ȣ�� ���� ��÷', '3ȣ�� ��Ÿ����(��ǥ �̹���), 4ȣ�� ����(��ǥ ������), 5ȣ�� ���ֽĴ�(��ǥ �����) ����', 
0, 0, 0, 23456789);
INSERT INTO news (news_id, news_title, news_content, news_like, news_angry, news_dislike, reporter_id)
VALUES (345678901234567, '��Ʈ���� �� "���� ���� ���������� ���� �Ͻ� ���ݿ�� ����"', '���μ���û�缭 ����ȸ�ߡ�"������ ����� ����" "������ 20%�� ������ ��ȣ�ϰ� ���� ����"', 
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

-- ����2 : �� ���̺��� JOIN�Ͽ� ���ϴ� �����͸� ��ȸ�غ���