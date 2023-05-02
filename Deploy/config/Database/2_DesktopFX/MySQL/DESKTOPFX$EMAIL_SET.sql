DROP PROCEDURE IF EXISTS DESKTOPFX$EMAIL_SET;

DELIMITER $$
CREATE PROCEDURE DESKTOPFX$EMAIL_SET (
-- -----------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
-- -----------------------------------------------------------------------------
    IN  _USER_CODE          VARCHAR(200),
    IN  _EMAIL_ADDR         VARCHAR(200),
    OUT _UPDATED            INTEGER
)
BEGIN
    -- Update user email info
    UPDATE EcuACCUSU 
    SET    EMAIL = _EMAIL_ADDR
    WHERE  USU_CODIGO = _USER_CODE
    AND    USU_ESTADO = 'HA'
    AND    PSW_TIPO IN ('CAD', 'NCA');

    -- Return TRUE if update successful
    IF (ROW_COUNT() = 1) THEN
        SET _UPDATED = 1;
    ELSE
        SET _UPDATED = 0;
    END IF;
END$$
DELIMITER ;
