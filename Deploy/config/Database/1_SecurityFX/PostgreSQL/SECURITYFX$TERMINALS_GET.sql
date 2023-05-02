CREATE OR REPLACE FUNCTION securityfx$terminals_get (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _terminal_name      IN  VARCHAR,
    _terminals_max      IN  INTEGER,
    _terminals          OUT REFCURSOR
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
    -- #ResultSet TERMINAL TERMINALS
    --    #Column NAME      VARCHAR
    --    #Column DOMAIN    NVARCHAR
    --    #Column TYPE      VARCHAR
    --    #Column FUNCTION  VARCHAR
    --    #Column LOCATION  VARCHAR
    --    #Column STATE     VARCHAR
    -- #EndResultSet
    OPEN _terminals FOR
        SELECT RTRIM(v_net_nombre)          AS NAME,
               RTRIM(v_net_familia)         AS DOMAIN,
               RTRIM(v_net_tipo)            AS TYPE,
               RTRIM(v_net_nombre_usuario)  AS FUNCTION,
               RTRIM(v_net_ubicacion)       AS LOCATION,
               RTRIM(v_net_habilitado)      AS STATE
        FROM  ecuaccnet
        WHERE v_net_nombre LIKE _terminal_name || '%'
        ORDER BY v_net_nombre ASC
        LIMIT _terminals_max;
END;
$BODY$ LANGUAGE plpgsql;
