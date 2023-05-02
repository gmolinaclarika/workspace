IF OBJECT_ID(N'dbo.EMP$BUSCAR_POR_RUT', N'P') IS NOT NULL 
    DROP PROCEDURE dbo.EMP$BUSCAR_POR_RUT
GO

CREATE PROCEDURE dbo.EMP$BUSCAR_POR_RUT
--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this fil
--------------------------------------------------------------------------------
    @RUT            NVARCHAR(10)
AS
BEGIN
    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON;

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
      WHERE RUT = @RUT;
END
GO
