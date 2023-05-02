CREATE OR REPLACE FUNCTION securityfx$profiles_get (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _profile_code       IN  INTEGER,
    _profiles_max       IN  INTEGER,
    _profiles           OUT REFCURSOR
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
    -- #ResultSet PROFILE PROFILES
    --    #Column CODE      INTEGER
    --    #Column NAME      VARCHAR
    --    #Column FLAGS     VARCHAR
    --    #Column MENU      VARCHAR
    --    #Column DOMAIN    VARCHAR
    -- #EndResultSet
    OPEN _profiles FOR
        SELECT v_acc_code_num               AS CODE,
               RTRIM(v_acc_name)            AS NAME,
               RTRIM(v_acc_indicadores)     AS FLAGS,
               RTRIM(v_acc_prog_ini)        AS MENU,
               RTRIM(v_acc_familia)         AS DOMAIN
        FROM  ecuaccper
        WHERE v_acc_code_num >= _profile_code
        ORDER BY v_acc_code_num ASC
        LIMIT _profiles_max;
END;
$BODY$ LANGUAGE plpgsql;
