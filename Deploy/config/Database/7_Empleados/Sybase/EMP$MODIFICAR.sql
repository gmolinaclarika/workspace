IF EXISTS(SELECT * FROM sysobjects WHERE name = 'emp$modificar' AND type = 'P')
    DROP PROCEDURE emp$modificar
GO

CREATE PROCEDURE emp$modificar
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
    -- Set No Count
    SET NOCOUNT ON

    -- Modificamos el Empleado
    UPDATE dbo.EMPLEADOS
       SET NOMBRE     = @NOMBRE,
           PATERNO    = @PATERNO,
           MATERNO    = @MATERNO,
           RUT        = @RUT,
           NACIMIENTO = @NACIMIENTO,
           SUELDO     = @SUELDO
    WHERE  ID = @EMP_ID
END
GO

sp_procxmode emp$modificar, "anymode"
GO
