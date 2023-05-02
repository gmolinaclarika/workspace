DROP PROCEDURE IF EXISTS SECURITYFX$AUDITS_GET;

DELIMITER $$
CREATE PROCEDURE SECURITYFX$AUDITS_GET (
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
    IN  _DATE_TIME_FROM     VARCHAR(100),
    IN  _DATE_TIME_TO       VARCHAR(100),
    IN  _USER_CODE          VARCHAR(100),
    IN  _PROFILE_CODE       INTEGER,
    IN  _TERMINAL_NAME      VARCHAR(100),
    IN  _EVENT_CODE         INTEGER,
    IN  _AUDITS_MAX         INTEGER
)
BEGIN
    -- #ResultSet AUDIT AUDITS
    --    #Column DATE_TIME         VARCHAR
    --    #Column USER_CODE         VARCHAR
    --    #Column PROFILE_CODE      INTEGER
    --    #Column TERMINAL_NAME     VARCHAR
    --    #Column EVENT_CODE        INTEGER
    --    #Column MESSAGE           VARCHAR
    -- #EndResultSet
    SELECT
           RTRIM(V_ECULOG_HORA)         AS DATE_TIME,
           RTRIM(V_ECULOG_CODIGO_ADI)   AS USER_CODE,
           V_ECULOG_CODIGO_ECU          AS PROFILE_CODE,
           RTRIM(V_ECULOG_TERMINAL)     AS TERMINAL_NAME,
           V_ECULOG_CODIGO_MSG          AS EVENT_CODE,
           RTRIM(V_ECULOG_MENSAJE)      AS MESSAGE
    FROM  EcuACCLOG
    WHERE V_ECULOG_HORA BETWEEN _DATE_TIME_FROM AND _DATE_TIME_TO
    AND   (_USER_CODE     IS NULL OR _USER_CODE = V_ECULOG_CODIGO_ADI)
    AND   (_PROFILE_CODE  IS NULL OR _PROFILE_CODE = V_ECULOG_CODIGO_ECU)
    AND   (_TERMINAL_NAME IS NULL OR _TERMINAL_NAME = V_ECULOG_TERMINAL)
    AND   (_EVENT_CODE    IS NULL OR _EVENT_CODE = V_ECULOG_CODIGO_MSG)
    ORDER BY V_ECULOG_HORA DESC
    LIMIT _AUDITS_MAX;
END$$
DELIMITER ;
