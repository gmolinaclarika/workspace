IF OBJECT_ID(N'dbo.SECURITYFX$CAPACITY_PUT', N'P') IS NOT NULL 
    DROP PROCEDURE dbo.SECURITYFX$CAPACITY_PUT
GO

CREATE PROCEDURE dbo.SECURITYFX$CAPACITY_PUT
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
    @CAPACITY_CODE      NVARCHAR(100),
    @NAME               NVARCHAR(200),
    @TYPE               INTEGER,
    @CREATED            INTEGER OUT
AS
BEGIN
    DECLARE @AUDIT_EVENT    INTEGER;
    DECLARE @AUDIT_MESSAGE  NVARCHAR(100);

    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON;

    -- Asume the domain exists
    SET @CREATED = 0;

    -- Normalize specified capacity name
    SET @CAPACITY_CODE = UPPER(RTRIM(@CAPACITY_CODE));

    -- Update the properties of specified capacity
    UPDATE dbo.EcuACCCAP
    SET    CAP_NOMBRE = @NAME,
           CAP_TIPO   = @TYPE
    WHERE  CAP_CODIGO = @CAPACITY_CODE;

    -- Create capacity if it didn't exist
    IF (@@ROWCOUNT = 0) BEGIN
        INSERT INTO dbo.EcuACCCAP (
             CAP_CODIGO
            ,CAP_NOMBRE
            ,CAP_TIPO
        ) VALUES (
             @CAPACITY_CODE
            ,@NAME
            ,@TYPE
        );
        SET @CREATED = 1;
    END;

    -- Generate an audit record
    IF (@CREATED = 0) BEGIN
        SET @AUDIT_EVENT = 15;
        SET @AUDIT_MESSAGE = 'Capacidad fue modificada: ' + @CAPACITY_CODE;
    END
    ELSE BEGIN
        SET @AUDIT_EVENT = 16;
        SET @AUDIT_MESSAGE = 'Capacidad fue creada: ' + @CAPACITY_CODE;
    END;
    EXEC dbo.SECURITYFX$AUDIT_PUT
        @WSS_USER_CODE, @WSS_PROFILE_CODE, @WSS_STATION_CODE, 
        @AUDIT_EVENT, @AUDIT_MESSAGE;
END
GO
