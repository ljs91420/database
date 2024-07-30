-- 20_계정 관리.sql

-- # 현재 접속한 계정 보기
SHOW user;

-- # 새 계정 생성하기
CREATE USER testuser1 IDENTIFIED BY "1313";
CREATE USER testuser2 IDENTIFIED BY "1313";

-- # DB에 있는 모든 계정 보기
SELECT * FROM all_users;

-- 계정에 권한 부여하기 (GRANT)
GRANT CREATE SESSION TO testuser1; -- 해당 계정 접속 권한 부여
GRANT CREATE TABLE TO testuser1; -- 테이블 생성 권한 부여
GRANT RESOURCE TO testuser1; -- 저장 공간 사용 권한 부여

GRANT CREATE SESSION TO testuser2;
GRANT CREATE TABLE TO testuser2;
GRANT RESOURCE TO testuser2;

-- # 계정의 권한 뺏기 (REVOKE ~ FROM)
REVOKE RESOURCE FROM testuser2;

-- # 비밀번호 바꾸기 (계정은 DB오브젝트이기 때문에 CREATE, ALTER 등의 DDL을 사용한다)
ALTER USER testuser1 IDENTIFIED BY "1234";

-- # 계정 삭제하기
DROP USER testuser2; -- 해당 계정에 남아있는 DB오브젝트를 먼저 삭제해야 계정 삭제 가능
DROP USER testuser2 CASCADE; -- CASCADE 옵션을 붙이면 무시하고 모두 삭제 가능

DROP USER testuser1;