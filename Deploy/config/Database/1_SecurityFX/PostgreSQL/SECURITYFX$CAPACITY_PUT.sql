CREATE OR REPLACE FUNCTION securityfx$capacity_put (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _capacity_code      IN  VARCHAR,
    _name               IN  VARCHAR,
    _type               IN  INTEGER,
    _created            OUT INTEGER
)
AS $BODY$
--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------
DECLARE
    _cap_codigo         ecuacccap.cap_codigo%type;
BEGIN
    -- Asume the capacity exists
    _created := 0;

    -- Normalize specified capacity name
    _cap_codigo := UPPER(RTRIM(_capacity_code));

    -- Update the properties of specified capacity
    UPDATE ecuacccap
    SET    cap_nombre = _name,
           cap_tipo   = _type
    WHERE  cap_codigo = _cap_codigo;

    -- Create capacity if it didn't exist
    IF (NOT FOUND) THEN
        INSERT INTO ecuacccap (
             cap_codigo
            ,cap_nombre
            ,cap_tipo
        ) VALUES (
             _cap_codigo
            ,_name
            ,_type
        );
        _created := 1;
    END IF;

    -- Generate an audit record
    IF (_created = 0) THEN
        PERFORM securityfx$audit_put(
            _wss_user_code, _wss_profile_code, _wss_station_code, 
            15, 'Capacidad fue modificada: ' || _cap_codigo);
    ELSE
        PERFORM securityfx$audit_put(
            _wss_user_code, _wss_profile_code, _wss_station_code, 
            16, 'Capacidad fue creada: ' || _cap_codigo);
    END IF;
END;
$BODY$ LANGUAGE plpgsql;
