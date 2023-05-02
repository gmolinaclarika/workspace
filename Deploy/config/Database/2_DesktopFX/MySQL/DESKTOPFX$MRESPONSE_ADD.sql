DROP PROCEDURE IF EXISTS DESKTOPFX$MRESPONSE_ADD;

DELIMITER $$
CREATE PROCEDURE DESKTOPFX$MRESPONSE_ADD (
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
    IN  _REQUEST_TIME       DATETIME(3),
    IN  _MESSAGE            VARCHAR(2000),
    IN  _ATTACHMENT_TYPE    VARCHAR(200),
    IN  _ATTACHMENT         LONGBLOB,
    OUT _TRESPONSE_ID       DECIMAL(19)
)
BEGIN
    -- Add new Multicast Response data 
    INSERT INTO DESKTOPFX_MRESPONSE (
         MULTICAST_ID
        ,STATION_CODE
        ,REQUEST_TIME
        ,RESPONSE_TIME
        ,MESSAGE
        ,ATTACHMENT_TYPE
        ,ATTACHMENT
    ) VALUES (
         _MULTICAST_ID
        ,_WSS_STATION_CODE
        ,_REQUEST_TIME
        ,GETDATE()
        ,_MESSAGE
        ,_ATTACHMENT_TYPE
        ,_ATTACHMENT
    );

    -- Return Multicast Response ID
    SET _TRESPONSE_ID = LAST_INSERT_ID();
END$$
DELIMITER ;
