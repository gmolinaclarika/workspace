CREATE OR REPLACE FUNCTION desktopfx$multicast_dir (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _valid_from         IN  TIMESTAMP,
    _multicasts_max     IN  INTEGER,
    _receive_time       OUT TIMESTAMP,
    _transmit_time      OUT TIMESTAMP,
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
    -- Initialize receive time
    _receive_time := NOW();

    -- Update last user poll date
    UPDATE desktopfx_user
    SET    last_poll = _receive_time
    WHERE  user_code = _wss_user_code;

    -- #ResultSet ITEM ITEMS
    --   #Column  ID                DECIMAL
    --   #Column  NAME              VARCHAR
    --   #Column  MESSAGE           VARCHAR
    --   #Column  VALID_FROM        DATETIME
    --   #Column  VALID_TO          DATETIME
    --   #Column  ATTACHMENT_TYPE   VARCHAR
    -- #EndResultSet
    OPEN _multicasts FOR
        SELECT id                   AS ID,
               name                 AS NAME,
               message              AS MESSAGE,
               valid_from           AS VALID_FROM,
               valid_to             AS VALID_TO,
               attachment_type      AS ATTACHMENT_TYPE
        FROM   desktopfx_multicast
        WHERE  valid_from > _valid_from
        AND    (_receive_time BETWEEN valid_from AND valid_to)
        AND    ((profile_filter IS NULL) OR (profile_filter = _wss_profile_code) OR (profile_filter < 0 AND _wss_profile_code != -profile_filter))
        AND    ((user_filter IS NULL) OR (user_filter = _wss_user_code) OR (LEFT(user_filter,1) = '!' AND _wss_user_code != SUBSTRING(user_filter from 2)))
        AND    ((station_filter IS NULL) OR (station_filter = _wss_station_code) OR (LEFT(station_filter,1) = '!' AND _wss_station_code != SUBSTRING(station_filter from 2)))
        ORDER BY valid_from
        LIMIT _multicasts_max;

    -- Initialize transmit time
    _transmit_time := NOW();
END;
$BODY$ LANGUAGE plpgsql;
