IF EXISTS(SELECT * FROM sysobjects WHERE name = 'emp$eliminar' AND type = 'P')
    DROP PROCEDURE emp$eliminar
GO

CREATE PROCEDURE emp$eliminar
--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------
    @EMP_ID         DECIMAL(19)
AS
BEGIN
    -- Set No Count
    SET NOCOUNT ON

    -- Eliminamos al Empleado
    DELETE dbo.EMPLEADOS
    WHERE  ID = @EMP_ID
END
GO

sp_procxmode emp$eliminar, "anymode"
GO
