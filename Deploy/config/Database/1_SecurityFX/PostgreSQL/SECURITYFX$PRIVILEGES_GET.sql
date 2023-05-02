CREATE OR REPLACE FUNCTION securityfx$privileges_get (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _privileges_max     IN  INTEGER,
    _privileges         OUT REFCURSOR
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
    -- #ResultSet PRIVILEGE PRIVILEGES
    --    #Column TYPE      VARCHAR
    --    #Column INDEX     INTEGER
    --    #Column LABEL     VARCHAR
    --    #Column CNAME     VARCHAR
    --    #Column SNAME     VARCHAR
    -- #EndResultSet
    OPEN _privileges FOR
        SELECT RTRIM(v_prv_tipo)        AS TYPE,
               v_prv_numero             AS INDEX,
               RTRIM(v_prv_nombre)      AS LABEL,
               RTRIM(v_prv_const)       AS CNAME,
               RTRIM(v_prv_syslog)      AS SNAME
        FROM  ecuaccprv
        ORDER BY v_prv_tipo, v_prv_numero ASC
        LIMIT _privileges_max;
END;
$BODY$ LANGUAGE plpgsql;
