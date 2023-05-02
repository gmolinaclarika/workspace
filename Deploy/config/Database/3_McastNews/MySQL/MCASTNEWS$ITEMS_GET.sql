DROP PROCEDURE IF EXISTS MCASTNEWS$ITEMS_GET;

DELIMITER $$
CREATE PROCEDURE MCASTNEWS$ITEMS_GET (
-- -----------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
-- -----------------------------------------------------------------------------
    IN  _WSS_USER_CODE      VARCHAR(100),
    IN  _WSS_PROFILE_CODE   INTEGER,
    IN  _WSS_STATION_CODE   VARCHAR(100),
    -- ----------------------------------
    IN  _VALID_FROM         DATETIME(3),
    IN  _ITEMS_MAX          INTEGER
)
BEGIN
    -- #ResultSet ITEM ITEMS
    --    #Column ID                DECIMAL
    --    #Column VALID_FROM        DATETIME
    --    #Column MESSAGE           VARCHAR
    --    #Column ATTACHMENT_TYPE   VARCHAR
    -- #EndResultSet
    SELECT
           ID               AS ID,
           VALID_FROM       AS VALID_FROM,
           MESSAGE          AS MESSAGE,
           ATTACHMENT_TYPE  AS ATTACHMENT_TYPE
    FROM   DESKTOPFX_MULTICAST
    WHERE  (_VALID_FROM <= VALID_FROM) AND (NOW(3) <= VALID_TO)
    AND    (USER_FILTER    IS NULL OR USER_FILTER    = _WSS_USER_CODE)
    AND    (PROFILE_FILTER IS NULL OR PROFILE_FILTER = _WSS_PROFILE_CODE)
    AND    (STATION_FILTER IS NULL OR STATION_FILTER = _WSS_STATION_CODE)
    AND    NAME = 'news'
    ORDER BY VALID_FROM DESC
    LIMIT _ITEMS_MAX;
END$$
DELIMITER ;
