CREATE OR REPLACE FUNCTION securityfx$capacity_get (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _capacity_code      IN  VARCHAR,
    -- General Properties
    _code               OUT VARCHAR,
    _name               OUT VARCHAR,
    _type               OUT INTEGER
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
    -- Normalize specified capacity name
    _cap_codigo := UPPER(RTRIM(_capacity_code));

    -- Return the properties of specified capacity
    SELECT 
        -- General Properties
        RTRIM(cap_codigo),
        RTRIM(cap_nombre),
        cap_tipo
    INTO
        -- General Properties
        _code,
        _name,
        _type
    FROM   ecuacccap
    WHERE  cap_codigo = _cap_codigo;
    IF (NOT FOUND) THEN
        RAISE EXCEPTION 'Capacidad no está definida: %s', _cap_codigo;
    END IF;
END;
$BODY$ LANGUAGE plpgsql;
