SELECT * FROM tabs;

SELECT * FROM fruits;
SELECT * FROM locations;

ALTER TABLE fruits ADD location_id CONSTRAINT fruits_location_id_fk REFERENCES locations(location_id);

SELECT * FROM user_constraints;

UPDATE fruits SET location_id=1800;
UPDATE fruits SET qty = 100;
COMMIT;

ALTER TABLE fruits ADD CONSTRAINT fqty_must_positive CHECK(qty >= 0);

CREATE TABLE FruitSalesHistory (
    fhid NUMBER(8) CONSTRAINT fhistory_fhid_pk PRIMARY KEY,
    fid NUMBER(8) CONSTRAINT fhistory_fid_fk REFERENCES fruits(fid),
    qty NUMBER(7) CONSTRAINT fhistory_qty_must_positive CHECK(qty >= 0)
);

ALTER TABLE FruitSalesHistory ADD purchase_time DATE DEFAULT sysdate;

SELECT * FROM FruitSalesHistory;

CREATE SEQUENCE fhistory_fhid_seq NOCACHE;

DELETE FROM FruitSalesHistory;