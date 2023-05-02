IF OBJECT_ID(N'dbo.DESKTOPFX$EMAIL_GET', N'P') IS NOT NULL
    DROP PROCEDURE dbo.DESKTOPFX$EMAIL_GET
GO

CREATE PROCEDURE dbo.DESKTOPFX$EMAIL_GET
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
    DECLARE @USU_ESTADO NCHAR(2);
    DECLARE @PSW_TIPO   NCHAR(3);

    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON;

    -- Obtain properties of specified user
    SELECT @USU_ESTADO  = USU_ESTADO,
           @PSW_TIPO    = PSW_TIPO,
           @EMAIL_ADDR  = RTRIM(EMAIL)
    FROM   dbo.EcuACCUSU
    WHERE  USU_CODIGO = @USER_CODE;
    IF (@@ROWCOUNT = 0) BEGIN
        RAISERROR('Usuario especificado no está definido', 16, 1);
        RETURN;
    END;

    -- Check the user is not disabled ('HA'=habilitado)
    IF (@USU_ESTADO != 'HA') BEGIN
        RAISERROR('Usuario especificado no está habilitado', 16, 2);
        RETURN;
    END;

    -- Check user can change password ('CAD'=caducado,'NCA'=no-caducado)
    IF (@PSW_TIPO != 'CAD' AND @PSW_TIPO != 'NCA') BEGIN
        RAISERROR('Usuario no puede cambiar la contraseña', 16, 3);
        RETURN;
    END;

    -- Check the user has an E-mail address
    IF (LEN(@EMAIL_ADDR) = 0) BEGIN
        RAISERROR('Usuario no tiene una dirección de correo', 16, 4);
        RETURN;
    END;
END;
GO
