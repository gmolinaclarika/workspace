CREATE OR REPLACE PROCEDURE EMP$BUSCAR_POR_NOMBRE
--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this fil
--------------------------------------------------------------------------------
(
    NOMBRE$     IN      NVARCHAR2,
    PATERNO$    IN      NVARCHAR2,
    MATERNO$    IN      NVARCHAR2,
    EMPLEADOS$  OUT     SYS_REFCURSOR
)
AS
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
    OPEN EMPLEADOS$ FOR
        SELECT  ID              AS ID, 
                DEPT_ID         AS DEPT_ID,
                RTRIM(NOMBRE)   AS NOMBRE, 
                RTRIM(PATERNO)  AS PATERNO,
                RTRIM(MATERNO)  AS MATERNO,
                RUT             AS RUT,
                NACIMIENTO      AS NACIMIENTO,
                SUELDO          AS SUELDO
          FROM  EMPLEADOS
          WHERE NOMBRE  LIKE RTRIM(NOMBRE$)  || '%'
            AND PATERNO LIKE RTRIM(PATERNO$) || '%'
            AND MATERNO LIKE RTRIM(MATERNO$) || '%';
END EMP$BUSCAR_POR_NOMBRE;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
