CREATE OR REPLACE FUNCTION securityfx$capacities_get (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _capacities_max     IN  INTEGER,
    _capacities         OUT REFCURSOR
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
    -- #ResultSet CAPACITY CAPACITIES
    --    #Column CODE VARCHAR
    --    #Column NAME VARCHAR
    --    #Column TYPE INTEGER
    -- #EndResultSet
    OPEN _capacities FOR
        SELECT RTRIM(cap_codigo)    AS CODE,
               RTRIM(cap_nombre)    AS NAME,
               cap_tipo             AS TYPE
        FROM  ecuacccap
        ORDER BY cap_codigo
        LIMIT _capacities_max;
END;
$BODY$ LANGUAGE plpgsql;
