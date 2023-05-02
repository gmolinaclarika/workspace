DROP PROCEDURE IF EXISTS SECURITYFX$CAPACITY_PUT;

DELIMITER $$
CREATE PROCEDURE SECURITYFX$CAPACITY_PUT (
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
    IN  _CAPACITY_CODE      VARCHAR(100),
    IN  _NAME               VARCHAR(200),
    IN  _TYPE               INTEGER,
    OUT _CREATED            INTEGER
)
BEGIN
    DECLARE _AUDIT_EVENT    INTEGER;
    DECLARE _AUDIT_MESSAGE  VARCHAR(100);

    -- Asume the domain exists
    SET _CREATED = 0;

    -- Normalize specified capacity name
    SET _CAPACITY_CODE = UPPER(RTRIM(_CAPACITY_CODE));

    -- Update the properties of specified capacity
    UPDATE EcuACCCAP
    SET    CAP_NOMBRE = _NAME,
           CAP_TIPO   = _TYPE
    WHERE  CAP_CODIGO = _CAPACITY_CODE;

    -- Create capacity if it didn't exist
    IF (ROW_COUNT() = 0) THEN
        INSERT INTO EcuACCCAP (
             CAP_CODIGO
            ,CAP_NOMBRE
            ,CAP_TIPO
        ) VALUES (
             _CAPACITY_CODE
            ,_NAME
            ,_TYPE
        );
        SET _CREATED = 1;
    END IF;

    -- Generate an audit record
    IF (_CREATED = 0) THEN
        SET _AUDIT_EVENT = 15;
        SET _AUDIT_MESSAGE = CONCAT('Capacidad fue modificada: ', _CAPACITY_CODE);
    ELSE
        SET _AUDIT_EVENT = 16;
        SET _AUDIT_MESSAGE = CONCAT('Capacidad fue creada: ', _CAPACITY_CODE);
    END IF;
    CALL SECURITYFX$AUDIT_PUT(
        _WSS_USER_CODE, _WSS_PROFILE_CODE, _WSS_STATION_CODE,
        _AUDIT_EVENT, _AUDIT_MESSAGE);
END$$
DELIMITER ;
