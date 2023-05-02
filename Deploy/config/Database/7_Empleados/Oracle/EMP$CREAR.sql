CREATE OR REPLACE PROCEDURE EMP$CREAR
--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------
(
    NOMBRE$         IN      NVARCHAR2,
    PATERNO$        IN      NVARCHAR2,
    MATERNO$        IN      NVARCHAR2,
    RUT$            IN      NVARCHAR2,
    NACIMIENTO$     IN      TIMESTAMP,
    SUELDO$         IN      DECIMAL,
    EMP_ID$         OUT     DECIMAL
)
AS
    DEPT_ID$        EMPLEADOS.DEPT_ID%TYPE  := 0;
    NOMBRE$$        EMPLEADOS.NOMBRE%TYPE   := RTRIM(NOMBRE$);
    PATERNO$$       EMPLEADOS.PATERNO%TYPE  := RTRIM(PATERNO$);
    MATERNO$$       EMPLEADOS.MATERNO%TYPE  := RTRIM(MATERNO$);
    RUT$$           EMPLEADOS.RUT%TYPE      := RTRIM(RUT$);
BEGIN
    -- Verificamos el Nombre del Empleado
    IF (NOMBRE$$ IS NULL) OR (PATERNO$$ IS NULL) OR (MATERNO$$ IS NULL) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Nombre del Empleado es inválido');
    END IF;

    -- Verificamos el RUT del Empleado
    IF (RUT$$ IS NULL) THEN
        RAISE_APPLICATION_ERROR(-20001, 'RUT del Empleado es inválido');
    END IF;

    -- Insertamos el nuevo Empleado
    INSERT INTO EMPLEADOS
        (ID, DEPT_ID, NOMBRE, PATERNO, MATERNO, RUT,  NACIMIENTO, SUELDO)
    VALUES
        (EMPLEADOS_SEQ.NEXTVAL, DEPT_ID$, NOMBRE$$, PATERNO$$, MATERNO$$, RUT$$, NACIMIENTO$, SUELDO$)
    RETURNING
        ID INTO EMP_ID$;
END EMP$CREAR;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
