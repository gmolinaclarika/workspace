IF EXISTS(SELECT * FROM sysobjects WHERE name = 'emp$buscar_por_nombre' AND type = 'P')
    DROP PROCEDURE emp$buscar_por_nombre
GO

CREATE PROCEDURE emp$buscar_por_nombre
--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this fil
--------------------------------------------------------------------------------
    @NOMBRE         NVARCHAR(50),
    @PATERNO        NVARCHAR(50),
    @MATERNO        NVARCHAR(50)
AS
BEGIN
    -- Set No Count
    SET NOCOUNT ON

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
    SELECT  ID                  AS ID,
            DEPT_ID             AS DEPT_ID,
            RTRIM(NOMBRE)       AS NOMBRE,
            RTRIM(PATERNO)      AS PATERNO,
            RTRIM(MATERNO)      AS MATERNO,
            RUT                 AS RUT,
            NACIMIENTO          AS NACIMIENTO,
            SUELDO              AS SUELDO
      FROM  dbo.EMPLEADOS
      WHERE NOMBRE  LIKE RTRIM(@NOMBRE) + '%'
        AND PATERNO LIKE RTRIM(@PATERNO) + '%'
        AND MATERNO LIKE RTRIM(@MATERNO) + '%'
END
GO

sp_procxmode emp$buscar_por_nombre, "anymode"
GO
