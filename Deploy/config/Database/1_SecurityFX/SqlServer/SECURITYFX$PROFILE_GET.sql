IF OBJECT_ID(N'dbo.SECURITYFX$PROFILE_GET', N'P') IS NOT NULL 
    DROP PROCEDURE dbo.SECURITYFX$PROFILE_GET
GO

CREATE PROCEDURE dbo.SECURITYFX$PROFILE_GET
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
    @PROFILE_CODE       INTEGER,
    -- General Properties
    @CODE               INTEGER       OUT,
    @NAME               NVARCHAR(100) OUT,
    @FLAGS              NVARCHAR(100) OUT,
    @MENU               NVARCHAR(100) OUT,
    @DOMAIN             NVARCHAR(100) OUT,
    -- Privilege Properties
    @PRIV_MENU          NVARCHAR(100) OUT,
    @PRIV_VARL          NVARCHAR(100) OUT,
    @PRIV_VARM          NVARCHAR(100) OUT,
    @PRIV_REGL          NVARCHAR(100) OUT,
    @PRIV_REGM          NVARCHAR(100) OUT,
    -- Restriction Properties
    @EXPIRES            INTEGER       OUT,
    @HOUR_FROM          DECIMAL(4,2)  OUT,
    @HOUR_TO            DECIMAL(4,2)  OUT,
    @PWD_DAYS           INTEGER       OUT,
    -- Terminal Properties
    @TERMINAL01         NVARCHAR(100) OUT,
    @TERMINAL02         NVARCHAR(100) OUT,
    @TERMINAL03         NVARCHAR(100) OUT,
    @TERMINAL04         NVARCHAR(100) OUT,
    @TERMINAL05         NVARCHAR(100) OUT,
    @TERMINAL06         NVARCHAR(100) OUT,
    @TERMINAL07         NVARCHAR(100) OUT,
    @TERMINAL08         NVARCHAR(100) OUT,
    @TERMINAL09         NVARCHAR(100) OUT,
    @TERMINAL10         NVARCHAR(100) OUT,
    @TERMINAL11         NVARCHAR(100) OUT,
    @TERMINAL12         NVARCHAR(100) OUT,
    @TERMINAL13         NVARCHAR(100) OUT,
    @TERMINAL14         NVARCHAR(100) OUT,
    @TERMINAL15         NVARCHAR(100) OUT,
    @TERMINAL16         NVARCHAR(100) OUT
AS
BEGIN
    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON;

    -- Return the properties of specified profile
    SELECT 
        -- General Properties
        @CODE       = V_ACC_CODE_NUM,
        @NAME       = RTRIM(V_ACC_NAME),
        @FLAGS      = RTRIM(V_ACC_INDICADORES),
        @MENU       = RTRIM(V_ACC_PROG_INI),
        @DOMAIN     = RTRIM(V_ACC_FAMILIA),
        -- Privilege Properties
        @PRIV_MENU  = RTRIM(V_ACC_PRIV_MEN),
        @PRIV_VARL  = RTRIM(V_ACC_PRIV_VARL),
        @PRIV_VARM  = RTRIM(V_ACC_PRIV_VARM),
        @PRIV_REGL  = RTRIM(V_ACC_PRIV_REGL),
        @PRIV_REGM  = RTRIM(V_ACC_PRIV_REGM),
        -- Restriction Properties
        @EXPIRES    = V_ACC_EXP,
        @HOUR_FROM  = V_ACC_HORA_INIC,
        @HOUR_TO    = V_ACC_HORA_FIN,
        @PWD_DAYS   = V_ACC_DIAS_VIG_PASSW,
        -- Terminal Properties
        @TERMINAL01 = RTRIM(V_ACC_TERM_001),
        @TERMINAL02 = RTRIM(V_ACC_TERM_002),
        @TERMINAL03 = RTRIM(V_ACC_TERM_003),
        @TERMINAL04 = RTRIM(V_ACC_TERM_004),
        @TERMINAL05 = RTRIM(V_ACC_TERM_005),
        @TERMINAL06 = RTRIM(V_ACC_TERM_006),
        @TERMINAL07 = RTRIM(V_ACC_TERM_007),
        @TERMINAL08 = RTRIM(V_ACC_TERM_008),
        @TERMINAL09 = RTRIM(V_ACC_TERM_009),
        @TERMINAL10 = RTRIM(V_ACC_TERM_010),
        @TERMINAL11 = RTRIM(V_ACC_TERM_011),
        @TERMINAL12 = RTRIM(V_ACC_TERM_012),
        @TERMINAL13 = RTRIM(V_ACC_TERM_013),
        @TERMINAL14 = RTRIM(V_ACC_TERM_014),
        @TERMINAL15 = RTRIM(V_ACC_TERM_015),
        @TERMINAL16 = RTRIM(V_ACC_TERM_016)
    FROM   dbo.EcuACCPER
    WHERE  V_ACC_CODE_NUM = @PROFILE_CODE;
    IF (@@ROWCOUNT = 0) BEGIN
        RAISERROR('Perfil no está definido: %d', 16, 1, @PROFILE_CODE);
        RETURN;
    END;

    -- #ResultSet CAPACITY CAPACITIES
    --   #Column  CODE      NVARCHAR
    --   #Column  VALUE     NVARCHAR
    -- #EndResultSet
    SELECT RTRIM(CAP_CODIGO)    AS CODE, 
           RTRIM(CAP_VALOR)     AS VALUE
    FROM  dbo.EcuACCC2P
    WHERE CODIGO_ECU = @PROFILE_CODE
    ORDER BY CAP_CODIGO;
END
GO
