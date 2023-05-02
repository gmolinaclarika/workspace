IF EXISTS(SELECT * FROM sysobjects WHERE name = 'securityfx$terminal_get' AND type = 'P')
    DROP PROCEDURE securityfx$terminal_get
GO

CREATE PROCEDURE securityfx$terminal_get
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
    @TERMINAL_NAME      NVARCHAR(100),
    -- General Properties ------------
    @NAME               NVARCHAR(100) OUT,
    @DOMAIN             NVARCHAR(100) OUT,
    @TYPE               NVARCHAR(100) OUT,
    @GROUP              NVARCHAR(100) OUT,
    @LOCATION           NVARCHAR(100) OUT,
    @FUNCTION           NVARCHAR(100) OUT,
    @PRINTER            NVARCHAR(100) OUT,
    @ENABLED            NVARCHAR(100) OUT,
    @TEXT1              NVARCHAR(100) OUT,
    @TEXT2              NVARCHAR(100) OUT,
    @TEXT3              NVARCHAR(100) OUT,
    @TEXT4              NVARCHAR(100) OUT,
    -- Advanced Properties -----------
    @MASTERKEY1         NVARCHAR(100) OUT,
    @MASTERKEY2         NVARCHAR(100) OUT,
    @KEY1_TIMESTAMP     NVARCHAR(100) OUT,
    @KEY2_TIMESTAMP     NVARCHAR(100) OUT,
    @SERIAL             NVARCHAR(100) OUT,
    @IP_ADDR            NVARCHAR(100) OUT,
    @PRI_POLL           NVARCHAR(100) OUT,
    @BKP_POLL           NVARCHAR(100) OUT,
    @CIRCUIT            INTEGER       OUT
AS
BEGIN
    -- Set No Count
    SET NOCOUNT ON

    -- Normalize specified terminal name
    SELECT @TERMINAL_NAME = UPPER(RTRIM(@TERMINAL_NAME))

    -- Return the properties of specified terminal
    SELECT
        -- General Properties
        @NAME           = RTRIM(V_NET_NOMBRE),
        @DOMAIN         = RTRIM(V_NET_FAMILIA),
        @TYPE           = RTRIM(V_NET_TIPO),
        @GROUP          = RTRIM(V_NET_GRUPO_DYN),
        @LOCATION       = RTRIM(V_NET_UBICACION),
        @FUNCTION       = RTRIM(V_NET_NOMBRE_USUARIO),
        @PRINTER        = RTRIM(V_NET_PRINTER),
        @ENABLED        = RTRIM(V_NET_HABILITADO),
        @TEXT1          = RTRIM(V_NET_TEXTO1),
        @TEXT2          = RTRIM(V_NET_TEXTO2),
        @TEXT3          = RTRIM(V_NET_TEXTO3),
        @TEXT4          = RTRIM(V_NET_TEXTO4),
        -- Advanced Properties
        @MASTERKEY1     = RTRIM(V_NET_MASTERKEY1),
        @MASTERKEY2     = RTRIM(V_NET_MASTERKEY2),
        @KEY1_TIMESTAMP = RTRIM(V_NET_HORA_KEY1),
        @KEY2_TIMESTAMP = RTRIM(V_NET_HORA_KEY2),
        @SERIAL         = RTRIM(V_NET_SERIETERM),
        @IP_ADDR        = RTRIM(V_NET_DIRECCION_IP),
        @PRI_POLL       = RTRIM(V_NET_POLL_PRIMARIO),
        @BKP_POLL       = RTRIM(V_NET_POLL_BACKUP),
        @CIRCUIT        = V_NET_CIRCUITO
    FROM   dbo.EcuACCNET
    WHERE  V_NET_NOMBRE = @TERMINAL_NAME
    IF (@@ROWCOUNT = 0) BEGIN
        RAISERROR 99999, 'Terminal no está definido: %s', @TERMINAL_NAME
        RETURN
    END
END
GO

sp_procxmode securityfx$terminal_get, "anymode"
GO
