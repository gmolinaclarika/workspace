IF OBJECT_ID(N'dbo.DESKTOPFX$WORD_SET', N'P') IS NOT NULL 
    DROP PROCEDURE dbo.DESKTOPFX$WORD_SET
GO

CREATE PROCEDURE dbo.DESKTOPFX$WORD_SET
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
    DECLARE @PASSWORD           CHAR(51);
    DECLARE @PSW_ULTIMAS_001    CHAR(51);
    DECLARE @PSW_ULTIMAS_002    CHAR(51);
    DECLARE @PSW_ULTIMAS_003    CHAR(51);
    DECLARE @PSW_ULTIMAS_004    CHAR(51);
    DECLARE @PSW_ULTIMAS_005    CHAR(51);
    DECLARE @PSW_ULTIMAS_006    CHAR(51);
    DECLARE @FEC_VIG_DESD       DECIMAL(8);
    DECLARE @FEC_VIG_HAST       DECIMAL(8);
    DECLARE @YYYYMMDD           DECIMAL(8);
    DECLARE @USU_ESTADO         CHAR(2);
    DECLARE @PSW_TIPO           CHAR(3);

    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON;

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
    WHERE USU_CODIGO = @USER_CODE;
    IF (@@ROWCOUNT = 0) BEGIN
        RAISERROR('Usuario no está definido: %s', 16, 1, @USER_CODE);
        RETURN;
    END;

    -- Obtain current date in "YYYYMMDD" decimal format
    SET @YYYYMMDD = CONVERT(DECIMAL(8), CONVERT(VARCHAR(8), GETDATE(), 112));

    -- Check the user is working in valid date range
    IF (@YYYYMMDD < @FEC_VIG_DESD) OR (@YYYYMMDD > @FEC_VIG_HAST) BEGIN
        RAISERROR('Usuario no autorizado en esta fecha: %s', 16, 2, @USER_CODE);
        RETURN;
    END;

    -- Check the password can be changed (is not 'FIJ')
    IF (@PSW_TIPO != 'CAD') AND (@PSW_TIPO != 'NCA') BEGIN
        RAISERROR('La contraseña no se puede cambiar porque está bloqueada', 16, 3);
        RETURN;
    END;

    -- Check the user is not disabled ('HA' = habilitado)
    IF (@USU_ESTADO != 'HA') BEGIN
        RAISERROR('Usuario está deshabilitado: %s', 16, 4, @USER_CODE);
        RETURN;
    END;

    -- Check new password has not been used before
    IF (@PASSWORD        = @USER_WORD)
    OR (@PSW_ULTIMAS_001 = @USER_WORD)
    OR (@PSW_ULTIMAS_002 = @USER_WORD)
    OR (@PSW_ULTIMAS_003 = @USER_WORD)
    OR (@PSW_ULTIMAS_004 = @USER_WORD)
    OR (@PSW_ULTIMAS_005 = @USER_WORD)
    OR (@PSW_ULTIMAS_006 = @USER_WORD) 
    BEGIN
        RAISERROR('Contraseña ya se utilizó anteriormente', 16, 5);
        RETURN;
    END;

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
    AND    @YYYYMMDD BETWEEN FEC_VIG_DESD AND FEC_VIG_HAST;
    IF (@@ROWCOUNT = 0) BEGIN
        RAISERROR('No se pudo cambiar la contraseña de %s', 16, 6, @USER_CODE);
        RETURN;
    END;

    -- User updated
    SET @UPDATED = 1;
END;
GO
