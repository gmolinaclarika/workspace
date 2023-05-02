DROP PROCEDURE IF EXISTS DESKTOPFX$LOGIN;

DELIMITER $$
CREATE PROCEDURE DESKTOPFX$LOGIN (
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
    IN  _USER_WORD          VARCHAR(200),
    IN  _SERIAL_NUMBER      VARCHAR(200),
    -- User properties ------------------
    OUT _FIRST_NAME         VARCHAR(200),
    OUT _FATHER_NAME        VARCHAR(200),
    OUT _MOTHER_NAME        VARCHAR(200),
    OUT _USER_RUT           VARCHAR(200),
    OUT _JOB_TITLE          VARCHAR(200),
    OUT _VALID_FROM         INTEGER,
    OUT _VALID_TO           INTEGER,
    -- Contact properties ---------------
    OUT _STREET             VARCHAR(200),
    OUT _COMMUNE            VARCHAR(200),
    OUT _CITY               VARCHAR(200),
    OUT _REGION             VARCHAR(200),
    OUT _COUNTRY            VARCHAR(200),
    OUT _EMAIL              VARCHAR(200),
    OUT _PHONE1             VARCHAR(200),
    OUT _PHONE2             VARCHAR(200),
    OUT _FAX                VARCHAR(200),
    -- Billing properties ---------------
    OUT _USER_REALM         VARCHAR(200),
    OUT _COMPANY_RUT        VARCHAR(200),
    OUT _BILLING_TYPE       VARCHAR(200),
    OUT _BILLING_CODE       VARCHAR(200),
    OUT _CONTRACT_CODE      VARCHAR(200),
    OUT _CONTRACT_ANNEX     VARCHAR(200),
    -- Profile properties ---------------
    OUT _PROFILE_NAME       VARCHAR(200),
    OUT _PROFILE_TYPE       INTEGER,
    OUT _PRIVILEGES         VARCHAR(200),
    OUT _PROFILE_REALM      VARCHAR(200),
    OUT _MENU_NAME          VARCHAR(200),
    OUT _MENU_XML           LONGBLOB,
    OUT _OFFICE_TYPE        INTEGER,
    -- Login properties -------------------
    OUT _LOGIN_STATE        LONGBLOB,
    OUT _LOGIN_SERVICE      LONGBLOB,
    OUT _LOGIN_PROPS        LONGBLOB,
    OUT _GLOBAL_PROPS       LONGBLOB
)
BEGIN
    DECLARE _USER_ID      BIGINT;
    DECLARE _LOGIN_ID     BIGINT;
    DECLARE _USER_STATE   VARCHAR(2);
    DECLARE _LAST_POLL    DATETIME(3);
    DECLARE _FEC_PRI_LOG  VARCHAR(26);
    DECLARE _FEC_ULT_LOG  VARCHAR(26);
    DECLARE _REAL_WORD    VARCHAR(200);
    DECLARE _SERVICE_NAME VARCHAR(200);
    DECLARE _CURR_STATION VARCHAR(200);
    DECLARE _MESSAGE_TEXT VARCHAR(200);

    -- Init dummy outputs
    SET _OFFICE_TYPE = 0;

    -- Obtain user word, state and first login date
    SELECT PASSWORD, RTRIM(USU_ESTADO), RTRIM(FEC_PRI_LOG)
    INTO   _REAL_WORD, _USER_STATE, _FEC_PRI_LOG
    FROM   EcuACCUSU
    WHERE  USU_CODIGO = _WSS_USER_CODE;
    IF (FOUND_ROWS() = 0) THEN
        SET _MESSAGE_TEXT = 'Usuario especificado no existe';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = _MESSAGE_TEXT;
    END IF;

    -- Check that real word matches supplied user word
    IF (_USER_WORD != _REAL_WORD) THEN
        SET _MESSAGE_TEXT = 'El usuario y/o la contraseña son incorrectos';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = _MESSAGE_TEXT;
    END IF;

    -- Check that the user is currently enabled
    IF (_USER_STATE != 'HA') THEN
        SET _MESSAGE_TEXT = 'El usuario no está habilitado';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = _MESSAGE_TEXT;
    END IF;

    -- Obtain/create user properties and validate station
    SELECT ID, SERVICE_NAME, STATION_CODE, LAST_POLL
    INTO   _USER_ID, _SERVICE_NAME, _CURR_STATION, _LAST_POLL
    FROM   DESKTOPFX_USER
    WHERE  USER_CODE = _WSS_USER_CODE;
    IF (FOUND_ROWS() = 0) THEN
        SET _SERVICE_NAME = 'SERVICE';
        INSERT DESKTOPFX_USER (
            USER_CODE, SERVICE_NAME, STATION_CODE, LAST_POLL
        ) VALUES (
            _WSS_USER_CODE, _SERVICE_NAME, _WSS_STATION_CODE, NOW(3)
        );
        SET _USER_ID = LAST_INSERT_ID();
    ELSEIF (TIMESTAMPDIFF(MINUTE, _LAST_POLL, NOW(3)) >= 5) THEN
        UPDATE DESKTOPFX_USER
        SET    STATION_CODE = _WSS_STATION_CODE,
               LAST_POLL = NOW(3)
        WHERE  ID = _USER_ID;
    ELSEIF (_CURR_STATION = _WSS_STATION_CODE) THEN
        UPDATE DESKTOPFX_USER
        SET    LAST_POLL = NOW(3)
        WHERE  ID = _USER_ID;
    ELSE
        SET _MESSAGE_TEXT = CONCAT('El usuario ya está login en la estación ', _CURR_STATION);
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = _MESSAGE_TEXT;
    END IF;

    -- Obtain user properties
    SELECT 
        -- User properties
        RTRIM(NOMBRES), 
        RTRIM(APELLIDO_PAT), 
        RTRIM(APELLIDO_MAT),
        RTRIM(RUT),
        RTRIM(CARGO),
        FEC_VIG_DESD,
        FEC_VIG_HAST,
        -- Contact properties
        RTRIM(DIRECCION),
        RTRIM(COMUNA),
        RTRIM(CIUDAD),
        RTRIM(ESTADO),
        RTRIM(PAIS),
        RTRIM(EMAIL),
        RTRIM(FONO1),
        RTRIM(FONO2),
        RTRIM(FAX),
        -- Billing properties
        RTRIM(FAMILIA),
        RTRIM(RUT_INST),
        RTRIM(FACTURACION),
        RTRIM(COD_FACTURACION),
        RTRIM(COD_CONTRATO),
        RTRIM(ANEXO_CONTRATO)
    INTO   
        -- General properties
        _FIRST_NAME,
        _FATHER_NAME,
        _MOTHER_NAME,
        _USER_RUT,
        _JOB_TITLE,
        _VALID_FROM,
        _VALID_TO,
        -- Contact properties
        _STREET,
        _COMMUNE,
        _CITY,
        _REGION,
        _COUNTRY,
        _EMAIL,
        _PHONE1,
        _PHONE2,
        _FAX,
        -- Billing properties
        _USER_REALM,
        _COMPANY_RUT,
        _BILLING_TYPE,
        _BILLING_CODE,
        _CONTRACT_CODE,
        _CONTRACT_ANNEX
    FROM  EcuACCUSU
    WHERE USU_CODIGO = _WSS_USER_CODE;
    IF (FOUND_ROWS() = 0) THEN
        SET _MESSAGE_TEXT = 'Usuario especificado no existe';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = _MESSAGE_TEXT;
    END IF;

    -- Obtain profile properties
    SELECT RTRIM(V_ACC_NAME), 
           ASCII(SUBSTR(V_ACC_INDICADORES,2,1)), 
           CONCAT(V_ACC_PRIV_MEN,
               V_ACC_PRIV_VARL,
               V_ACC_PRIV_VARM,
               V_ACC_PRIV_REGL,
               V_ACC_PRIV_REGM),
           RTRIM(V_ACC_FAMILIA),
           RTRIM(V_ACC_PROG_INI)
    INTO
           _PROFILE_NAME,
           _PROFILE_TYPE,
           _PRIVILEGES,
           _PROFILE_REALM,
           _MENU_NAME
    FROM  EcuACCPER
    WHERE V_ACC_CODE_NUM = _WSS_PROFILE_CODE;
    IF (FOUND_ROWS() = 0) THEN
        SET _MESSAGE_TEXT = 'Perfil especificado no existe';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = _MESSAGE_TEXT;
    END IF;

    -- Make sure user+proifle exist
    SELECT ID, LOGIN_STATE
    INTO   _LOGIN_ID, _LOGIN_STATE
    FROM   DESKTOPFX_LOGIN
    WHERE  USER_ID = _USER_ID
    AND    PROFILE_CODE = _WSS_PROFILE_CODE;
    IF (FOUND_ROWS() = 0) THEN
        INSERT DESKTOPFX_LOGIN (
            USER_ID, PROFILE_CODE
        ) VALUES (
            _USER_ID, _WSS_PROFILE_CODE
        );
        SET _LOGIN_ID = LAST_INSERT_ID();
    END IF;

    -- Make sure user+profile=-1 exists
    IF NOT EXISTS (SELECT *
        FROM  DESKTOPFX_LOGIN
        WHERE USER_ID = _USER_ID
        AND   PROFILE_CODE = -1)
    THEN
        INSERT DESKTOPFX_LOGIN (
            USER_ID, PROFILE_CODE
        ) VALUES (
            _USER_ID, -1
        );
    END IF;

    -- Return menu definition (DEFAULT if not defined)
    SELECT BYTES INTO _MENU_XML
    FROM   DESKTOPFX_OBJECT
    WHERE  LOGIN_ID = 0
    AND    TYPE = 4
    AND    NAME = _MENU_NAME;
    IF (FOUND_ROWS() = 0) THEN
        SET _MENU_NAME = 'DEFAULT';
        SELECT BYTES INTO _MENU_XML
        FROM   DESKTOPFX_OBJECT
        WHERE  LOGIN_ID = 0
        AND    TYPE = 4
        AND    NAME = _MENU_NAME;
    END IF;

    -- Return service definition (NULL if not defined)
    SELECT BYTES INTO _LOGIN_SERVICE
    FROM   DESKTOPFX_OBJECT
    WHERE  LOGIN_ID = 0
    AND    TYPE = 5
    AND    NAME = _SERVICE_NAME;

    -- Return login properties (NULL if not defined)
    SELECT BYTES INTO _LOGIN_PROPS
    FROM   DESKTOPFX_OBJECT
    WHERE  LOGIN_ID = _LOGIN_ID
    AND    TYPE = 1
    AND    NAME = 'LOGIN';

    -- Return global properties (NULL if not defined)
    SELECT BYTES INTO _GLOBAL_PROPS
    FROM   DESKTOPFX_OBJECT
    WHERE  LOGIN_ID = 0
    AND    TYPE = 1
    AND    NAME = 'LOGIN';

    -- #ResultSet _CAPACITY CAPACITIES
    --   #Column  CODE      VARCHAR
    --   #Column  NAME      VARCHAR
    --   #Column  TYPE      INTEGER
    --   #Column  VALUE     VARCHAR
    -- #EndResultSet
    SELECT RTRIM(C.CAP_CODIGO)  AS CODE, 
           RTRIM(C.CAP_NOMBRE)  AS NAME,
           C.CAP_TIPO           AS TYPE,
           RTRIM(U.CAP_VALOR)   AS VALUE
    FROM  EcuACCCAP C, EcuACCC2U U
    WHERE U.CODIGO_ADI = _WSS_USER_CODE
    AND   C.CAP_CODIGO = U.CAP_CODIGO
    UNION
    SELECT RTRIM(C.CAP_CODIGO)  AS CODE, 
           RTRIM(C.CAP_NOMBRE)  AS NAME,
           C.CAP_TIPO           AS TYPE,
           RTRIM(P.CAP_VALOR)   AS VALUE
    FROM  EcuACCCAP C, EcuACCC2P P
    WHERE P.CODIGO_ECU = _WSS_PROFILE_CODE
    AND   C.CAP_CODIGO = P.CAP_CODIGO
    AND   C.CAP_CODIGO NOT IN (
            SELECT CAP_CODIGO FROM EcuACCC2U 
            WHERE CODIGO_ADI = _WSS_USER_CODE)
    ORDER BY CODE;

    -- Update last-login-time and (maybe) first-login-time
    SET _FEC_ULT_LOG = DATE_FORMAT(SYSDATE(6),'%Y-%m-%d:%H:%i:%s.%f');
    IF (LENGTH(_FEC_PRI_LOG) > 0) THEN
        UPDATE EcuACCUSU
        SET    FEC_ULT_LOG = _FEC_ULT_LOG
        WHERE  USU_CODIGO = _WSS_USER_CODE;
    ELSE
        UPDATE EcuACCUSU
        SET    FEC_ULT_LOG = _FEC_ULT_LOG,
               FEC_PRI_LOG = _FEC_ULT_LOG
        WHERE  USU_CODIGO = _WSS_USER_CODE;
    END IF;
END$$
DELIMITER ;
