CREATE OR REPLACE FUNCTION securityfx$terminal_del (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _terminal_name      IN  VARCHAR
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
    _v_net_nombre       ecuaccnet.v_net_nombre%type;
BEGIN
    -- Normalize specified terminal name
    _v_net_nombre := UPPER(RTRIM(_terminal_name));

    -- Delete the properties of specified terminal
    DELETE FROM ecuaccnet
    WHERE  v_net_nombre = _v_net_nombre;

    -- Generate an audit record
    PERFORM securityfx$audit_put(
        _wss_user_code, _wss_profile_code, _wss_station_code, 
        12, 'Terminal fue eliminado: ' || _terminal_name);
END;
$BODY$ LANGUAGE plpgsql;
