-- 20_���� ����.sql

-- # ���� ������ ���� ����
SHOW user;

-- # �� ���� �����ϱ�
CREATE USER testuser1 IDENTIFIED BY "1313";
CREATE USER testuser2 IDENTIFIED BY "1313";

-- # DB�� �ִ� ��� ���� ����
SELECT * FROM all_users;

-- ������ ���� �ο��ϱ� (GRANT)
GRANT CREATE SESSION TO testuser1; -- �ش� ���� ���� ���� �ο�
GRANT CREATE TABLE TO testuser1; -- ���̺� ���� ���� �ο�
GRANT RESOURCE TO testuser1; -- ���� ���� ��� ���� �ο�

GRANT CREATE SESSION TO testuser2;
GRANT CREATE TABLE TO testuser2;
GRANT RESOURCE TO testuser2;

-- # ������ ���� ���� (REVOKE ~ FROM)
REVOKE RESOURCE FROM testuser2;

-- # ��й�ȣ �ٲٱ� (������ DB������Ʈ�̱� ������ CREATE, ALTER ���� DDL�� ����Ѵ�)
ALTER USER testuser1 IDENTIFIED BY "1234";

-- # ���� �����ϱ�
DROP USER testuser2; -- �ش� ������ �����ִ� DB������Ʈ�� ���� �����ؾ� ���� ���� ����
DROP USER testuser2 CASCADE; -- CASCADE �ɼ��� ���̸� �����ϰ� ��� ���� ����

DROP USER testuser1;