DROP PROCEDURE IF EXISTS DESKTOPFX$MULTICAST_DIR;

DELIMITER $$
CREATE PROCEDURE DESKTOPFX$MULTICAST_DIR (
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
    IN  _MULTICASTS_MAX     INTEGER,
    OUT _RECEIVE_TIME       DATETIME(3),
    OUT _TRANSMIT_TIME      DATETIME(3)
)
BEGIN
    -- Initialize receive time
    SET _RECEIVE_TIME = NOW(3);

    -- Update last user poll date
    UPDATE DESKTOPFX_USER
    SET    LAST_POLL = _RECEIVE_TIME
    WHERE  USER_CODE = _WSS_USER_CODE;

    -- #ResultSet ITEM ITEMS
    --   #Column  ID                DECIMAL
    --   #Column  NAME              VARCHAR
    --   #Column  MESSAGE           VARCHAR
    --   #Column  VALID_FROM        DATETIME
    --   #Column  VALID_TO          DATETIME
    --   #Column  ATTACHMENT_TYPE   VARCHAR
    -- #EndResultSet
    SELECT
           ID                       AS ID,
           NAME                     AS NAME,
           MESSAGE                  AS MESSAGE,
           VALID_FROM               AS VALID_FROM,
           VALID_TO                 AS VALID_TO,
           ATTACHMENT_TYPE          AS ATTACHMENT_TYPE
    FROM   DESKTOPFX_MULTICAST
    WHERE  VALID_FROM > _VALID_FROM
    AND    (_RECEIVE_TIME BETWEEN VALID_FROM AND VALID_TO)
    AND    ((PROFILE_FILTER IS NULL) OR (PROFILE_FILTER = _WSS_PROFILE_CODE) OR (PROFILE_FILTER < 0 AND _WSS_PROFILE_CODE != -PROFILE_FILTER))
    AND    ((USER_FILTER IS NULL) OR (USER_FILTER = _WSS_USER_CODE) OR (LEFT(USER_FILTER,1) = '!' AND _WSS_USER_CODE != SUBSTR(USER_FILTER FROM 2)))
    AND    ((STATION_FILTER IS NULL) OR (STATION_FILTER = WSS_STATION_CODE) OR (LEFT(STATION_FILTER,1) = '!' AND _WSS_STATION_CODE != SUBSTR(STATION_FILTER FROM 2)))
    ORDER BY VALID_FROM
    LIMIT _MULTICASTS_MAX;

    -- Initialize transmit time
    SET _TRANSMIT_TIME = NOW(3);
END$$
DELIMITER ;
