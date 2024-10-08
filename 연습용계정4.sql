SELECT * FROM fruits;

DELETE FROM fruits;
COMMIT;

ALTER TABLE fruits ADD fid NUMBER(8) CONSTRAINT fruit_fid_pk PRIMARY KEY;

SELECT * FROM user_sequences;

CREATE SEQUENCE fruit_fid_seq INCREMENT BY 1 MAXVALUE 99999999 START WITH 1 NOCACHE;