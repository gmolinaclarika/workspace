IF OBJECT_ID(N'dbo.SECURITYFX$USER_DEL', N'P') IS NOT NULL
    DROP PROCEDURE dbo.SECURITYFX$USER_DEL
GO

CREATE PROCEDURE dbo.SECURITYFX$USER_DEL
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
    @USER_CODE          NVARCHAR(100)
AS
BEGIN
    DECLARE @AUDIT_EVENT    INTEGER;
    DECLARE @AUDIT_MESSAGE  NVARCHAR(100);

    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON;

    -- Cannot delete ADMIN user
    SET @USER_CODE = UPPER(RTRIM(@USER_CODE));
    IF (@USER_CODE = 'ADMIN') BEGIN
        RAISERROR('No puede borrar el usuario: %s', 16, 1, @USER_CODE);
        RETURN;
    END;

    -- Delete all profiles of the user
    DELETE FROM dbo.EcuACCU2P
    WHERE CODIGO_ADI = @USER_CODE;

    -- Delete all capacities of the user
    DELETE FROM dbo.EcuACCC2U
    WHERE CODIGO_ADI = @USER_CODE;

    -- Delete the properties of the user
    DELETE FROM dbo.EcuACCUSU
    WHERE  USU_CODIGO = @USER_CODE;

    -- Generate an audit record
    SET @AUDIT_EVENT = 57;
    SET @AUDIT_MESSAGE = 'Usuario fue eliminado: ' + @USER_CODE;
    EXEC dbo.SECURITYFX$AUDIT_PUT
        @WSS_USER_CODE, @WSS_PROFILE_CODE,  @WSS_STATION_CODE,
        @AUDIT_EVENT, @AUDIT_MESSAGE;
END
GO
