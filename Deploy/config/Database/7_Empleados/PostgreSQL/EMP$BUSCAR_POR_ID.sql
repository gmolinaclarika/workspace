CREATE OR REPLACE FUNCTION emp$buscar_por_id (
    _emp_id             IN  DECIMAL,
    _empleados          OUT REFCURSOR
)
AS $BODY$
--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------
BEGIN
    -- #ResultSet @EMPLEADO EMPLEADOS
    --    #Column ID            DECIMAL
    --    #Column DEPT_ID       DECIMAL
    --    #Column NOMBRE        NVARCHAR
    --    #Column PATERNO       NVARCHAR
    --    #Column MATERNO       NVARCHAR
    --    #Column RUT           NVARCHAR
    --    #Column NACIMIENTO    DATETIME
    --    #Column SUELDO        DECIMAL
    -- #EndResultSet
    OPEN _empleados FOR
        SELECT  id              AS ID, 
                dept_id         AS DEPT_ID,
                RTRIM(nombre)   AS NOMBRE, 
                RTRIM(paterno)  AS PATERNO,
                RTRIM(materno)  AS MATERNO,
                rut             AS RUT,
                nacimiento      AS NACIMIENTO,
                sueldo          AS SUELDO
          FROM  empleados
          WHERE id = _emp_id;
END;
$BODY$ LANGUAGE plpgsql;
