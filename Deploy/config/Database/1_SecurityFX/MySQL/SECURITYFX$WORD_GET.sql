DROP PROCEDURE IF EXISTS SECURITYFX$WORD_GET;

DELIMITER $$
CREATE PROCEDURE SECURITYFX$WORD_GET (
-- -----------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
-- -----------------------------------------------------------------------------
    IN  _USER_CODE      VARCHAR(100),
    IN  _PROFILE_CODE   INTEGER,
    IN  _STATION_CODE   VARCHAR(100),
    OUT _USER_WORD      VARCHAR(100)
)
BEGIN
    -- Obtain the user password
    SELECT PASSWORD INTO _USER_WORD
    FROM  EcuACCUSU
    WHERE USU_CODIGO = _USER_CODE;
END$$
DELIMITER ;
