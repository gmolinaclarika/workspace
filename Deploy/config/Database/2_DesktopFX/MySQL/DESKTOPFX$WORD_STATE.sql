DROP PROCEDURE IF EXISTS DESKTOPFX$WORD_STATE;

DELIMITER $$
CREATE PROCEDURE DESKTOPFX$WORD_STATE (
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
    IN  _PWD_STATE      VARCHAR(200)
)
BEGIN
    -- Update user expiration info
    UPDATE EcuACCUSU
    SET    PSW_ESTADO = _PWD_STATE
    WHERE  USU_CODIGO = _USER_CODE;
END$$
DELIMITER ;
