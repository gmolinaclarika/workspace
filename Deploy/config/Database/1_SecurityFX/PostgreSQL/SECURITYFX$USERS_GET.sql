CREATE OR REPLACE FUNCTION securityfx$users_get (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _user_code          IN  VARCHAR,
    _users_max          IN  INTEGER,
    _users              OUT REFCURSOR
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
    -- #ResultSet USER USERS
    --    #Column CODE          VARCHAR
    --    #Column GIVEN_NAMES   VARCHAR
    --    #Column FATHER_NAME   VARCHAR
    --    #Column MOTHER_NAME   VARCHAR
    --    #Column DOMAIN        NVARCHAR
    --    #Column STATE         VARCHAR
    -- #EndResultSet
    OPEN _users FOR
        SELECT RTRIM(usu_codigo)    AS CODE,
               RTRIM(nombres)       AS GIVEN_NAMES,
               RTRIM(apellido_pat)  AS FATHER_NAME,
               RTRIM(apellido_mat)  AS MOTHER_NAME,
               RTRIM(FAMILIA)       AS DOMAIN,
               RTRIM(usu_estado)    AS STATE
        FROM  ecuaccusu
        WHERE usu_codigo LIKE UPPER(_user_code) || '%'
        ORDER BY usu_codigo ASC
        LIMIT _users_max;
END;
$BODY$ LANGUAGE plpgsql;
