show user;

SELECT * FROM tabs;

CREATE TABLE animal_kind (
    kind_id NUMBER(4) CONSTRAINT ak_id_pk PRIMARY KEY,
    kor_name VARCHAR2(30) CONSTRAINT ak_kn_nn NOT NULL,
    eng_name VARCHAR2(20) CONSTRAINT ak_en_nn NOT NULL
);

CREATE SEQUENCE animal_kind_seq START WITH 1 INCREMENT BY 1 MAXVALUE 9999;