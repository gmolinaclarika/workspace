CREATE OR REPLACE FUNCTION desktopfx$object_dir (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _level              IN  INTEGER,
    _type               IN  INTEGER,
    _name               IN  VARCHAR,
    _entries_max        IN  INTEGER,
    _entries            OUT REFCURSOR
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
    _login_id       desktopfx_login.id%type;
    _profile_code   desktopfx_login.profile_code%type;
BEGIN
    -- Obtain LoginID for User/Profile/Level
    _login_id := 0;
    IF (_level >= -1) THEN
        IF (_level = -1) THEN
            _profile_code := -1;
        ELSE
            _profile_code := _wss_profile_code;
        END IF;
        SELECT g.id INTO _login_id
        FROM   desktopfx_user u, desktopfx_login g
        WHERE  u.user_code = _wss_user_code
        AND    g.profile_code = _profile_code
        AND    u.id = g.user_id;
        IF (NOT FOUND) THEN
            RAISE EXCEPTION 'No existe login del usuario y perfil';
        END IF;
    END IF;

    -- #ResultSet ITEM ITEMS
    --   #Column  NAME  VARCHAR
    -- #EndResultSet
    IF (LENGTH(_name) = 0) THEN
        OPEN _entries FOR
            SELECT name AS NAME
            FROM   desktopfx_object
            WHERE  login_id = _login_id
            AND    type = _type
            ORDER BY name
            LIMIT _entries_max;
    ELSE
        OPEN _entries FOR
            SELECT name AS NAME
            FROM   desktopfx_object
            WHERE  login_id = _login_id
            AND    type = _type
            AND    name LIKE _name + '%'
            ORDER BY name
            LIMIT _entries_max;
    END IF;
END;
$BODY$ LANGUAGE plpgsql;
