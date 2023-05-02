IF OBJECT_ID(N'dbo.EMP$CREAR', N'P') IS NOT NULL 
    DROP PROCEDURE dbo.EMP$CREAR
GO

CREATE PROCEDURE dbo.EMP$CREAR
--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------
    @NOMBRE         NVARCHAR(50),
    @PATERNO        NVARCHAR(50),
    @MATERNO        NVARCHAR(50),
    @RUT            NVARCHAR(10),
    @NACIMIENTO     DATETIME,
    @SUELDO         DECIMAL(10),
    @EMP_ID         DECIMAL(19)     OUTPUT
AS
BEGIN
    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON;

    -- Insertamos el nuevo Empleado
    INSERT INTO dbo.EMPLEADOS (
        DEPT_ID, NOMBRE, PATERNO, MATERNO, RUT, NACIMIENTO, SUELDO
    ) VALUES (
        0, @NOMBRE, @PATERNO, @MATERNO, @RUT, @NACIMIENTO, @SUELDO
    );

    -- Retornamos el ID del nuevo Empleado
    SET @EMP_ID = SCOPE_IDENTITY();
END
GO
