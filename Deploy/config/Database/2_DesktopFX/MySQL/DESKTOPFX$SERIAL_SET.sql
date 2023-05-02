DROP PROCEDURE IF EXISTS DESKTOPFX$SERIAL_SET;

DELIMITER $$
CREATE PROCEDURE DESKTOPFX$SERIAL_SET (
-- -----------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
-- -----------------------------------------------------------------------------
    IN  _STATION_CODE   VARCHAR(200),
    IN  _SERIAL         VARCHAR(200)
)
BEGIN
    -- Update station serial info
    UPDATE EcuACCNET 
    SET    V_NET_SERIETERM = _SERIAL
    WHERE  V_NET_NOMBRE = _STATION_CODE;
END$$
DELIMITER ;
