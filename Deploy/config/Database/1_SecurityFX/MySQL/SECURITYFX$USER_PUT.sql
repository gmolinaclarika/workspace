DROP PROCEDURE IF EXISTS SECURITYFX$USER_PUT;

DELIMITER $$
CREATE PROCEDURE SECURITYFX$USER_PUT (
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
    IN  _GIVEN_NAMES        VARCHAR(100),
    IN  _FATHER_NAME        VARCHAR(100),
    IN  _MOTHER_NAME        VARCHAR(100),
    IN  _POSITION           VARCHAR(100),
    IN  _USER_RUT           VARCHAR(100),
    IN  _DOMAIN             VARCHAR(100),
    IN  _USER_STATE         VARCHAR(100),
    IN  _VALID_FROM         INTEGER,
    IN  _VALID_TO           INTEGER,
    -- Contact Properties ---------------
    IN  _ADDRESS            VARCHAR(100),
    IN  _COUNTY             VARCHAR(100),
    IN  _CITY               VARCHAR(100),
    IN  _STATE              VARCHAR(100),
    IN  _COUNTRY            VARCHAR(100),
    IN  _PHONE1             VARCHAR(100),
    IN  _PHONE2             VARCHAR(100),
    IN  _FAX                VARCHAR(100),
    IN  _EMAIL              VARCHAR(100),
    -- Authentication Properties --------
    IN  _CERT_ID            VARCHAR(100),
    IN  _CERT_STATE         VARCHAR(100),
    IN  _CERT_REQST         VARCHAR(100),
    IN  _PWD_TYPE           VARCHAR(100),
    IN  _PWD_DAYS           INTEGER,
    IN  _PWD_STATE          VARCHAR(100),
    IN  _PWD_TEXT           VARCHAR(100),
    -- Billing Properties ---------------
    IN  _BILLING_TYPE       VARCHAR(100),
    IN  _BILLING_CODE       VARCHAR(100),
    IN  _CONTRACT_CODE      VARCHAR(100),
    IN  _CONTRACT_ANNEX     VARCHAR(100),
    IN  _COMPANY_RUT        VARCHAR(100),
    -- User Profiles --------------------
    IN  _PROFILES           VARCHAR(4000),
    -- Output Parameters ----------------
    OUT _CREATED            INTEGER
)
BEGIN
    DECLARE _INDEX          INTEGER;
    DECLARE _PROFILE_CODE   INTEGER;
    DECLARE _AUDIT_EVENT    INTEGER;
    DECLARE _AUDIT_MESSAGE  VARCHAR(100);
    DECLARE _MESSAGE_TEXT   VARCHAR(200);

    -- Asume the user exists
    SET _CREATED = 0;

    -- Normalize specified user name
    SET _USER_CODE = UPPER(RTRIM(_USER_CODE));

    -- Update the properties of specified user
    UPDATE EcuACCUSU
    SET    NOMBRES          = IFNULL(_GIVEN_NAMES,''),
           APELLIDO_PAT     = IFNULL(_FATHER_NAME,''),
           APELLIDO_MAT     = IFNULL(_MOTHER_NAME,''),
           CARGO            = IFNULL(_POSITION,''),
           RUT              = IFNULL(_USER_RUT,''),
           FAMILIA          = IFNULL(_DOMAIN,''),
           USU_ESTADO       = IFNULL(_USER_STATE,''),
           FEC_VIG_DESD     = _VALID_FROM,
           FEC_VIG_HAST     = _VALID_TO,
           -- Contact Properties
           DIRECCION        = IFNULL(_ADDRESS,''),
           COMUNA           = IFNULL(_COUNTY,''),
           CIUDAD           = IFNULL(_CITY,''),
           ESTADO           = IFNULL(_STATE,''),
           PAIS             = IFNULL(_COUNTRY,''),
           FONO1            = IFNULL(_PHONE1,''),
           FONO2            = IFNULL(_PHONE2,''),
           FAX              = IFNULL(_FAX,''),
           EMAIL            = IFNULL(_EMAIL,''),
           -- Authentication Properties
           CERTIF_ID        = IFNULL(_CERT_ID,''),
           PSW_TIPO         = IFNULL(_PWD_TYPE,''),
           PSW_DIAS_CADUC   = _PWD_DAYS,
           PSW_ESTADO       = IFNULL(_PWD_STATE,''),
           -- Billing Properties
           FACTURACION      = IFNULL(_BILLING_TYPE,''),
           COD_FACTURACION  = IFNULL(_BILLING_CODE,''),
           COD_CONTRATO     = IFNULL(_CONTRACT_CODE,''),
           ANEXO_CONTRATO   = IFNULL(_CONTRACT_ANNEX,''),
           RUT_INST         = IFNULL(_COMPANY_RUT,'')
    WHERE  USU_CODIGO = _USER_CODE;

    -- Create user if it didn't exist
    IF (ROW_COUNT() = 0) THEN
        INSERT INTO EcuACCUSU (
             USU_CODIGO
            -- General Properties
            ,NOMBRES
            ,APELLIDO_PAT
            ,APELLIDO_MAT
            ,CARGO
            ,RUT
            ,FAMILIA
            ,USU_ESTADO
            ,FEC_VIG_DESD
            ,FEC_VIG_HAST
            ,FEC_CRE_USU
            -- Contact Properties
            ,DIRECCION
            ,COMUNA
            ,CIUDAD
            ,ESTADO
            ,PAIS
            ,FONO1
            ,FONO2
            ,FAX
            ,EMAIL
            -- Authentication Properties
            ,CERTIF_ID
            ,PSW_TIPO
            ,PSW_DIAS_CADUC
            ,PSW_ESTADO
            -- Billing Properties
            ,FACTURACION
            ,COD_FACTURACION
            ,COD_CONTRATO
            ,ANEXO_CONTRATO
            ,RUT_INST
        ) VALUES (
             _USER_CODE
            -- General Properties
            ,IFNULL(_GIVEN_NAMES,'')
            ,IFNULL(_FATHER_NAME,'')
            ,IFNULL(_MOTHER_NAME,'')
            ,IFNULL(_POSITION,'')
            ,IFNULL(_USER_RUT,'')
            ,IFNULL(_DOMAIN,'')
            ,IFNULL(_USER_STATE,'')
            ,_VALID_FROM
            ,_VALID_TO
            ,DATE_FORMAT(SYSDATE(6),'%Y-%m-%d:%H:%i:%s.%f')
            -- Contact Properties
            ,IFNULL(_ADDRESS,'')
            ,IFNULL(_COUNTY,'')
            ,IFNULL(_CITY,'')
            ,IFNULL(_STATE,'')
            ,IFNULL(_COUNTRY,'')
            ,IFNULL(_PHONE1,'')
            ,IFNULL(_PHONE2,'')
            ,IFNULL(_FAX,'')
            ,IFNULL(_EMAIL,'')
            -- Authentication Properties
            ,IFNULL(_CERT_ID,'')
            ,IFNULL(_PWD_TYPE,'')
            ,_PWD_DAYS
            ,IFNULL(_PWD_STATE,'')
            -- Billing Properties
            ,IFNULL(_BILLING_TYPE,'')
            ,IFNULL(_BILLING_CODE,'')
            ,IFNULL(_CONTRACT_CODE,'')
            ,IFNULL(_CONTRACT_ANNEX,'')
            ,IFNULL(_COMPANY_RUT,'')
        );
        SET _CREATED = 1;
    END IF;

    -- Update the user password (if supplied)
    SET _PWD_TEXT = RTRIM(_PWD_TEXT);
    IF (LENGTH(_PWD_TEXT) > 0) THEN
        UPDATE EcuACCUSU
        SET    PSW_ULTIMAS_006 = PSW_ULTIMAS_005,
               PSW_ULTIMAS_005 = PSW_ULTIMAS_004,
               PSW_ULTIMAS_004 = PSW_ULTIMAS_003,
               PSW_ULTIMAS_003 = PSW_ULTIMAS_002,
               PSW_ULTIMAS_002 = PSW_ULTIMAS_001,
               PSW_ULTIMAS_001 = PASSWORD,
               PASSWORD        = _PWD_TEXT,
               PSW_ESTADO      = 'EXP',
               PSW_VIG_DESD    = 0
        WHERE  USU_CODIGO = _USER_CODE;
    END IF;

    -- Delete all profiles of the user
    DELETE FROM EcuACCU2P
    WHERE CODIGO_ADI = _USER_CODE;

    -- Insert the supplied user profiles
    SET _PROFILES = RTRIM(_PROFILES);
    PROFILES_LOOP: WHILE (LENGTH(_PROFILES) > 0) DO
        -- Locate "<LF>" of next "ProfileID<LF>"
        SET _INDEX = INSTR(_PROFILES, CHAR(10));
        IF (_INDEX = 0) THEN
            LEAVE PROFILES_LOOP;
        END IF;

        -- Extract "ProfileCode" from list of profiles
        SET _PROFILE_CODE = LEFT(_PROFILES, _INDEX - 1);
        SET _PROFILES = SUBSTRING(_PROFILES, _INDEX + 1);

        -- Verify that the profile code exists
        IF NOT EXISTS(SELECT * FROM EcuACCPER 
            WHERE V_ACC_CODE_NUM = _PROFILE_CODE)
        THEN
            SET _MESSAGE_TEXT = CONCAT('Perfil no está definido: ', _PROFILE_CODE);
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = _MESSAGE_TEXT;
        END IF;

        -- Assign a new profile to the user
        INSERT INTO EcuACCU2P (CODIGO_ADI, CODIGO_ECU)
        VALUES (_USER_CODE, _PROFILE_CODE);
    END WHILE;

    -- Generate an audit record
    IF (_CREATED = 0) THEN
        SET _AUDIT_EVENT = 15;
        SET _AUDIT_MESSAGE = CONCAT('Usuario fue modificado: ', _USER_CODE);
    ELSE
        SET _AUDIT_EVENT = 13;
        SET _AUDIT_MESSAGE = CONCAT('Usuario fue creado: ', _USER_CODE);
    END IF;
    CALL SECURITYFX$AUDIT_PUT(
        _WSS_USER_CODE, _WSS_PROFILE_CODE, _WSS_STATION_CODE, 
        _AUDIT_EVENT, _AUDIT_MESSAGE);
END$$
DELIMITER ;
