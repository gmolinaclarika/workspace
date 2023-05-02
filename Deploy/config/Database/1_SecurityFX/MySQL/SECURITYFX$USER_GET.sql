DROP PROCEDURE IF EXISTS SECURITYFX$USER_GET;

DELIMITER $$
CREATE PROCEDURE SECURITYFX$USER_GET (
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
    IN  _USER_CODE          VARCHAR(100),
    -- General Properties ---------------
    OUT _CODE               VARCHAR(100),
    OUT _GIVEN_NAMES        VARCHAR(100),
    OUT _FATHER_NAME        VARCHAR(100),
    OUT _MOTHER_NAME        VARCHAR(100),
    OUT _POSITION           VARCHAR(100),
    OUT _USER_RUT           VARCHAR(100),
    OUT _DOMAIN             VARCHAR(100),
    OUT _USER_STATE         VARCHAR(100),
    OUT _VALID_FROM         INTEGER,
    OUT _VALID_TO           INTEGER,
    -- Contact Properties ---------------
    OUT _ADDRESS            VARCHAR(100),
    OUT _COUNTY             VARCHAR(100),
    OUT _CITY               VARCHAR(100),
    OUT _STATE              VARCHAR(100),
    OUT _COUNTRY            VARCHAR(100),
    OUT _PHONE1             VARCHAR(100),
    OUT _PHONE2             VARCHAR(100),
    OUT _FAX                VARCHAR(100),
    OUT _EMAIL              VARCHAR(100),
    -- Authentication Properties --------
    OUT _CERT_ID            VARCHAR(100),
    OUT _CERT_STATE         VARCHAR(100),
    OUT _CERT_REQST         VARCHAR(100),
    OUT _PWD_TYPE           VARCHAR(100),
    OUT _PWD_DAYS           INTEGER,
    OUT _PWD_STATE          VARCHAR(100),
    -- Billing Properties ---------------
    OUT _BILLING_TYPE       VARCHAR(100),
    OUT _BILLING_CODE       VARCHAR(100),
    OUT _CONTRACT_CODE      VARCHAR(100),
    OUT _CONTRACT_ANNEX     VARCHAR(100),
    OUT _COMPANY_RUT        VARCHAR(100)
)
BEGIN
    DECLARE _MESSAGE_TEXT VARCHAR(200);

    -- Normalize specified user name
    SET _USER_CODE = UPPER(RTRIM(_USER_CODE));

    -- Return the properties of specified user
    SELECT
        -- General Properties
        RTRIM(USU_CODIGO),
        RTRIM(NOMBRES),
        RTRIM(APELLIDO_PAT),
        RTRIM(APELLIDO_MAT),
        RTRIM(CARGO),
        RTRIM(RUT),
        RTRIM(FAMILIA),
        RTRIM(USU_ESTADO),
        FEC_VIG_DESD,
        FEC_VIG_HAST,
        -- Contact Properties
        RTRIM(DIRECCION),
        RTRIM(COMUNA),
        RTRIM(CIUDAD),
        RTRIM(ESTADO),
        RTRIM(PAIS),
        RTRIM(FONO1),
        RTRIM(FONO2),
        RTRIM(FAX),
        RTRIM(EMAIL),
        -- Authentication Properties
        RTRIM(CERTIF_ID),
        'NT',
        ' ',
        RTRIM(PSW_TIPO),
        PSW_DIAS_CADUC,
        RTRIM(PSW_ESTADO),
        -- Billing Properties
        RTRIM(FACTURACION),
        RTRIM(COD_FACTURACION),
        RTRIM(COD_CONTRATO),
        RTRIM(ANEXO_CONTRATO),
        RTRIM(RUT_INST)
    INTO
        -- General Properties
        _CODE,
        _GIVEN_NAMES,
        _FATHER_NAME,
        _MOTHER_NAME,
        _POSITION,
        _USER_RUT,
        _DOMAIN,
        _USER_STATE,
        _VALID_FROM,
        _VALID_TO,
        -- Contact Properties
        _ADDRESS,
        _COUNTY,
        _CITY,
        _STATE,
        _COUNTRY,
        _PHONE1,
        _PHONE2,
        _FAX,
        _EMAIL,
        -- Authentication Properties
        _CERT_ID,
        _CERT_STATE,
        _CERT_REQST,
        _PWD_TYPE,
        _PWD_DAYS,
        _PWD_STATE,
        -- Billing Properties
        _BILLING_TYPE,
        _BILLING_CODE,
        _CONTRACT_CODE,
        _CONTRACT_ANNEX,
        _COMPANY_RUT
    FROM   EcuACCUSU
    WHERE  USU_CODIGO = _USER_CODE;
    IF (FOUND_ROWS() = 0) THEN
        SET _MESSAGE_TEXT = CONCAT('Usuario no está definido: ', _USER_CODE);
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = _MESSAGE_TEXT;
    END IF;

    -- #ResultSet PROFILE PROFILES
    --   #Column  CODE      INTEGER
    --   #Column  NAME      VARCHAR
    -- #EndResultSet
    SELECT P.V_ACC_CODE_NUM     AS CODE, 
           RTRIM(P.V_ACC_NAME)  AS NAME
    FROM  EcuACCPER P, EcuACCU2P X
    WHERE P.V_ACC_CODE_NUM = X.CODIGO_ECU
    AND   X.CODIGO_ADI = _USER_CODE
    ORDER BY P.V_ACC_CODE_NUM;

    -- #ResultSet CAPACITY CAPACITIES
    --   #Column  CODE      VARCHAR
    --   #Column  VALUE     VARCHAR
    -- #EndResultSet
    SELECT CAP_CODIGO       AS CODE, 
           CAP_VALOR        AS VALUE
    FROM  EcuACCC2U
    WHERE CODIGO_ADI = _USER_CODE
    ORDER BY CAP_CODIGO;
END$$
DELIMITER ;
