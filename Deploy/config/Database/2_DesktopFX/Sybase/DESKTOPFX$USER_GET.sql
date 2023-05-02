IF EXISTS(SELECT * FROM sysobjects WHERE name = 'desktopfx$user_get' AND type = 'P')
    DROP PROCEDURE desktopfx$user_get
GO

CREATE PROCEDURE desktopfx$user_get
--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------
    @USER_CODE      NVARCHAR(200)
AS
BEGIN
    -- Set No Count
    SET NOCOUNT ON

    -- #ResultSet USER USERS
    --   #Column  USER_CODE         VARCHAR
    --   #Column  ESTADO            VARCHAR
    --   #Column  FAMILIA           VARCHAR
    --   #Column  NOMBRES           VARCHAR
    --   #Column  APELLIDO_PAT      VARCHAR
    --   #Column  APELLIDO_MAT      VARCHAR
    --   #Column  FEC_CRE_USU       VARCHAR
    --   #Column  FEC_PRI_LOG       VARCHAR
    --   #Column  FEC_ULT_LOG       VARCHAR
    --   #Column  FEC_VIG_DESD      INTEGER
    --   #Column  FEC_VIG_HAST      INTEGER
    --   #Column  PASSWORD          VARCHAR
    --   #Column  PSW_TIPO          VARCHAR
    --   #Column  PSW_ESTADO        VARCHAR
    --   #Column  PSW_VIG_DESD      INTEGER
    --   #Column  PSW_DIAS_CADUC    INTEGER
    --   #Column  PSW_ULTIMAS1      VARCHAR
    --   #Column  PSW_ULTIMAS2      VARCHAR
    --   #Column  PSW_ULTIMAS3      VARCHAR
    --   #Column  PSW_ULTIMAS4      VARCHAR
    --   #Column  PSW_ULTIMAS5      VARCHAR
    --   #Column  PSW_ULTIMAS6      VARCHAR
    --   #Column  EMAIL             VARCHAR
    --   #Column  ERROR_LOGIN       INTEGER
    --   #Column  FEC_ERR_LOG       VARCHAR
    -- #EndResultSet
    SELECT RTRIM(USU_CODIGO)            AS USER_CODE,
           RTRIM(USU_ESTADO)            AS ESTADO,
           RTRIM(FAMILIA)               AS FAMILIA,
           RTRIM(NOMBRES)               AS NOMBRES,
           RTRIM(APELLIDO_PAT)          AS APELLIDO_PAT,
           RTRIM(APELLIDO_MAT)          AS APELLIDO_MAT,
           RTRIM(FEC_CRE_USU)           AS FEC_CRE_USU,
           RTRIM(FEC_PRI_LOG)           AS FEC_PRI_LOG,
           RTRIM(FEC_ULT_LOG)           AS FEC_ULT_LOG,
           FEC_VIG_DESD                 AS FEC_VIG_DESD,
           FEC_VIG_HAST                 AS FEC_VIG_HAST,
           RTRIM(PASSWORD)              AS PASSWORD,
           RTRIM(PSW_TIPO)              AS PSW_TIPO,
           RTRIM(PSW_ESTADO)            AS PSW_ESTADO,
           PSW_VIG_DESD                 AS PSW_VIG_DESD,
           PSW_DIAS_CADUC               AS PSW_DIAS_CADUC,
           RTRIM(PSW_ULTIMAS_001)       AS PSW_ULTIMAS1,
           RTRIM(PSW_ULTIMAS_002)       AS PSW_ULTIMAS2,
           RTRIM(PSW_ULTIMAS_003)       AS PSW_ULTIMAS3,
           RTRIM(PSW_ULTIMAS_004)       AS PSW_ULTIMAS4,
           RTRIM(PSW_ULTIMAS_005)       AS PSW_ULTIMAS5,
           RTRIM(PSW_ULTIMAS_006)       AS PSW_ULTIMAS6,
           RTRIM(EMAIL)                 AS EMAIL,
           ERROR_LOGIN                  AS ERROR_LOGIN,
           RTRIM(FEC_ERR_LOG)           AS FEC_ERR_LOG
    FROM   dbo.EcuACCUSU
    WHERE  USU_CODIGO = @USER_CODE
END
GO

sp_procxmode desktopfx$user_get, "anymode"
GO
