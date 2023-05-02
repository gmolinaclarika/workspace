CREATE OR REPLACE FUNCTION mcastnews$items_get (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _valid_from         IN  TIMESTAMP,
    _items_max          IN  INTEGER,
    _items              OUT REFCURSOR
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
    -- #ResultSet ITEM ITEMS
    --    #Column ID                DECIMAL
    --    #Column VALID_FROM        DATETIME
    --    #Column MESSAGE           VARCHAR
    --    #Column ATTACHMENT_TYPE   NVARCHAR
    -- #EndResultSet
    OPEN _items FOR
        SELECT id               AS ID,
               valid_from       AS VALID_FROM,
               message          AS MESSAGE,
               attachment_type  AS ATTACHMENT_TYPE
        FROM   desktopfx_multicast
        WHERE  (_valid_from <= valid_from) AND (NOW() <= valid_to)
        AND    (user_filter    IS NULL OR user_filter    = _wss_user_code)
        AND    (profile_filter IS NULL OR profile_filter = _wss_profile_code)
        AND    (station_filter IS NULL OR station_filter = _wss_station_code)
        AND    name = 'news'
        ORDER BY valid_from DESC
        LIMIT _items_max;
END;
$BODY$ LANGUAGE plpgsql;
