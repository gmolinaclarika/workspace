DROP PROCEDURE IF EXISTS MCASTADMIN$MRESPONSE_GET;

DELIMITER $$
CREATE PROCEDURE MCASTADMIN$MRESPONSE_GET (
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
    IN  _MRESPONSE_ID       DECIMAL(19),
    OUT _MULTICAST_ID       DECIMAL(19),
    OUT _MESSAGE            VARCHAR(2000),
    OUT _STATION_CODE       VARCHAR(200),
    OUT _REQUEST_TIME       DATETIME(3),
    OUT _RESPONSE_TIME      DATETIME(3),
    OUT _ATTACHMENT_TYPE    VARCHAR(200),
    OUT _ATTACHMENT         LONGBLOB
)
BEGIN
    -- Return properties of Multicast Response
    SELECT
        MULTICAST_ID,
        MESSAGE,
        STATION_CODE,
        REQUEST_TIME,
        RESPONSE_TIME,
        ATTACHMENT_TYPE,
        ATTACHMENT
    INTO
        _MULTICAST_ID,
        _MESSAGE,
        _STATION_CODE,
        _REQUEST_TIME,
        _RESPONSE_TIME,
        _ATTACHMENT_TYPE,
        _ATTACHMENT
    FROM  DESKTOPFX_MRESPONSE
    WHERE ID = _MRESPONSE_ID;
END$$
DELIMITER ;
