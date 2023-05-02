DROP PROCEDURE IF EXISTS SECURITYFX$TERMINAL_GET;

DELIMITER $$
CREATE PROCEDURE SECURITYFX$TERMINAL_GET (
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
    -- ----------------------------------
    IN  _TERMINAL_NAME      VARCHAR(100),
    -- General Properties ---------------
    OUT _NAME               VARCHAR(100),
    OUT _DOMAIN             VARCHAR(100),
    OUT _TYPE               VARCHAR(100),
    OUT _GROUP              VARCHAR(100),
    OUT _LOCATION           VARCHAR(100),
    OUT _FUNCTION           VARCHAR(100),
    OUT _PRINTER            VARCHAR(100),
    OUT _ENABLED            VARCHAR(100),
    OUT _TEXT1              VARCHAR(100),
    OUT _TEXT2              VARCHAR(100),
    OUT _TEXT3              VARCHAR(100),
    OUT _TEXT4              VARCHAR(100),
    -- Advanced Properties --------------
    OUT _MASTERKEY1         VARCHAR(100),
    OUT _MASTERKEY2         VARCHAR(100),
    OUT _KEY1_TIMESTAMP     VARCHAR(100),
    OUT _KEY2_TIMESTAMP     VARCHAR(100),
    OUT _SERIAL             VARCHAR(100),
    OUT _IP_ADDR            VARCHAR(100),
    OUT _PRI_POLL           VARCHAR(100),
    OUT _BKP_POLL           VARCHAR(100),
    OUT _CIRCUIT            INTEGER
)
BEGIN
    DECLARE _MESSAGE_TEXT VARCHAR(200);

    -- Normalize specified terminal name
    SET _TERMINAL_NAME = UPPER(RTRIM(_TERMINAL_NAME));

    -- Return the properties of specified terminal
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
        _NAME,
        _DOMAIN,
        _TYPE,
        _GROUP,
        _LOCATION,
        _FUNCTION,
        _PRINTER,
        _ENABLED,
        _TEXT1,
        _TEXT2,
        _TEXT3,
        _TEXT4,
        -- Advanced Properties -----------
        _MASTERKEY1,
        _MASTERKEY2,
        _KEY1_TIMESTAMP,
        _KEY2_TIMESTAMP,
        _SERIAL$,
        _IP_ADDR,
        _PRI_POLL,
        _BKP_POLL,
        _CIRCUIT
    FROM   EcuACCNET
    WHERE  V_NET_NOMBRE = _TERMINAL_NAME;
    IF (FOUND_ROWS() = 0) THEN
        SET _MESSAGE_TEXT = CONCAT('Terminal no está definido: ', _TERMINAL_NAME);
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = _MESSAGE_TEXT;
    END IF;
END$$
DELIMITER ;
