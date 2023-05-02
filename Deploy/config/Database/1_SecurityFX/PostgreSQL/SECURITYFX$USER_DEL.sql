CREATE OR REPLACE FUNCTION securityfx$user_del (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _user_code          IN  VARCHAR
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
    _usu_codigo         ecuaccusu.usu_codigo%type;
BEGIN
    -- Cannot delete ADMIN user
    _usu_codigo := UPPER(RTRIM(_user_code));
    IF (_usu_codigo = 'ADMIN') THEN
        RAISE EXCEPTION 'No puede borrar el usuario: %s', _usu_codigo;
    END IF;

    -- Delete all profiles of the user
    DELETE FROM ecuaccu2p
    WHERE codigo_adi = _usu_codigo;

    -- Delete all capacities of the user
    DELETE FROM ecuaccc2u
    WHERE codigo_adi = _usu_codigo;

    -- Delete the properties of the user
    DELETE FROM ecuaccusu
    WHERE  usu_codigo = _usu_codigo;

    -- Generate an audit record
    PERFORM securityfx$audit_put(
        _wss_user_code, _wss_profile_code, _wss_station_code,
        57, 'Usuario fue eliminado: ' || _user_code);
END;
$BODY$ LANGUAGE plpgsql;
