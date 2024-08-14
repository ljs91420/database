CREATE TABLE ProfileImage (
    id NUMBER(8) CONSTRAINT profile_image_id_pk PRIMARY KEY,
    originalFilename VARCHAR2(100),
    storedFilename VARCHAR2(100)
);

CREATE SEQUENCE profile_image_seq NOCACHE NOCYCLE;

DESC profileImage;

SELECT * FROM profileImage;