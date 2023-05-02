IF EXISTS(SELECT * FROM sysobjects WHERE name = 'desktopfx$email_get' AND type = 'P')
    DROP PROCEDURE desktopfx$email_get
GO

CREATE PROCEDURE desktopfx$email_get
--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------
    @USER_CODE          NVARCHAR(200),
    @EMAIL_ADDR         NVARCHAR(200)   OUTPUT
AS
BEGIN
    DECLARE @USU_ESTADO CHAR(2)
    DECLARE @PSW_TIPO   CHAR(3)

    -- Set No Count
    SET NOCOUNT ON

    -- Obtain properties of specified user
    SELECT @USU_ESTADO  = USU_ESTADO,
           @PSW_TIPO    = PSW_TIPO,
           @EMAIL_ADDR  = RTRIM(EMAIL)
    FROM   dbo.EcuACCUSU
    WHERE  USU_CODIGO = @USER_CODE
    IF (@@ROWCOUNT = 0) BEGIN
        RAISERROR 99999, 'Usuario especificado no está definido'
        RETURN
    END

    -- Check the user is not disabled ('HA'=habilitado)
    IF (@USER_STATE != 'HA') BEGIN
        RAISERROR 99999, 'Usuario especificado no está habilitado'
        RETURN
    END

    -- Check user can change password ('CAD'=caducado,'NCA'=no-caducado)
    IF (@PSW_TIPO != 'CAD' AND @PSW_TIPO != 'NCA') BEGIN
        RAISERROR 99999, 'Usuario no puede cambiar la contraseña'
        RETURN
    END

    -- Check the user has an E-mail address
    IF (LEN(@EMAIL_ADDR) = 0) BEGIN
        RAISERROR 99999, 'Usuario no tiene una dirección de correo'
        RETURN
    END
END
GO

sp_procxmode desktopfx$email_get, "anymode"
GO
