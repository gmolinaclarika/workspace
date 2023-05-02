DROP PROCEDURE IF EXISTS MCASTADMIN$MULTICAST_DIR;

DELIMITER $$
CREATE PROCEDURE MCASTADMIN$MULTICAST_DIR (
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
    IN  _MULTICASTS_MAX     INTEGER
)
BEGIN
    -- #ResultSet ENTRY ENTRIES
    --    #Column ID                DECIMAL
    --    #Column NAME              VARCHAR
    --    #Column MESSAGE           VARCHAR
    --    #Column VALID_FROM        DATETIME
    --    #Column VALID_TO          DATETIME
    --    #Column ATTACHMENT_TYPE   VARCHAR
    --    #Column ATTACHMENT_SIZE   INTEGER
    --    #Column USER_FILTER       VARCHAR
    --    #Column PROFILE_FILTER    INTEGER
    --    #Column STATION_FILTER    VARCHAR
    -- #EndResultSet
    SELECT
           ID                       AS ID,
           NAME                     AS NAME,
           MESSAGE                  AS MESSAGE,
           VALID_FROM               AS VALID_FROM,
           VALID_TO                 AS VALID_TO,
           ATTACHMENT_TYPE          AS ATTACHMENT_TYPE,
           LENGTH(ATTACHMENT)       AS ATTACHMENT_SIZE,
           USER_FILTER              AS USER_FILTER,
           PROFILE_FILTER           AS PROFILE_FILTER,
           STATION_FILTER           AS STATION_FILTER
    FROM  DESKTOPFX_MULTICAST
    ORDER BY VALID_FROM
    LIMIT _MULTICASTS_MAX;
END$$
DELIMITER ;
