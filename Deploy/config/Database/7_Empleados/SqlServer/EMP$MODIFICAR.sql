IF OBJECT_ID(N'dbo.EMP$MODIFICAR', N'P') IS NOT NULL 
    DROP PROCEDURE dbo.EMP$MODIFICAR
GO

CREATE PROCEDURE dbo.EMP$MODIFICAR
--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------
    @EMP_ID         DECIMAL(19),
    @NOMBRE         NVARCHAR(50),
    @PATERNO        NVARCHAR(50),
    @MATERNO        NVARCHAR(50),
    @RUT            NVARCHAR(10),
    @NACIMIENTO     DATETIME,
    @SUELDO         DECIMAL(10)
AS
BEGIN
    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON;

    -- Modificamos el Empleado
    UPDATE dbo.EMPLEADOS
       SET NOMBRE     = @NOMBRE,
           PATERNO    = @PATERNO,
           MATERNO    = @MATERNO,
           RUT        = @RUT,
           NACIMIENTO = @NACIMIENTO,
           SUELDO     = @SUELDO
    WHERE  ID = @EMP_ID;
END
GO
