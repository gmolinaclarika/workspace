DROP PROCEDURE IF EXISTS DESKTOPFX$LOGIN_CHECK;

DELIMITER $$
CREATE PROCEDURE DESKTOPFX$LOGIN_CHECK (
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
    -- Login properties -----------------
    OUT _LOGIN_STATE        LONGBLOB,
    OUT _LOGIN_SERVICE      LONGBLOB,
    OUT _LOGIN_PROPS        LONGBLOB,
    OUT _GLOBAL_PROPS       LONGBLOB
)
BEGIN
    DECLARE _REAL_WORD    VARCHAR(200);
    DECLARE _USER_STATE   VARCHAR(2);
    DECLARE _MESSAGE_TEXT VARCHAR(200);

    -- Init outputs
    SET _OFFICE_TYPE = 0;
    SET _MENU_XML = NULL;
    SET _LOGIN_PROPS = NULL;
    SET _GLOBAL_PROPS = NULL;
    SET _LOGIN_SERVICE = NULL;

    -- Obtain real user word
    SELECT PASSWORD, RTRIM(USU_ESTADO)
    INTO   _REAL_WORD, _USER_STATE
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
        SET _MESSAGE_TEXT = 'El usuario no esta habilitado';
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

    -- #ResultSet _CAPACITY CAPACITIES
    --   #Column  CODE      VARCHAR
    --   #Column  NAME      VARCHAR
    --   #Column  TYPE      INTEGER
    --   #Column  VALUE     VARCHAR
    -- #EndResultSet
    SELECT C.CAP_CODIGO     AS CODE, 
           C.CAP_NOMBRE     AS NAME,
           C.CAP_TIPO       AS TYPE,
           U.CAP_VALOR      AS VALUE
    FROM  EcuACCCAP C, EcuACCC2U U
    WHERE U.CODIGO_ADI = _WSS_USER_CODE
    AND   C.CAP_CODIGO = U.CAP_CODIGO
    UNION
    SELECT C.CAP_CODIGO     AS CODE, 
           C.CAP_NOMBRE     AS NAME,
           C.CAP_TIPO       AS TYPE,
           P.CAP_VALOR      AS VALUE
    FROM  EcuACCCAP C, EcuACCC2P P
    WHERE P.CODIGO_ECU = _WSS_PROFILE_CODE
    AND   C.CAP_CODIGO = P.CAP_CODIGO
    AND   C.CAP_CODIGO NOT IN (
            SELECT CAP_CODIGO FROM EcuACCC2U 
            WHERE CODIGO_ADI = _WSS_USER_CODE)
    ORDER BY CODE;
END$$
DELIMITER ;
