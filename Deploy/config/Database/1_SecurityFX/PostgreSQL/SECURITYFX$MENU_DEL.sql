CREATE OR REPLACE FUNCTION securityfx$menu_del (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _menu_id            IN  BIGINT
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
    _menu_name          desktopfx_object.name%type;
BEGIN
    -- Obtain name of specified menu ID
    SELECT name INTO _menu_name FROM desktopfx_object
    WHERE  login_id = 0 AND type = 4 AND id = _menu_id;
    IF (NOT FOUND) THEN RETURN; END IF;

    -- Delete the specified menu
    DELETE FROM desktopfx_object
    WHERE login_id = 0 AND type = 4 AND id = _menu_id;

    -- Generate an audit record
    PERFORM securityfx$audit_put(
        _wss_user_code, _wss_profile_code, _wss_station_code,
        57, 'Menú fue eliminado: ' || _menu_name);
END;
$BODY$ LANGUAGE plpgsql;
