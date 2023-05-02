DROP PROCEDURE IF EXISTS EMP$CREAR;

DELIMITER $$
CREATE PROCEDURE EMP$CREAR (
-- -----------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
-- -----------------------------------------------------------------------------
    IN  _NOMBRE         VARCHAR(50),
    IN  _PATERNO        VARCHAR(50),
    IN  _MATERNO        VARCHAR(50),
    IN  _RUT            VARCHAR(10),
    IN  _NACIMIENTO     DATETIME(3),
    IN  _SUELDO         DECIMAL(10),
    OUT _EMP_ID         DECIMAL(19)
)
BEGIN
    -- Insertamos el nuevo Empleado
    INSERT INTO EMPLEADOS (
        DEPT_ID, NOMBRE, PATERNO, MATERNO, RUT, NACIMIENTO, SUELDO
    ) VALUES (
        1, _NOMBRE, _PATERNO, _MATERNO, _RUT, _NACIMIENTO, _SUELDO
    );

    -- Retornamos el ID del nuevo Empleado
    SET _EMP_ID = LAST_INSERT_ID();
END$$
DELIMITER ;
