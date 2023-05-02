DROP PROCEDURE IF EXISTS SECURITYFX$TERMINAL_PUT;

DELIMITER $$
CREATE PROCEDURE SECURITYFX$TERMINAL_PUT (
-- -----------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
-- -----------------------------------------------------------------------------
    IN  _WSS_USER_CODE      VARCHAR(100),
    IN  _WSS_PROFILE_CODE   INTEGER,
    IN  _WSS_STATION_CODE   VARCHAR(100),
    -- General Properties ------------
    IN  _TERMINAL_NAME      VARCHAR(100),
    IN  _DOMAIN             VARCHAR(100),
    IN  _TYPE               VARCHAR(100),
    IN  _GROUP              VARCHAR(100),
    IN  _LOCATION           VARCHAR(100),
    IN  _FUNCTION           VARCHAR(100),
    IN  _PRINTER            VARCHAR(100),
    IN  _ENABLED            VARCHAR(100),
    IN  _TEXT1              VARCHAR(100),
    IN  _TEXT2              VARCHAR(100),
    IN  _TEXT3              VARCHAR(100),
    IN  _TEXT4              VARCHAR(100),
    -- Advanced Properties -----------
    IN  _MASTERKEY1         VARCHAR(100),
    IN  _MASTERKEY2         VARCHAR(100),
    IN  _KEY1_TIMESTAMP     VARCHAR(100),
    IN  _KEY2_TIMESTAMP     VARCHAR(100),
    IN  _SERIAL             VARCHAR(100),
    IN  _IP_ADDR            VARCHAR(100),
    IN  _PRI_POLL           VARCHAR(100),
    IN  _BKP_POLL           VARCHAR(100),
    IN  _CIRCUIT            INTEGER,
    -- Output Properties -------------
    OUT _CREATED            INTEGER
)
BEGIN
    DECLARE _AUDIT_EVENT    INTEGER;
    DECLARE _AUDIT_MESSAGE  VARCHAR(100);

    -- Asume the terminal exists
    SET _CREATED = 0;

    -- Normalize specified terminal name
    SET _TERMINAL_NAME = UPPER(RTRIM(_TERMINAL_NAME));

    -- Update the properties of specified terminal
    UPDATE EcuACCNET
    SET    V_NET_FAMILIA        = IFNULL(_DOMAIN,''),
           V_NET_TIPO           = IFNULL(_TYPE,''),
           V_NET_GRUPO_DYN      = IFNULL(_GROUP,''),
           V_NET_UBICACION      = IFNULL(_LOCATION,''),
           V_NET_NOMBRE_USUARIO = IFNULL(_FUNCTION,''),
           V_NET_PRINTER        = IFNULL(_PRINTER,''),
           V_NET_HABILITADO     = IFNULL(_ENABLED,''),
           V_NET_TEXTO1         = IFNULL(_TEXT1,''),
           V_NET_TEXTO2         = IFNULL(_TEXT2,''),
           V_NET_TEXTO3         = IFNULL(_TEXT3,''),
           V_NET_TEXTO4         = IFNULL(_TEXT4,''),
           -- Advanced Properties -----------
           V_NET_MASTERKEY1     = IFNULL(_MASTERKEY1,''),
           V_NET_MASTERKEY2     = IFNULL(_MASTERKEY2,''),
           V_NET_HORA_KEY1      = IFNULL(_KEY1_TIMESTAMP,''),
           V_NET_HORA_KEY2      = IFNULL(_KEY2_TIMESTAMP,''),
           V_NET_SERIETERM      = IFNULL(_SERIAL,''),
           V_NET_DIRECCION_IP   = IFNULL(_IP_ADDR,''),
           V_NET_POLL_PRIMARIO  = IFNULL(_PRI_POLL,''),
           V_NET_POLL_BACKUP    = IFNULL(_BKP_POLL,''),
           V_NET_CIRCUITO       = _CIRCUIT
    WHERE  V_NET_NOMBRE = _TERMINAL_NAME;

    -- Create terminal if it didn't exist
    IF (ROW_COUNT() = 0) THEN
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
             _TERMINAL_NAME
            ,IFNULL(_DOMAIN,'')
            ,IFNULL(_TYPE,'')
            ,IFNULL(_GROUP,'')
            ,IFNULL(_LOCATION,'')
            ,IFNULL(_FUNCTION,'')
            ,IFNULL(_PRINTER,'')
            ,IFNULL(_ENABLED,'')
            ,IFNULL(_TEXT1,'')
            ,IFNULL(_TEXT2,'')
            ,IFNULL(_TEXT3,'')
            ,IFNULL(_TEXT4,'')
            -- Advanced Properties -----------
            ,IFNULL(_MASTERKEY1,'')
            ,IFNULL(_MASTERKEY2,'')
            ,IFNULL(_KEY1_TIMESTAMP,'')
            ,IFNULL(_KEY2_TIMESTAMP,'')
            ,IFNULL(_SERIAL,'')
            ,IFNULL(_IP_ADDR,'')
            ,IFNULL(_PRI_POLL,'')
            ,IFNULL(_BKP_POLL,'')
            ,_CIRCUIT
        );
        SET _CREATED = 1;
    END IF;

    -- Generate an audit record
    IF (_CREATED = 0) THEN
        SET _AUDIT_EVENT = 15;
        SET _AUDIT_MESSAGE = CONCAT('Terminal fue modificado: ', _TERMINAL_NAME);
    ELSE
        SET _AUDIT_EVENT = 13;
        SET _AUDIT_MESSAGE = CONCAT('Terminal fue creado: ', _TERMINAL_NAME);
    END IF;
    CALL SECURITYFX$AUDIT_PUT(
        _WSS_USER_CODE, _WSS_PROFILE_CODE, _WSS_STATION_CODE, 
        _AUDIT_EVENT, _AUDIT_MESSAGE);
END$$
DELIMITER ;
