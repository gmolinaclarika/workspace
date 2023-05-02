DROP PROCEDURE IF EXISTS MCASTADMIN$MRESPONSE_DIR;

DELIMITER $$
CREATE PROCEDURE MCASTADMIN$MRESPONSE_DIR (
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
    IN  _MULTICAST_ID       DECIMAL(19),
    IN  _MRESPONSES_MAX     INTEGER
)
BEGIN
    -- #ResultSet ENTRY ENTRIES
    --    #Column ID                DECIMAL
    --    #Column MESSAGE           VARCHAR
    --    #Column STATION_CODE      VARCHAR
    --    #Column REQUEST_TIME      DATETIME
    --    #Column RESPONSE_TIME     DATETIME
    --    #Column ATTACHMENT_TYPE   VARCHAR
    --    #Column ATTACHMENT_SIZE   INTEGER
    -- #EndResultSet
    SELECT
           ID                       AS ID,
           MESSAGE                  AS MESSAGE,
           STATION_CODE             AS STATION_CODE,
           REQUEST_TIME             AS REQUEST_TIME,
           RESPONSE_TIME            AS RESPONSE_TIME,
           ATTACHMENT_TYPE          AS ATTACHMENT_TYPE,
           LENGTH(ATTACHMENT)       AS ATTACHMENT_SIZE
    FROM  DESKTOPFX_MRESPONSE
    WHERE MULTICAST_ID = _MULTICAST_ID
    ORDER BY RESPONSE_TIME
    LIMIT _MRESPONSES_MAX;
END$$
DELIMITER ;
