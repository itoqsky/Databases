CREATE OR REPLACE FUNCTION retrievecustomers(start_pos INTEGER, end_pos INTEGER)
RETURNS SETOF customer AS $$
BEGIN
    IF start_pos < 0 OR end_pos < 0 OR start_pos > 600 OR end_pos > 600 THEN
        RAISE EXCEPTION 'ERROR: Positions must be between 0 and 600';
    ELSE
        RETURN QUERY SELECT * FROM customer WHERE address_id BETWEEN start_pos AND end_pos ORDER BY address_id;
    END IF;
END;
$$ LANGUAGE plpgsql;

SELECT * from retrievecustomers(10, 40);