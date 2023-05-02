DROP PROCEDURE IF EXISTS SECURITYFX$CAPACITY_GET;

DELIMITER $$
CREATE PROCEDURE SECURITYFX$CAPACITY_GET (
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
    -- General Properties ---------------
    OUT _CODE               VARCHAR(100),
    OUT _NAME               VARCHAR(200),
    OUT _TYPE               INTEGER
)
BEGIN
    DECLARE _MESSAGE_TEXT VARCHAR(200);

    -- Normalize specified capacity name
    SET _CAPACITY_CODE = UPPER(RTRIM(_CAPACITY_CODE));

    -- Return the properties of specified capacity
    SELECT
        -- General Properties
        CAP_CODIGO,
        CAP_NOMBRE,
        CAP_TIPO
    INTO
        -- General Properties
        _CODE,
        _NAME,
        _TYPE
    FROM  EcuACCCAP
    WHERE CAP_CODIGO = _CAPACITY_CODE;
    IF (FOUND_ROWS() = 0) THEN
        SET _MESSAGE_TEXT = CONCAT('Capacidad no está definida: ', _CAPACITY_CODE);
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = _MESSAGE_TEXT;
    END IF;
END$$
DELIMITER ;
