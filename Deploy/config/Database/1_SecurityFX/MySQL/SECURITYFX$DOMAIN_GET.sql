DROP PROCEDURE IF EXISTS SECURITYFX$DOMAIN_GET;

DELIMITER $$
CREATE PROCEDURE SECURITYFX$DOMAIN_GET (
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
    IN  _DOMAIN_NAME        VARCHAR(100),
    -- General Properties ---------------
    OUT _NAME               VARCHAR(100),
    OUT _FUNCTION           VARCHAR(100),
    OUT _LOCATION           VARCHAR(100),
    OUT _TEXT1              VARCHAR(100),
    OUT _TEXT2              VARCHAR(100),
    OUT _TEXT3              VARCHAR(100),
    OUT _TEXT4              VARCHAR(100)
)
BEGIN
    DECLARE _MESSAGE_TEXT VARCHAR(200);

    -- Normalize specified domain name
    SET _DOMAIN_NAME = UPPER(RTRIM(_DOMAIN_NAME));

    -- Return the properties of specified domain
    SELECT
        -- General Properties
        RTRIM(V_FAM_FAMILIA),
        RTRIM(V_FAM_NOMBRE_USUARIO),
        RTRIM(V_FAM_UBICACION),
        RTRIM(V_FAM_TEXTO1),
        RTRIM(V_FAM_TEXTO2),
        RTRIM(V_FAM_TEXTO3),
        RTRIM(V_FAM_TEXTO4)
    INTO
        -- General Properties
        _NAME,
        _FUNCTION,
        _LOCATION,
        _TEXT1,
        _TEXT2,
        _TEXT3,
        _TEXT4
    FROM   EcuACCFAM
    WHERE  V_FAM_FAMILIA = _DOMAIN_NAME;
    IF (FOUND_ROWS() = 0) THEN
        SET _MESSAGE_TEXT = CONCAT('Dominio no está definido: ', _DOMAIN_NAME);
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = _MESSAGE_TEXT;
    END IF;
END$$
DELIMITER ;
