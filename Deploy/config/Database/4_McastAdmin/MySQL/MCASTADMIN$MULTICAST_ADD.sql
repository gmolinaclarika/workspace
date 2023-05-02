DROP PROCEDURE IF EXISTS MCASTADMIN$MULTICAST_ADD;

DELIMITER $$
CREATE PROCEDURE MCASTADMIN$MULTICAST_ADD (
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
    IN  _NAME               VARCHAR(200),
    IN  _MESSAGE            VARCHAR(2000),
    IN  _VALID_FROM         DATETIME(3),
    IN  _VALID_TO           DATETIME(3),
    IN  _USER_FILTER        VARCHAR(200),
    IN  _PROFILE_FILTER     INTEGER,
    IN  _STATION_FILTER     VARCHAR(200),
    IN  _ATTACHMENT_TYPE    VARCHAR(200),
    IN  _ATTACHMENT         LONGBLOB,
    OUT _NEW_MULTICAST_ID   DECIMAL(19)
)
BEGIN
    -- Create new Multicast instance
    INSERT INTO DESKTOPFX_MULTICAST (
        NAME, MESSAGE, VALID_FROM, VALID_TO, USER_FILTER,
        PROFILE_FILTER, STATION_FILTER, ATTACHMENT_TYPE, ATTACHMENT
    ) VALUES (
        _NAME, _MESSAGE, _VALID_FROM, _VALID_TO, _USER_FILTER,
        _PROFILE_FILTER, _STATION_FILTER, _ATTACHMENT_TYPE, _ATTACHMENT
    );

    -- Return the ID of the new Multicast
    SET _NEW_MULTICAST_ID = LAST_INSERT_ID();
END$$
DELIMITER ;
