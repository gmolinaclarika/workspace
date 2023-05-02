CREATE OR REPLACE FUNCTION securityfx$menu_get (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _menu_id            IN  BIGINT,
    --------------------------------
    _menu_name          OUT VARCHAR,
    _menu_bytes         OUT BYTEA
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
BEGIN
    -- Return the properties of specified menu
    SELECT
        name,
        bytes
    INTO
        _menu_name,
        _menu_bytes
    FROM   desktopfx_object
    WHERE  login_id = 0 AND type = 4 AND id = _menu_id;
    IF (NOT FOUND) THEN
        RAISE EXCEPTION 'Menú no está definido: %d', _menu_id;
    END IF;
END;
$BODY$ LANGUAGE plpgsql;
