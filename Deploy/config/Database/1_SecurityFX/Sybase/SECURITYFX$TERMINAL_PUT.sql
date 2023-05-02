IF EXISTS(SELECT * FROM sysobjects WHERE name = 'securityfx$terminal_put' AND type = 'P')
    DROP PROCEDURE securityfx$terminal_put
GO

CREATE PROCEDURE securityfx$terminal_put
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
    -- General Properties ------------
    @TERMINAL_NAME      NVARCHAR(100),
    @DOMAIN             NVARCHAR(100),
    @TYPE               NVARCHAR(100),
    @GROUP              NVARCHAR(100),
    @LOCATION           NVARCHAR(100),
    @FUNCTION           NVARCHAR(100),
    @PRINTER            NVARCHAR(100),
    @ENABLED            NVARCHAR(100),
    @TEXT1              NVARCHAR(100),
    @TEXT2              NVARCHAR(100),
    @TEXT3              NVARCHAR(100),
    @TEXT4              NVARCHAR(100),
    -- Advanced Properties -----------
    @MASTERKEY1         NVARCHAR(100),
    @MASTERKEY2         NVARCHAR(100),
    @KEY1_TIMESTAMP     NVARCHAR(100),
    @KEY2_TIMESTAMP     NVARCHAR(100),
    @SERIAL             NVARCHAR(100),
    @IP_ADDR            NVARCHAR(100),
    @PRI_POLL           NVARCHAR(100),
    @BKP_POLL           NVARCHAR(100),
    @CIRCUIT            INTEGER,
    -- Output Properties -------------
    @CREATED            INTEGER OUT
AS
BEGIN
    DECLARE @AUDIT_EVENT    INTEGER
    DECLARE @AUDIT_MESSAGE  NVARCHAR(100)

    -- Set No Count
    SET NOCOUNT ON

    -- Asume the terminal exists
    SELECT @CREATED = 0

    -- Normalize specified terminal name
    SELECT @TERMINAL_NAME = UPPER(RTRIM(@TERMINAL_NAME))

    -- Update the properties of specified terminal
    UPDATE dbo.EcuACCNET
    SET    V_NET_FAMILIA        = ISNULL(@DOMAIN,''),
           V_NET_TIPO           = ISNULL(@TYPE,''),
           V_NET_GRUPO_DYN      = ISNULL(@GROUP,''),
           V_NET_UBICACION      = ISNULL(@LOCATION,''),
           V_NET_NOMBRE_USUARIO = ISNULL(@FUNCTION,''),
           V_NET_PRINTER        = ISNULL(@PRINTER,''),
           V_NET_HABILITADO     = ISNULL(@ENABLED,''),
           V_NET_TEXTO1         = ISNULL(@TEXT1,''),
           V_NET_TEXTO2         = ISNULL(@TEXT2,''),
           V_NET_TEXTO3         = ISNULL(@TEXT3,''),
           V_NET_TEXTO4         = ISNULL(@TEXT4,''),
           -- Advanced Properties -----------
           V_NET_MASTERKEY1     = ISNULL(@MASTERKEY1,''),
           V_NET_MASTERKEY2     = ISNULL(@MASTERKEY2,''),
           V_NET_HORA_KEY1      = ISNULL(@KEY1_TIMESTAMP,''),
           V_NET_HORA_KEY2      = ISNULL(@KEY2_TIMESTAMP,''),
           V_NET_SERIETERM      = ISNULL(@SERIAL,''),
           V_NET_DIRECCION_IP   = ISNULL(@IP_ADDR,''),
           V_NET_POLL_PRIMARIO  = ISNULL(@PRI_POLL,''),
           V_NET_POLL_BACKUP    = ISNULL(@BKP_POLL,''),
           V_NET_CIRCUITO       = @CIRCUIT
    WHERE  V_NET_NOMBRE = @TERMINAL_NAME

    -- Create terminal if it didn't exist
    IF (@@ROWCOUNT = 0) BEGIN
        INSERT INTO dbo.EcuACCNET (
            -- General Properties ------------
             V_NET_NOMBRE
            ,V_NET_FAMILIA
            ,V_NET_TIPO
            ,V_NET_GRUPO_DYN
            ,V_NET_UBICACION
            ,V_NET_NOMBRE_USUARIO
            ,V_NET_PRINTER
            ,V_NET_HABILITADO
            ,V_NET_TEXTO1
            ,V_NET_TEXTO2
            ,V_NET_TEXTO3
            ,V_NET_TEXTO4
            -- Advanced Properties -----------
            ,V_NET_MASTERKEY1
            ,V_NET_MASTERKEY2
            ,V_NET_HORA_KEY1
            ,V_NET_HORA_KEY2
            ,V_NET_SERIETERM
            ,V_NET_DIRECCION_IP
            ,V_NET_POLL_PRIMARIO
            ,V_NET_POLL_BACKUP
            ,V_NET_CIRCUITO
        ) VALUES (
            -- General Properties ------------
             @TERMINAL_NAME
            ,ISNULL(@DOMAIN,'')
            ,ISNULL(@TYPE,'')
            ,ISNULL(@GROUP,'')
            ,ISNULL(@LOCATION,'')
            ,ISNULL(@FUNCTION,'')
            ,ISNULL(@PRINTER,'')
            ,ISNULL(@ENABLED,'')
            ,ISNULL(@TEXT1,'')
            ,ISNULL(@TEXT2,'')
            ,ISNULL(@TEXT3,'')
            ,ISNULL(@TEXT4,'')
            -- Advanced Properties -----------
            ,ISNULL(@MASTERKEY1,'')
            ,ISNULL(@MASTERKEY2,'')
            ,ISNULL(@KEY1_TIMESTAMP,'')
            ,ISNULL(@KEY2_TIMESTAMP,'')
            ,ISNULL(@SERIAL,'')
            ,ISNULL(@IP_ADDR,'')
            ,ISNULL(@PRI_POLL,'')
            ,ISNULL(@BKP_POLL,'')
            ,@CIRCUIT
        )
        SELECT @CREATED = 1
    END

    -- Generate an audit record
    IF (@CREATED = 0) BEGIN
        SELECT @AUDIT_EVENT = 15
        SELECT @AUDIT_MESSAGE = 'Terminal fue modificado: ' + @TERMINAL_NAME
    END
    ELSE BEGIN
        SELECT @AUDIT_EVENT = 13
        SELECT @AUDIT_MESSAGE = 'Terminal fue creado: ' + @TERMINAL_NAME
    END
    EXEC dbo.securityfx$audit_put
        @WSS_USER_CODE, @WSS_PROFILE_CODE, @WSS_STATION_CODE,
        @AUDIT_EVENT, @AUDIT_MESSAGE
END
GO

sp_procxmode securityfx$terminal_put, "anymode"
GO
