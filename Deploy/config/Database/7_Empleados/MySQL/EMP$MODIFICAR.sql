DROP PROCEDURE IF EXISTS EMP$MODIFICAR;

DELIMITER $$
CREATE PROCEDURE EMP$MODIFICAR (
-- -----------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
-- -----------------------------------------------------------------------------
    IN  _EMP_ID         DECIMAL(19),
    IN  _NOMBRE         VARCHAR(50),
    IN  _PATERNO        VARCHAR(50),
    IN  _MATERNO        VARCHAR(50),
    IN  _RUT            VARCHAR(10),
    IN  _NACIMIENTO     DATETIME(3),
    IN  _SUELDO         DECIMAL(10)
)
BEGIN
    -- Modificamos el Empleado
    UPDATE EMPLEADOS
       SET NOMBRE     = _NOMBRE,
           PATERNO    = _PATERNO,
           MATERNO    = _MATERNO,
           RUT        = _RUT,
           NACIMIENTO = _NACIMIENTO,
           SUELDO     = _SUELDO
    WHERE  ID = _EMP_ID;
END$$
DELIMITER ;
