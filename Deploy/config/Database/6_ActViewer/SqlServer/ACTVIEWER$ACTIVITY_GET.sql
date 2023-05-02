IF OBJECT_ID(N'dbo.ACTVIEWER$ACTIVITY_GET', N'P') IS NOT NULL
    DROP PROCEDURE dbo.ACTVIEWER$ACTIVITY_GET
GO

CREATE PROCEDURE dbo.ACTVIEWER$ACTIVITY_GET
--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------
    @VALID_FROM         DATETIME,
    @VALID_TO           DATETIME,
    @ACTIVITY_MAX       INTEGER
AS
BEGIN
    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON

    -- Assign default to @VALID_TO
    IF (@VALID_TO IS NULL) BEGIN
        SET @VALID_TO = DATEADD(second, 5, GETDATE());
    END;

    -- Assign default to @VALID_FROM
    IF (@VALID_FROM IS NULL) BEGIN
        SET @VALID_FROM = DATEADD(second, -35, GETDATE());
    END;

    -- #ResultSet ACTIVITY ACTIVITIES
    --    #Column USER_CODE     NVARCHAR
    --    #Column GIVEN_NAMES   NVARCHAR
    --    #Column FATHER_NAME   NVARCHAR
    --    #Column MOTHER_NAME   NVARCHAR
    --    #Column STATION_CODE  NVARCHAR
    --    #Column LAST_LOGIN    NVARCHAR
    --    #Column LAST_POLL     DATETIME
    -- #EndResultSet
    WITH ACTIVE_USERS AS (
        SELECT d.USER_CODE                  AS USER_CODE,
               LTRIM(RTRIM(e.NOMBRES))      AS GIVEN_NAMES,
               LTRIM(RTRIM(e.APELLIDO_PAT)) AS FATHER_NAME,
               LTRIM(RTRIM(e.APELLIDO_MAT)) AS MOTHER_NAME,
               d.STATION_CODE               AS STATION_CODE,
               e.FEC_ULT_LOG                AS LAST_LOGIN,
               d.LAST_POLL                  AS LAST_POLL
        FROM   dbo.DESKTOPFX_USER d, dbo.EcuACCUSU e
        WHERE  e.USU_CODIGO = d.USER_CODE  
        AND    d.LAST_POLL BETWEEN @VALID_FROM AND @VALID_TO
        UNION
        SELECT d.USER_CODE                  AS USER_CODE,
               LTRIM(RTRIM(e.NOMBRES))      AS GIVEN_NAMES,
               LTRIM(RTRIM(e.APELLIDO_PAT)) AS FATHER_NAME,
               LTRIM(RTRIM(e.APELLIDO_MAT)) AS MOTHER_NAME,
               d.STATION_CODE               AS STATION_CODE,
               e.FEC_ULT_LOG                AS LAST_LOGIN,
               d.LAST_POLL                  AS LAST_POLL
        FROM   dbo.DESKTOPFX_USER d, dbo.EcuACCUSU e
        WHERE  e.USU_CODIGO = '_ANONYMOUS'
        AND    LEFT(d.USER_CODE, 1) = '$'
        AND    d.LAST_POLL BETWEEN @VALID_FROM AND @VALID_TO
    ) SELECT TOP(@ACTIVITY_MAX) * FROM ACTIVE_USERS ORDER BY USER_CODE;
END
GO
