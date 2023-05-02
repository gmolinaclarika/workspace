DROP PROCEDURE IF EXISTS MCASTADMIN$MULTICAST_DEL;

DELIMITER $$
CREATE PROCEDURE MCASTADMIN$MULTICAST_DEL (
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
    IN  _MULTICAST_ID       DECIMAL(19)
)
BEGIN
    -- Delete the Multicast Responses
    DELETE FROM DESKTOPFX_MRESPONSE
    WHERE  MULTICAST_ID = _MULTICAST_ID;

    -- Delete the Multicast itself
    DELETE FROM DESKTOPFX_MULTICAST
    WHERE  ID = _MULTICAST_ID;
END$$
DELIMITER ;
