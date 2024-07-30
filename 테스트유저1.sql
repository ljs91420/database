show user;

SELECT * FROM tabs;
SELECT * FROM tab;
SELECT * FROM user_tables;

CREATE TABLE event_list (
    event_id NUMBER(4),
    event_name VARCHAR2(50),
    event_start DATE,
    event_end DATE
);

DROP TABLE event_list;