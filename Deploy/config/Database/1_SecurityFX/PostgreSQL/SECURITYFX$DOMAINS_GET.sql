CREATE OR REPLACE FUNCTION securityfx$domains_get (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _domain_name        IN  VARCHAR,
    _domains_max        IN  INTEGER,
    _domains            OUT REFCURSOR
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
    -- #ResultSet DOMAIN DOMAINS
    --    #Column NAME      VARCHAR
    --    #Column FUNCTION  VARCHAR
    --    #Column LOCATION  VARCHAR
    -- #EndResultSet
    OPEN _domains FOR
        SELECT RTRIM(v_fam_familia)         AS NAME,
               RTRIM(v_fam_nombre_usuario)  AS FUNCTION,
               RTRIM(v_fam_ubicacion)       AS LOCATION
        FROM  ecuaccfam
        WHERE v_fam_familia LIKE UPPER(_domain_name) || '%'
        ORDER BY v_fam_familia ASC
        LIMIT _domains_max;
END;
$BODY$ LANGUAGE plpgsql;
