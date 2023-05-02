CREATE OR REPLACE FUNCTION securityfx$profile_del (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _profile_code       IN INTEGER
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
BEGIN
    -- Cannot delete ADMIN (0) profile
    IF (_profile_code = 0) THEN
        RAISE EXCEPTION 'No puede borrar el perfil: %s', _profile_code;
    END IF;

    -- Delete all users of the profile
    DELETE FROM ecuaccu2p
    WHERE codigo_ecu = _profile_code;

    -- Delete all capacities of the profile
    DELETE FROM ecuaccc2p
    WHERE codigo_ecu = _profile_code;

    -- Delete the properties of the profile
    DELETE FROM ecuaccper
    WHERE  v_acc_code_num = _profile_code;

    -- Generate an audit record
    PERFORM securityfx$audit_put(
        _wss_user_code, _wss_profile_code, _wss_station_code,
        57, 'Perfil fue eliminado: ' || _profile_code);
END;
$BODY$ LANGUAGE plpgsql;
