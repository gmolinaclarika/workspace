CREATE OR REPLACE FUNCTION mcastadmin$mresponse_dir (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _multicast_id       IN  DECIMAL,
    _mresponses_max     IN  INTEGER,
    _mresponses         OUT REFCURSOR
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
    -- #ResultSet ENTRY ENTRIES
    --    #Column ID                DECIMAL
    --    #Column MESSAGE           VARCHAR
    --    #Column STATION_CODE      VARCHAR
    --    #Column REQUEST_TIME      DATETIME
    --    #Column RESPONSE_TIME     DATETIME
    --    #Column ATTACHMENT_TYPE   NVARCHAR
    --    #Column ATTACHMENT_SIZE   INTEGER
    -- #EndResultSet
    OPEN _mresponses FOR
        SELECT id                       AS ID,
               message                  AS MESSAGE,
               station_code             AS STATION_CODE,
               request_time             AS REQUEST_TIME,
               response_time            AS RESPONSE_TIME,
               attachment_type          AS ATTACHMENT_TYPE,
               OCTET_LENGTH(attachment) AS ATTACHMENT_SIZE
        FROM  desktopfx_mresponse
        WHERE multicast_id = _multicast_id
        ORDER BY response_time
        LIMIT _mresponses_max;
END;
$BODY$ LANGUAGE plpgsql;
