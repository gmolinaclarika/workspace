DROP PROCEDURE IF EXISTS DESKTOPFX$MULTICAST_GET;

DELIMITER $$
CREATE PROCEDURE DESKTOPFX$MULTICAST_GET (
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
    OUT _VALID_FROM         DATETIME(3),
    OUT _VALID_TO           DATETIME(3),
    OUT _NAME               VARCHAR(200),
    OUT _MESSAGE            VARCHAR(2000),
    OUT _ATTACHMENT_TYPE    VARCHAR(200),
    OUT _ATTACHMENT         LONGBLOB
)
BEGIN
    -- Return Multicast properties
    SELECT  VALID_FROM,  VALID_TO,  NAME,  MESSAGE,  ATTACHMENT_TYPE,  ATTACHMENT 
    INTO   _VALID_FROM, _VALID_TO, _NAME, _MESSAGE, _ATTACHMENT_TYPE, _ATTACHMENT
    FROM  DESKTOPFX_MULTICAST
    WHERE ID = _MULTICAST_ID;
END$$
DELIMITER ;
