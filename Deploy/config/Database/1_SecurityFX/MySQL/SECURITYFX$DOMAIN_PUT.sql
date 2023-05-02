DROP PROCEDURE IF EXISTS SECURITYFX$DOMAIN_PUT;

DELIMITER $$
CREATE PROCEDURE SECURITYFX$DOMAIN_PUT (
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
    IN  _FUNCTION           VARCHAR(100),
    IN  _LOCATION           VARCHAR(100),
    IN  _TEXT1              VARCHAR(100),
    IN  _TEXT2              VARCHAR(100),
    IN  _TEXT3              VARCHAR(100),
    IN  _TEXT4              VARCHAR(100),
    OUT _CREATED            INTEGER
)
BEGIN
    DECLARE _AUDIT_EVENT    INTEGER;
    DECLARE _AUDIT_MESSAGE  VARCHAR(100);

    -- Asume the domain exists
    SET _CREATED = 0;

    -- Normalize specified domain name
    SET _DOMAIN_NAME = UPPER(RTRIM(_DOMAIN_NAME));

    -- Update the properties of specified domain
    UPDATE EcuACCFAM
    SET    V_FAM_NOMBRE_USUARIO = IFNULL(_FUNCTION,''),
           V_FAM_UBICACION      = IFNULL(_LOCATION,''),
           V_FAM_TEXTO1         = IFNULL(_TEXT1,''),
           V_FAM_TEXTO2         = IFNULL(_TEXT2,''),
           V_FAM_TEXTO3         = IFNULL(_TEXT3,''),
           V_FAM_TEXTO4         = IFNULL(_TEXT4,'')
    WHERE  V_FAM_FAMILIA = _DOMAIN_NAME;

    -- Create domain if it didn't exist
    IF (ROW_COUNT() = 0) THEN
        INSERT INTO EcuACCFAM (
             V_FAM_FAMILIA
            ,V_FAM_NOMBRE_USUARIO
            ,V_FAM_UBICACION
            ,V_FAM_TEXTO1
            ,V_FAM_TEXTO2
            ,V_FAM_TEXTO3
            ,V_FAM_TEXTO4
        ) VALUES (
             _DOMAIN_NAME
            ,IFNULL(_FUNCTION,'')
            ,IFNULL(_LOCATION,'')
            ,IFNULL(_TEXT1,'')
            ,IFNULL(_TEXT2,'')
            ,IFNULL(_TEXT3,'')
            ,IFNULL(_TEXT4,'')
        );
        SET _CREATED = 1;
    END IF;

    -- Generate an audit record
    IF (_CREATED = 0) THEN
        SET _AUDIT_EVENT = 15;
        SET _AUDIT_MESSAGE = CONCAT('Familia fue modificada: ', _DOMAIN_NAME);
    ELSE
        SET _AUDIT_EVENT = 16;
        SET _AUDIT_MESSAGE = CONCAT('Familia fue creada: ', _DOMAIN_NAME);
    END IF;
    CALL SECURITYFX$AUDIT_PUT(
        _WSS_USER_CODE, _WSS_PROFILE_CODE, _WSS_STATION_CODE,
        _AUDIT_EVENT, _AUDIT_MESSAGE);
END$$
DELIMITER ;
