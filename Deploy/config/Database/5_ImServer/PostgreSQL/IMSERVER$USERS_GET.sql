CREATE OR REPLACE FUNCTION imserver$users_get (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
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
    --    #Column USER_CODE     VARCHAR
    --    #Column GIVEN_NAMES   VARCHAR
    --    #Column FATHER_NAME   VARCHAR
    --    #Column MOTHER_NAME   VARCHAR
    --    #Column ADDRESS       VARCHAR
    --    #Column COMMUNE       VARCHAR
    --    #Column CITY          VARCHAR
    --    #Column COUNTRY       VARCHAR
    --    #Column POSITION      VARCHAR
    --    #Column PHONE1        VARCHAR
    --    #Column FAX           VARCHAR
    --    #Column EMAIL         VARCHAR
    --    #Column DOMAIN        VARCHAR
    -- #EndResultSet
    OPEN _users FOR
        SELECT TRIM(usu_codigo)     AS USER_CODE,
               TRIM(nombres)        AS GIVEN_NAMES,
               TRIM(apellido_pat)   AS FATHER_NAME,
               TRIM(apellido_mat)   AS MOTHER_NAME,
               TRIM(direccion)      AS ADDRESS,
               TRIM(comuna)         AS COMMUNE,
               TRIM(ciudad)         AS CITY,
               TRIM(pais)           AS COUNTRY,
               TRIM(cargo)          AS POSITION,
               TRIM(fono1)          AS PHONE1,
               TRIM(fax)            AS FAX,
               TRIM(email)          AS EMAIL,
               TRIM(familia)        AS DOMAIN
        FROM   ecuaccusu
        WHERE  usu_estado = 'HA'
        AND    usuarioim = 'S'
        ORDER BY usu_codigo
        LIMIT _users_max;
END;
$BODY$ LANGUAGE plpgsql;
