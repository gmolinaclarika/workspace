CREATE OR REPLACE FUNCTION securityfx$menu_put (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _menu_name          IN  VARCHAR,
    _menu_bytes         IN  BYTEA,
    --------------------------------
    _menu_id            OUT BIGINT,
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
    _men_name           desktopfx_object.name%type;
BEGIN
    -- Asume the menu exists
    _created := 0;

    -- Normalize specified menu name
    _men_name := UPPER(RTRIM(_menu_name));

    -- Update the properties of specified menu
    UPDATE desktopfx_object
    SET    bytes = _menu_bytes
    WHERE  login_id = 0 AND type = 4 AND name = _men_name;

    -- Create menu if it didn't exist
    IF (NOT FOUND) THEN
        INSERT INTO desktopfx_object (
             login_id, type, name, bytes
        ) VALUES (
             0, 4, _men_name, _menu_bytes
        );
        _created := 1;
    END IF;

    -- Return ID of the existing/created menu
    SELECT id INTO _menu_id FROM desktopfx_object
    WHERE  login_id = 0 AND type = 4 AND name = _men_name;

    -- Generate an audit record
    IF (_created = 0) THEN
        PERFORM securityfx$audit_put(
            _wss_user_code, _wss_profile_code, _wss_station_code,
            15, 'Menú fue modificado: ' || _men_name);
    ELSE
        PERFORM securityfx$audit_put(
            _wss_user_code, _wss_profile_code, _wss_station_code,
            16, 'Menú fue creado: ' || _men_name);
    END IF;
END;
$BODY$ LANGUAGE plpgsql;
