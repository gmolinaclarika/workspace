CREATE OR REPLACE FUNCTION securityfx$capacity_del (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _capacity_code      IN  VARCHAR
) RETURNS void
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

    -- Check the capacity is not assigned to a user
    IF EXISTS(SELECT * FROM ecuaccc2u WHERE cap_codigo = _cap_codigo) THEN
        RAISE EXCEPTION 'Capacidad %s está asignada a uno o más usuarios', _cap_codigo;
    END IF;

    -- Check the capacity is not assigned to a profile
    IF EXISTS(SELECT * FROM ecuaccc2p WHERE cap_codigo = _cap_codigo) THEN
        RAISE EXCEPTION 'Capacidad %s está asignada a uno o más perfiles', _cap_codigo;
    END IF;

    -- Delete the properties of specified capacity
    DELETE FROM ecuacccap
    WHERE  cap_codigo = _cap_codigo;

    -- Generate an audit record
    PERFORM securityfx$audit_put(
        _wss_user_code, _wss_profile_code, _wss_station_code, 
        12, 'Capacidad fue eliminada: ' || _cap_codigo);
END;
$BODY$ LANGUAGE plpgsql;
