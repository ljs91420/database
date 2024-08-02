CREATE TABLE board (
    board_id NUMBER(8) CONSTRAINT board_id_pk PRIMARY KEY,
    board_title VARCHAR2(100) CONSTRAINT board_title_nn NOT NULL,
    board_writer VARCHAR2(30) CONSTRAINT board_writer_nn NOT NULL,
    board_password VARCHAR2(12) CONSTRAINT board_password_nn NOT NULL,
    board_writer_ip_addr VARCHAR2(15) CONSTRAINT board_writer_ip_addr_nn NOT NULL,
    board_content VARCHAR2(3000) CONSTRAINT board_content_nn NOT NULL,
    board_write_date DATE DEFAULT sysdate,
    board_view_count NUMBER(8) DEFAULT 0,
    board_good_count NUMBER(8) DEFAULT 0,
    board_bad_count NUMBER(8) DEFAULT 0
);

SELECT * FROM user_constraints;
SELECT * FROM board;