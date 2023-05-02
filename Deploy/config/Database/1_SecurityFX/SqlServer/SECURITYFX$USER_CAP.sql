IF OBJECT_ID(N'dbo.SECURITYFX$USER_CAP', N'P') IS NOT NULL 
    DROP PROCEDURE dbo.SECURITYFX$USER_CAP
GO

CREATE PROCEDURE dbo.SECURITYFX$USER_CAP
--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------
    @WSS_USER_CODE      NVARCHAR(100),
    @WSS_PROFILE_CODE   INTEGER,
    @WSS_STATION_CODE   NVARCHAR(100),
    ----------------------------------
    @USER_CODE          NVARCHAR(100),
    @CAPACITY_CODE      NVARCHAR(100),
    @CAPACITY_VALUE     NVARCHAR(100),
    @CAPACITY_STATE     NVARCHAR(100)
AS
BEGIN
    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON;

    -- Add, modify or remove the user capacity
    IF (@CAPACITY_STATE = 'A') BEGIN
        INSERT INTO dbo.EcuACCC2U (CODIGO_ADI, CAP_CODIGO, CAP_VALOR) 
        VALUES (@USER_CODE, @CAPACITY_CODE, @CAPACITY_VALUE);
    END 
    ELSE IF (@CAPACITY_STATE = 'M') BEGIN
        UPDATE dbo.EcuACCC2U
        SET    CAP_VALOR = @CAPACITY_VALUE
        WHERE  CODIGO_ADI = @USER_CODE
        AND    CAP_CODIGO = @CAPACITY_CODE;
    END 
    ELSE IF (@CAPACITY_STATE = 'R') BEGIN
        DELETE FROM dbo.EcuACCC2U
        WHERE  CODIGO_ADI = @USER_CODE
        AND    CAP_CODIGO = @CAPACITY_CODE;
    END 
    ELSE BEGIN
        RAISERROR('Capacidad en estado inválido: %s', 16, 1, @CAPACITY_STATE);
        RETURN;
    END;
END
GO
