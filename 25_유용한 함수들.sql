-- 25_������ �Լ���.sql

/* ���� Ÿ�� �Լ��� */

-- TO_NUMBER(data) : �ٸ� Ÿ�� �����͸� ���� Ÿ������ ��ȯ�Ѵ�.
SELECT TO_NUMBER('12345') FROM dual;

-- ������ ����� ������ �ִ� ���ڿ��� ���ڷ� ��ȯ���� �� �ִ�.
SELECT TO_NUMBER('10,000', '99,999') FROM dual;
SELECT TO_NUMBER('1,000,000', '9,999,999') FROM dual;
SELECT TO_NUMBER('$30000', '$9999') FROM dual;

-- ABS(num) : ���밪
SELECT abs(-10) FROM dual;

-- floor(num) : ����
SELECT floor(123.123) FROM dual;

-- ceil(num) : �ø�
SELECT ceil(123.123) FROM dual;

-- round(num, offset) : �ݿø�
SELECT round(123.1234, 2) FROM dual;
SELECT round(123.12555, 2) FROM dual;
SELECT round(123.12555, 0) FROM dual;
SELECT round(123.12555, -2) FROM dual;

-- trunc(num, offset) : �ݿø����� �ʰ� �߶������
SELECT trunc(123.8888, 2) FROM dual;
SELECT round(123.8888, 2) FROM dual;
SELECT trunc(17777.8888, -3) FROM dual;
SELECT round(17777.8888, -3) FROM dual;


-- mod(n, m) : ������ ����
SELECT mod(10, 3) FROM dual;
SELECT mod(123, 10) FROM dual;

/* ���� Ÿ�� �Լ��� */

-- TO_CHAR(data) : �ٸ� Ÿ�� �����͵��� ���� Ÿ������ ��ȯ
SELECT TO_CHAR(12345) FROM dual;
SELECT TO_CHAR(sysdate) FROM dual;

-- ���ڸ� ���ڷ� ��ȯ�� �� ������ ����� �� �ִ�.
SELECT TO_CHAR(3000, '9,999') FROM dual;
SELECT TO_CHAR(3000, '$9,999') FROM dual;
SELECT TO_CHAR(3000, '9,999L') FROM dual;

-- ��¥�� ���ڷ� ��ȯ�� ���� ������ ����� �� �ִ�.
SELECT TO_CHAR(sysdate, 'YYYY-MM-DD HH:MI:SS') FROM dual;
SELECT TO_CHAR(hire_date, 'YYYY-MM-DD HH:MI:SS') FROM employees;

-- substr(str, start, length) : ���� �ڸ���(���� ��ġ���� length���� �ڸ���)
SELECT substr('Hello, world!', 5, 5) FROM dual;

-- upper(str) : �빮�ڷ� ��ȯ
-- lower(str) : �ҹ��ڷ� ��ȯ
-- initcap(str) : ù ���ڸ� �빮�ڷ� ��ȯ
SELECT upper('hello') FROM dual;
SELECT lower('HELLO') FROM dual;
SELECT initcap('hello') FROM dual;
SELECT initcap(email) FROM employees;

-- replace(str, old, new) : ���� ��ü
SELECT replace('abc.jpg', '.jpg', '.gif') FROM dual;

-- lpad(str, full-length, char) : ���ϴ� ���ڸ� ���ʿ� �߰��Ͽ� �������� ���̸� �����ش�.
-- rpad(str, full-length, char) : ���ϴ� ���ڸ� �����ʿ� �߰��Ͽ� �������� ���̸� �����ش�.
SELECT lpad(first_name, 20, ' ') FROM employees;
SELECT rpad(first_name, 15, ' ') FROM employees;

-- ltrim(str, chars) : ���ʿ� �ִ� ���ϴ� ���ڵ��� ��� �������ش�.
-- rtrim(str, chars) : �����ʿ� �ִ� ���ϴ� ���ڵ��� ��� �������ش�.
SELECT ltrim('!!@@!!!!!Ellen', '!') FROM dual;
SELECT ltrim('!!@@!!!!!Ellen', '!@') FROM dual;
SELECT rtrim('Ellen====/', '/=') FROM dual;

/* ��¥ Ÿ�� �Լ��� */

-- TO_DATE(data) : ���� �����͸� ��¥ Ÿ������ ��ȯ
SELECT TO_DATE('1998/11/11') FROM dual;
SELECT TO_DATE('1998-11-11') FROM dual;
SELECT TO_DATE('1998+11+11') FROM dual;

-- ������ ����� ���� �����͸� ��¥ Ÿ������ ��ȯ�� ���� �ִ�.
SELECT TO_DATE('2002---09---09', 'YYYY---MM---DD') FROM dual;
SELECT TO_DATE('2002---09---09, 23:44:35', 'YYYY---MM---DD, HH24:MI:SS') FROM dual;

-- trunc(date) : ��¥ �����͸� ���ϴ� ������ �߶� ����� �� �ִ�.
SELECT TO_CHAR(sysdate, 'YY/MM/DD, HH:MI:SS') FROM dual;
SELECT TO_CHAR(trunc(sysdate, 'day'), 'YY/MM/DD, HH:MI:SS') FROM dual;
SELECT TO_CHAR(trunc(sysdate, 'month'), 'YY/MM/DD, HH:MI:SS') FROM dual;
SELECT TO_CHAR(trunc(sysdate, 'year'), 'YY/MM/DD, HH:MI:SS') FROM dual;

-- å 8�� : ���̺�� ��(View)
-- å 9�� : �ε���(Index) - �Ϻ� ��Ȳ���� Ž�� �ӵ��� ����, �⺻Ű�� �⺻������ �ε��� ������ ��, �߸��ϸ� ������ ������ �� ����
-- å 10�� : ������ ���ν����� �Լ�