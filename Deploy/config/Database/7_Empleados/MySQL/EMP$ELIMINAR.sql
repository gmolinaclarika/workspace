DROP PROCEDURE IF EXISTS EMP$ELIMINAR;

DELIMITER $$
CREATE PROCEDURE EMP$ELIMINAR (
-- -----------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
-- -----------------------------------------------------------------------------
    IN  _EMP_ID         DECIMAL(19)
)
BEGIN
    -- Eliminamos al Empleado
    DELETE FROM EMPLEADOS
    WHERE  ID = _EMP_ID;
END$$
DELIMITER ;
