DROP PROCEDURE IF EXISTS SECURITYFX$AUDIT_PUT;

DELIMITER $$
CREATE PROCEDURE SECURITYFX$AUDIT_PUT (
-- -----------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
-- -----------------------------------------------------------------------------
    IN  _USER_CODE      VARCHAR(100),
    IN  _PROFILE_CODE   INTEGER,
    IN  _STATION_CODE   VARCHAR(100),
    IN  _EVENT_CODE     INTEGER,
    IN  _MESSAGE        VARCHAR(100)
)
BEGIN
    INSERT INTO EcuACCLOG (
         V_ECULOG_HORA
        ,V_ECULOG_CODIGO_ADI
        ,V_ECULOG_CODIGO_ECU
        ,V_ECULOG_TERMINAL
        ,V_ECULOG_CODIGO_MSG
        ,V_ECULOG_MENSAJE
    ) VALUES (
         DATE_FORMAT(NOW(6), '%Y-%m-%d:%T.%f')
        ,IFNULL(_USER_CODE, '?')
        ,IFNULL(_PROFILE_CODE, 9999999)
        ,IFNULL(_STATION_CODE, '?')
        ,IFNULL(_EVENT_CODE, 9999)
        ,IFNULL(_MESSAGE, '?')
    );
END$$
DELIMITER ;
