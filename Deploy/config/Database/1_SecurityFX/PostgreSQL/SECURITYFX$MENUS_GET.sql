CREATE OR REPLACE FUNCTION securityfx$menus_get (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _menu_name          IN  VARCHAR,
    _menus_max          IN  INTEGER,
    --------------------------------
    _menus              OUT REFCURSOR
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
    -- #ResultSet MENU MENUS
    --    #Column MENU_ID    BIGINT
    --    #Column MENU_NAME  NVARCHAR
    --    #Column REF_COUNT  INTEGER
    -- #EndResultSet
    OPEN _menus FOR
        SELECT ID                                   AS MENU_ID,
               NAME                                 AS MENU_NAME,
               (SELECT COUNT(*) FROM ecuaccper
                WHERE RTRIM(v_acc_prog_ini) = name) AS REF_COUNT
        FROM   desktopfx_object
        WHERE  login_id = 0 AND type = 4
        AND    name LIKE UPPER(_menu_name) || '%'
        ORDER BY name ASC
        LIMIT _menus_max;
END;
$BODY$ LANGUAGE plpgsql;
