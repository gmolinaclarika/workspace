DROP PROCEDURE IF EXISTS DESKTOPFX$ERROR_SET;

DELIMITER $$
CREATE PROCEDURE DESKTOPFX$ERROR_SET (
-- -----------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
-- -----------------------------------------------------------------------------
    IN  _USER_CODE      VARCHAR(200),
    IN  _ERROR_COUNT    INTEGER,
    IN  _ERROR_DATE     VARCHAR(200)
)
BEGIN
    -- Update user error info
    UPDATE EcuACCUSU 
    SET    ERROR_LOGIN = _ERROR_COUNT,
           FEC_ERR_LOG = _ERROR_DATE
    WHERE  USU_CODIGO = _USER_CODE;
END$$
DELIMITER ;
