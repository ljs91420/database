/*
    # Oracle XE 11g 다운로드 및 설치
    
        1. 다운 받아서 설치
        2. 설치하면서 포트번호, 설치 경로를 기억해둘 것
        3. 설치 시 설정한 비밀번호를 절대 잊어버리지 말 것
        
    # 설치 후 기본 설정
    
        1. cmd 들어가서 sqlplus로 DB 실행되는지 확인
        2. sqldeveloper 설치해서 새로운 접속 생성하기 (왼쪽 위 +버튼)
        3. 관리자 계정으로 로그인 (sys as sysdba, 최초 설정한 비밀번호)
        4. 관리자 계정으로 로그인 후 연습용 계정 언락 및 비밀번호 변경(또는 새 계정 생성)
        5. 연습용 계정으로 새로운 접속 생성하기 (왼쪽 위 +버튼)
*/

SELECT * FROM tabs; -- Ctrl + Enter : 명령어 한 줄 실행

ALTER USER hr ACCOUNT UNLOCK; -- 계정 활성화(언락)
ALTER USER hr IDENTIFIED BY "1234"; -- 계정의 비밀번호 변경