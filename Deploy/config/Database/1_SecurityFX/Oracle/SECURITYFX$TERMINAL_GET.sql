CREATE OR REPLACE PROCEDURE SECURITYFX$TERMINAL_GET
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
    --------------------------------------
    TERMINAL_NAME$          IN  NVARCHAR2,
    -- General Properties ------------
    NAME$                   OUT NVARCHAR2,
    DOMAIN$                 OUT NVARCHAR2,
    TYPE$                   OUT NVARCHAR2,
    GROUP$                  OUT NVARCHAR2,
    LOCATION$               OUT NVARCHAR2,
    FUNCTION$               OUT NVARCHAR2,
    PRINTER$                OUT NVARCHAR2,
    ENABLED$                OUT NVARCHAR2,
    TEXT1$                  OUT NVARCHAR2,
    TEXT2$                  OUT NVARCHAR2,
    TEXT3$                  OUT NVARCHAR2,
    TEXT4$                  OUT NVARCHAR2,
    -- Advanced Properties -----------
    MASTERKEY1$             OUT NVARCHAR2,
    MASTERKEY2$             OUT NVARCHAR2,
    KEY1_TIMESTAMP$         OUT NVARCHAR2,
    KEY2_TIMESTAMP$         OUT NVARCHAR2,
    SERIAL$                 OUT NVARCHAR2,
    IP_ADDR$                OUT NVARCHAR2,
    PRI_POLL$               OUT NVARCHAR2,
    BKP_POLL$               OUT NVARCHAR2,
    CIRCUIT$                OUT INTEGER
)
AS
    V_NET_NOMBRE$           EcuACCNET.V_NET_NOMBRE%TYPE;
BEGIN
    -- Normalize specified terminal name
    V_NET_NOMBRE$ := UPPER(RTRIM(TERMINAL_NAME$));

    -- Returns the properties of the terminal
    BEGIN
        SELECT
            -- General Properties ------------
            RTRIM(V_NET_NOMBRE),
            RTRIM(V_NET_FAMILIA),
            RTRIM(V_NET_TIPO),
            RTRIM(V_NET_GRUPO_DYN),
            RTRIM(V_NET_UBICACION),
            RTRIM(V_NET_NOMBRE_USUARIO),
            RTRIM(V_NET_PRINTER),
            RTRIM(V_NET_HABILITADO),
            RTRIM(V_NET_TEXTO1),
            RTRIM(V_NET_TEXTO2),
            RTRIM(V_NET_TEXTO3),
            RTRIM(V_NET_TEXTO4),
            -- Advanced Properties -----------
            RTRIM(V_NET_MASTERKEY1),
            RTRIM(V_NET_MASTERKEY2),
            RTRIM(V_NET_HORA_KEY1),
            RTRIM(V_NET_HORA_KEY2),
            RTRIM(V_NET_SERIETERM),
            RTRIM(V_NET_DIRECCION_IP),
            RTRIM(V_NET_POLL_PRIMARIO),
            RTRIM(V_NET_POLL_BACKUP),
            V_NET_CIRCUITO
        INTO
            -- General Properties ------------
            NAME$,
            DOMAIN$,
            TYPE$,
            GROUP$,
            LOCATION$,
            FUNCTION$,
            PRINTER$,
            ENABLED$,
            TEXT1$,
            TEXT2$,
            TEXT3$,
            TEXT4$,
            -- Advanced Properties -----------
            MASTERKEY1$,
            MASTERKEY2$,
            KEY1_TIMESTAMP$,
            KEY2_TIMESTAMP$,
            SERIAL$,
            IP_ADDR$,
            PRI_POLL$,
            BKP_POLL$,
            CIRCUIT$
        FROM   EcuACCNET
        WHERE  V_NET_NOMBRE = V_NET_NOMBRE$;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'Terminal no está definido: ' || TERMINAL_NAME$);
    END;
END SECURITYFX$TERMINAL_GET;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
