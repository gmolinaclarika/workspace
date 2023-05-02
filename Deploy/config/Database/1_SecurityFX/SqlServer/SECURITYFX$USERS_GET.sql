IF OBJECT_ID(N'dbo.SECURITYFX$USERS_GET', N'P') IS NOT NULL
    DROP PROCEDURE dbo.SECURITYFX$USERS_GET
GO

CREATE PROCEDURE dbo.SECURITYFX$USERS_GET
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
    @USERS_MAX          INTEGER
AS
BEGIN
    DECLARE @POS        INTEGER;
    DECLARE @USU_ESTADO NVARCHAR(2);

    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON;

    -- Don't filter by USU_ESTADO
    SET @USU_ESTADO = NULL;

    -- Check if @USER_CODE contains filter "/HA" (habilitado)
    SET @POS  = CHARINDEX('/HA', @USER_CODE);
    IF (@POS > 0) BEGIN
        SET @USER_CODE = RTRIM(SUBSTRING(@USER_CODE, 1, @POS - 1));
        SET @USU_ESTADO = 'HA';
    END;

    -- Check if @USER_CODE contains filter "/NH" (no-habilitado)
    SET @POS  = CHARINDEX('/NH', @USER_CODE);
    IF (@POS > 0) BEGIN
        SET @USER_CODE = RTRIM(SUBSTRING(@USER_CODE, 1, @POS - 1));
        SET @USU_ESTADO = 'NH';
    END;

    -- #ResultSet USER USERS
    --    #Column CODE          NVARCHAR
    --    #Column GIVEN_NAMES   NVARCHAR
    --    #Column FATHER_NAME   NVARCHAR
    --    #Column MOTHER_NAME   NVARCHAR
    --    #Column DOMAIN        NVARCHAR
    --    #Column STATE         NVARCHAR
    -- #EndResultSet
    IF (@USU_ESTADO IS NULL) BEGIN
        SELECT TOP(@USERS_MAX)
               RTRIM(USU_CODIGO)    AS CODE,
               RTRIM(NOMBRES)       AS GIVEN_NAMES,
               RTRIM(APELLIDO_PAT)  AS FATHER_NAME,
               RTRIM(APELLIDO_MAT)  AS MOTHER_NAME,
               RTRIM(FAMILIA)       AS DOMAIN,
               RTRIM(USU_ESTADO)    AS STATE
        FROM  dbo.EcuACCUSU
        WHERE USU_CODIGO LIKE @USER_CODE + '%'
        ORDER BY USU_CODIGO ASC;
    END
    ELSE BEGIN
        SELECT TOP(@USERS_MAX)
               RTRIM(USU_CODIGO)    AS CODE,
               RTRIM(NOMBRES)       AS GIVEN_NAMES,
               RTRIM(APELLIDO_PAT)  AS FATHER_NAME,
               RTRIM(APELLIDO_MAT)  AS MOTHER_NAME,
               RTRIM(FAMILIA)       AS DOMAIN,
               RTRIM(USU_ESTADO)    AS STATE
        FROM  dbo.EcuACCUSU
        WHERE USU_CODIGO LIKE @USER_CODE + '%'
        AND   USU_ESTADO = @USU_ESTADO
        ORDER BY USU_CODIGO ASC;
    END;
END
GO
