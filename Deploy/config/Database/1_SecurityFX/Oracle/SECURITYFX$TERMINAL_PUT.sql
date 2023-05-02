CREATE OR REPLACE PROCEDURE SECURITYFX$TERMINAL_PUT
--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------
(
    WSS_USER_CODE$          IN  NVARCHAR2,
    WSS_PROFILE_CODE$       IN  INTEGER,
    WSS_STATION_CODE$       IN  NVARCHAR2,
    -- General Properties ------------
    TERMINAL_NAME$          IN  NVARCHAR2,
    DOMAIN$                 IN  NVARCHAR2,
    TYPE$                   IN  NVARCHAR2,
    GROUP$                  IN  NVARCHAR2,
    LOCATION$               IN  NVARCHAR2,
    FUNCTION$               IN  NVARCHAR2,
    PRINTER$                IN  NVARCHAR2,
    ENABLED$                IN  NVARCHAR2,
    TEXT1$                  IN  NVARCHAR2,
    TEXT2$                  IN  NVARCHAR2,
    TEXT3$                  IN  NVARCHAR2,
    TEXT4$                  IN  NVARCHAR2,
    -- Advanced Properties -----------
    MASTERKEY1$             IN  NVARCHAR2,
    MASTERKEY2$             IN  NVARCHAR2,
    KEY1_TIMESTAMP$         IN  NVARCHAR2,
    KEY2_TIMESTAMP$         IN  NVARCHAR2,
    SERIAL$                 IN  NVARCHAR2,
    IP_ADDR$                IN  NVARCHAR2,
    PRI_POLL$               IN  NVARCHAR2,
    BKP_POLL$               IN  NVARCHAR2,
    CIRCUIT$                IN  INTEGER,
    -- Output Properties -------------
    CREATED$                OUT INTEGER
)
AS
    V_NET_NOMBRE$           EcuACCNET.V_NET_NOMBRE%TYPE;
BEGIN
    -- Asume the terminal exists
    CREATED$ := 0;

    -- Normalize specified terminal name
    V_NET_NOMBRE$ := UPPER(RTRIM(TERMINAL_NAME$));

    -- Update the properties of specified terminal
    UPDATE EcuACCNET
    SET    V_NET_FAMILIA        = NVL(DOMAIN$,' '),
           V_NET_TIPO           = NVL(TYPE$,' '),
           V_NET_GRUPO_DYN      = NVL(GROUP$,' '),
           V_NET_UBICACION      = NVL(LOCATION$,' '),
           V_NET_NOMBRE_USUARIO = NVL(FUNCTION$,' '),
           V_NET_PRINTER        = NVL(PRINTER$,' '),
           V_NET_HABILITADO     = NVL(ENABLED$,' '),
           V_NET_TEXTO1         = NVL(TEXT1$,' '),
           V_NET_TEXTO2         = NVL(TEXT2$,' '),
           V_NET_TEXTO3         = NVL(TEXT3$,' '),
           V_NET_TEXTO4         = NVL(TEXT4$,' '),
           -- Advanced Properties -----------
           V_NET_MASTERKEY1     = NVL(MASTERKEY1$,' '),
           V_NET_MASTERKEY2     = NVL(MASTERKEY2$,' '),
           V_NET_HORA_KEY1      = NVL(KEY1_TIMESTAMP$,' '),
           V_NET_HORA_KEY2      = NVL(KEY2_TIMESTAMP$,' '),
           V_NET_SERIETERM      = NVL(SERIAL$,' '),
           V_NET_DIRECCION_IP   = NVL(IP_ADDR$,' '),
           V_NET_POLL_PRIMARIO  = NVL(PRI_POLL$,' '),
           V_NET_POLL_BACKUP    = NVL(BKP_POLL$,' '),
           V_NET_CIRCUITO       = CIRCUIT$
    WHERE  V_NET_NOMBRE = V_NET_NOMBRE$;

    -- Create terminal if it didn't exist
    IF (SQL%ROWCOUNT = 0) THEN
        INSERT INTO EcuACCNET (
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
             V_NET_NOMBRE$
            ,NVL(DOMAIN$,' ')
            ,NVL(TYPE$,' ')
            ,NVL(GROUP$,' ')
            ,NVL(LOCATION$,' ')
            ,NVL(FUNCTION$,' ')
            ,NVL(PRINTER$,' ')
            ,NVL(ENABLED$,' ')
            ,NVL(TEXT1$,' ')
            ,NVL(TEXT2$,' ')
            ,NVL(TEXT3$,' ')
            ,NVL(TEXT4$,' ')
           -- Advanced Properties -----------
            ,NVL(MASTERKEY1$,' ')
            ,NVL(MASTERKEY2$,' ')
            ,NVL(KEY1_TIMESTAMP$,' ')
            ,NVL(KEY2_TIMESTAMP$,' ')
            ,NVL(SERIAL$,' ')
            ,NVL(IP_ADDR$,' ')
            ,NVL(PRI_POLL$,' ')
            ,NVL(BKP_POLL$,' ')
            ,CIRCUIT$
        );
        CREATED$ := 1;
    END IF;

    -- Generate an audit record
    IF (CREATED$ = 0) THEN
        SECURITYFX$AUDIT_PUT(
            WSS_USER_CODE$, WSS_PROFILE_CODE$, WSS_STATION_CODE$, 
            15, 'Terminal fue modificado: ' || TERMINAL_NAME$);
    ELSE
        SECURITYFX$AUDIT_PUT(
            WSS_USER_CODE$, WSS_PROFILE_CODE$, WSS_STATION_CODE$, 
            13, 'Terminal fue creado: ' || TERMINAL_NAME$);
    END IF;
END SECURITYFX$TERMINAL_PUT;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
