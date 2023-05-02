DROP PROCEDURE IF EXISTS DESKTOPFX$EMAIL_GET;

DELIMITER $$
CREATE PROCEDURE DESKTOPFX$EMAIL_GET (
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
    OUT _EMAIL_ADDR     VARCHAR(200)
)
BEGIN
    DECLARE _USU_ESTADO     CHAR(2);
    DECLARE _PSW_TIPO       CHAR(3);
    DECLARE _MESSAGE_TEXT   VARCHAR(200);

    -- Obtain properties of specified user
    SELECT USU_ESTADO, PSW_TIPO, RTRIM(EMAIL)
    INTO  _USU_ESTADO, _PSW_TIPO, _EMAIL_ADDR
    FROM   EcuACCUSU
    WHERE  USU_CODIGO = _USER_CODE;
    IF (FOUND_ROWS() = 0) THEN
        SET _MESSAGE_TEXT = 'Usuario especificado no está definido';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = _MESSAGE_TEXT;
    END IF;

    -- Check the user is not disabled ('HA'=habilitado)
    IF (_USU_ESTADO != 'HA') THEN
        SET _MESSAGE_TEXT = 'Usuario especificado no está habilitado';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = _MESSAGE_TEXT;
    END IF;

    -- Check user can change password ('CAD'=caducado,'NCA'=no-caducado)
    IF (_PSW_TIPO != 'CAD' AND _PSW_TIPO != 'NCA') THEN
        SET _MESSAGE_TEXT = 'Usuario no puede cambiar la contraseña';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = _MESSAGE_TEXT;
    END IF;

    -- Check the user has an E-mail address
    IF (LENGTH(_EMAIL_ADDR) = 0) THEN
        SET _MESSAGE_TEXT = 'Usuario no tiene una dirección de correo';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = _MESSAGE_TEXT;
    END IF;
END$$
DELIMITER ;
