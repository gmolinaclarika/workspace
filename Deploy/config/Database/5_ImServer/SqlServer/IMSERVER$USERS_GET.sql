IF OBJECT_ID(N'dbo.IMSERVER$USERS_GET', N'P') IS NOT NULL 
    DROP PROCEDURE dbo.IMSERVER$USERS_GET
GO

CREATE PROCEDURE dbo.IMSERVER$USERS_GET
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
    @USERS_MAX          INTEGER
AS
BEGIN
    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON

    -- #ResultSet USER USERS
    --    #Column USER_CODE     NVARCHAR
    --    #Column GIVEN_NAMES   NVARCHAR
    --    #Column FATHER_NAME   NVARCHAR
    --    #Column MOTHER_NAME   NVARCHAR
    --    #Column ADDRESS       NVARCHAR
    --    #Column COMMUNE       NVARCHAR
    --    #Column CITY          NVARCHAR
    --    #Column COUNTRY       NVARCHAR
    --    #Column POSITION      NVARCHAR
    --    #Column PHONE1        NVARCHAR
    --    #Column FAX           NVARCHAR
    --    #Column EMAIL         NVARCHAR
    --    #Column DOMAIN        NVARCHAR
    -- #EndResultSet
    SELECT TOP(@USERS_MAX)
           LTRIM(RTRIM(USU_CODIGO))     AS USER_CODE,
           LTRIM(RTRIM(NOMBRES))        AS GIVEN_NAMES,
           LTRIM(RTRIM(APELLIDO_PAT))   AS FATHER_NAME,
           LTRIM(RTRIM(APELLIDO_MAT))   AS MOTHER_NAME,
           LTRIM(RTRIM(DIRECCION))      AS ADDRESS,
           LTRIM(RTRIM(COMUNA))         AS COMMUNE,
           LTRIM(RTRIM(CIUDAD))         AS CITY,
           LTRIM(RTRIM(PAIS))           AS COUNTRY,
           LTRIM(RTRIM(CARGO))          AS POSITION,
           LTRIM(RTRIM(FONO1))          AS PHONE1,
           LTRIM(RTRIM(FAX))            AS FAX,
           LTRIM(RTRIM(EMAIL))          AS EMAIL,
           LTRIM(RTRIM(FAMILIA))        AS DOMAIN
    FROM   dbo.EcuACCUSU
    WHERE  USU_ESTADO = 'HA'
    AND    USUARIOIM  = 'S'
    ORDER BY USU_CODIGO;
END
GO
