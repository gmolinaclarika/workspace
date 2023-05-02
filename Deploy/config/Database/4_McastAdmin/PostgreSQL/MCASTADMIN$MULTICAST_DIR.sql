CREATE OR REPLACE FUNCTION mcastadmin$multicast_dir (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _multicasts_max     IN  INTEGER,
    _multicasts         OUT REFCURSOR
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
    --    #Column NAME              VARCHAR
    --    #Column MESSAGE           VARCHAR
    --    #Column VALID_FROM        DATETIME
    --    #Column VALID_TO          DATETIME
    --    #Column ATTACHMENT_TYPE   NVARCHAR
    --    #Column ATTACHMENT_SIZE   INTEGER
    --    #Column USER_FILTER       VARCHAR
    --    #Column PROFILE_FILTER    INTEGER
    --    #Column STATION_FILTER    VARCHAR
    -- #EndResultSet
    OPEN _multicasts FOR
        SELECT id                       AS ID,
               name                     AS NAME,
               message                  AS MESSAGE,
               valid_from               AS VALID_FROM,
               valid_to                 AS VALID_TO,
               attachment_type          AS ATTACHMENT_TYPE,
               OCTET_LENGTH(attachment) AS ATTACHMENT_SIZE,
               user_filter              AS USER_FILTER,
               profile_filter           AS PROFILE_FILTER,
               station_filter           AS STATION_FILTER
        FROM  desktopfx_multicast
        ORDER BY valid_from
        LIMIT _multicasts_max;
END;
$BODY$ LANGUAGE plpgsql;
