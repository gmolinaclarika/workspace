DROP PROCEDURE IF EXISTS SECURITYFX$PROFILE_CAP;

DELIMITER $$
CREATE PROCEDURE SECURITYFX$PROFILE_CAP (
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
    IN  _PROFILE_CODE       INTEGER,
    IN  _CAPACITY_CODE      VARCHAR(100),
    IN  _CAPACITY_VALUE     VARCHAR(100),
    IN  _CAPACITY_STATE     VARCHAR(100)
)
BEGIN
    DECLARE _MESSAGE_TEXT VARCHAR(200);

    -- Add, modify or remove the profile capacity
    IF (_CAPACITY_STATE = 'A') THEN
        INSERT INTO EcuACCC2P (CODIGO_ECU, CAP_CODIGO, CAP_VALOR)
        VALUES (_PROFILE_CODE, _CAPACITY_CODE, _CAPACITY_VALUE);
    ELSEIF (_CAPACITY_STATE = 'M') THEN
        UPDATE EcuACCC2P
        SET    CAP_VALOR = _CAPACITY_VALUE
        WHERE  CODIGO_ECU = _PROFILE_CODE
        AND    CAP_CODIGO = _CAPACITY_CODE;
    ELSEIF (_CAPACITY_STATE = 'R') THEN
        DELETE FROM EcuACCC2P
        WHERE  CODIGO_ECU = _PROFILE_CODE
        AND    CAP_CODIGO = _CAPACITY_CODE;
    ELSE
        SET _MESSAGE_TEXT = CONCAT('Capacidad en estado inválido: ', _CAPACITY_STATE);
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = _MESSAGE_TEXT;
    END IF;
END$$
DELIMITER ;
