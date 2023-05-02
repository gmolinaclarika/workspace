IF EXISTS(SELECT * FROM sysobjects WHERE name = 'desktopfx$word_set' AND type = 'P')
    DROP PROCEDURE desktopfx$word_set
GO

CREATE PROCEDURE desktopfx$word_set
--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------
    @USER_CODE                  NVARCHAR(100),
    @USER_WORD                  NVARCHAR(200),
    @UPDATED                    INTEGER OUTPUT
AS
BEGIN
    DECLARE @PASSWORD           CHAR(51)
    DECLARE @PSW_ULTIMAS_001    CHAR(51)
    DECLARE @PSW_ULTIMAS_002    CHAR(51)
    DECLARE @PSW_ULTIMAS_003    CHAR(51)
    DECLARE @PSW_ULTIMAS_004    CHAR(51)
    DECLARE @PSW_ULTIMAS_005    CHAR(51)
    DECLARE @PSW_ULTIMAS_006    CHAR(51)
    DECLARE @FEC_VIG_DESD       DECIMAL(8)
    DECLARE @FEC_VIG_HAST       DECIMAL(8)
    DECLARE @YYYYMMDD           DECIMAL(8)
    DECLARE @USU_ESTADO         CHAR(2)
    DECLARE @PSW_TIPO           CHAR(3)

    -- Set No Count
    SET NOCOUNT ON

    -- Obtain properties of specified user
    SELECT @PASSWORD        = PASSWORD,
           @PSW_ULTIMAS_001 = PSW_ULTIMAS_001,
           @PSW_ULTIMAS_002 = PSW_ULTIMAS_002,
           @PSW_ULTIMAS_003 = PSW_ULTIMAS_003,
           @PSW_ULTIMAS_004 = PSW_ULTIMAS_004,
           @PSW_ULTIMAS_005 = PSW_ULTIMAS_005,
           @PSW_ULTIMAS_006 = PSW_ULTIMAS_006,
           @FEC_VIG_DESD    = FEC_VIG_DESD,
           @FEC_VIG_HAST    = FEC_VIG_HAST,
           @USU_ESTADO      = USU_ESTADO,
           @PSW_TIPO        = PSW_TIPO
    FROM  dbo.EcuACCUSU
    WHERE USU_CODIGO = @USER_CODE
    IF (@@ROWCOUNT = 0) BEGIN
        RAISERROR 99999, 'Usuario no está definido'
        RETURN
    END

    -- Obtain current date in "YYYYMMDD" decimal format
    SELECT @YYYYMMDD = CONVERT(DECIMAL(8), CONVERT(VARCHAR(8), GETDATE(), 112))

    -- Check the user is working in valid date range
    IF (@YYYYMMDD < @FEC_VIG_DESD) OR (@YYYYMMDD > @FEC_VIG_HAST) BEGIN
        RAISERROR 99999, 'Usuario no autorizado en esta fecha'
        RETURN
    END

    -- Check the password can be changed (is not 'FIJ')
    IF (@PSW_TIPO != 'CAD') AND (@PSW_TIPO != 'NCA') BEGIN
        RAISERROR 99999, 'La contraseña no se puede cambiar porque está bloqueada'
        RETURN
    END

    -- Check the user is not disabled ('HA' = habilitado)
    IF (@USU_ESTADO != 'HA') BEGIN
        RAISERROR 99999, 'Usuario está deshabilitado'
        RETURN
    END

    -- Check new password has not been used before
    IF (@PASSWORD        = @USER_WORD)
    OR (@PSW_ULTIMAS_001 = @USER_WORD)
    OR (@PSW_ULTIMAS_002 = @USER_WORD)
    OR (@PSW_ULTIMAS_003 = @USER_WORD)
    OR (@PSW_ULTIMAS_004 = @USER_WORD)
    OR (@PSW_ULTIMAS_005 = @USER_WORD)
    OR (@PSW_ULTIMAS_006 = @USER_WORD) 
    BEGIN
        RAISERROR 99999, 'Contraseña ya se utilizó anteriormente'
        RETURN
    END

    -- Update user password info
    UPDATE dbo.EcuACCUSU
    SET    PSW_ULTIMAS_006 = PSW_ULTIMAS_005,
           PSW_ULTIMAS_005 = PSW_ULTIMAS_004,
           PSW_ULTIMAS_004 = PSW_ULTIMAS_003,
           PSW_ULTIMAS_003 = PSW_ULTIMAS_002,
           PSW_ULTIMAS_002 = PSW_ULTIMAS_001,
           PSW_ULTIMAS_001 = PASSWORD,
           PASSWORD        = @USER_WORD,
           PSW_VIG_DESD    = @YYYYMMDD,
           PSW_ESTADO      = 'VIG'
    WHERE  USU_CODIGO = @USER_CODE
    AND    USU_ESTADO = 'HA'
    AND    PSW_TIPO  IN ('CAD', 'NCA')
    AND    @YYYYMMDD BETWEEN FEC_VIG_DESD AND FEC_VIG_HAST
    IF (@@ROWCOUNT = 0) BEGIN
        RAISERROR 99999, 'No se pudo cambiar la contraseña'
        RETURN
    END

    -- User updated
    SELECT @UPDATED = 1
END
GO

sp_procxmode desktopfx$word_set, "anymode"
GO
