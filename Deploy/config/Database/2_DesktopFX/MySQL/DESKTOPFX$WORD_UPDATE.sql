DROP PROCEDURE IF EXISTS DESKTOPFX$WORD_UPDATE;

DELIMITER $$
CREATE PROCEDURE DESKTOPFX$WORD_UPDATE (
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
    IN  _USER_WORD      VARCHAR(200),
    IN  _USER_STATE     VARCHAR(200),
    IN  _VALID_FROM     VARCHAR(200)
)
BEGIN
    -- Update user passwords info
    UPDATE EcuACCUSU 
    SET    PSW_ULTIMAS_006 = PSW_ULTIMAS_005,
           PSW_ULTIMAS_005 = PSW_ULTIMAS_004,
           PSW_ULTIMAS_004 = PSW_ULTIMAS_003,
           PSW_ULTIMAS_003 = PSW_ULTIMAS_002,
           PSW_ULTIMAS_002 = PSW_ULTIMAS_001,
           PSW_ULTIMAS_001 = PASSWORD,
           PASSWORD        = _USER_WORD,
           PSW_ESTADO      = _USER_STATE,
           PSW_VIG_DESD    = _VALID_FROM
    WHERE  USU_CODIGO = _USER_CODE;
END$$
DELIMITER ;
