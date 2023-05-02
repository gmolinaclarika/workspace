CREATE OR REPLACE PROCEDURE SECURITYFX$USER_PUT
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
    USER_CODE$              IN  NVARCHAR2,
    -- General Properties
    GIVEN_NAMES$            IN  NVARCHAR2,
    FATHER_NAME$            IN  NVARCHAR2,
    MOTHER_NAME$            IN  NVARCHAR2,
    POSITION$               IN  NVARCHAR2,
    USER_RUT$               IN  NVARCHAR2,
    DOMAIN$                 IN  NVARCHAR2,
    USER_STATE$             IN  NVARCHAR2,
    VALID_FROM$             IN  INTEGER,
    VALID_TO$               IN  INTEGER,
    -- Contact Properties
    ADDRESS$                IN  NVARCHAR2,
    COUNTY$                 IN  NVARCHAR2,
    CITY$                   IN  NVARCHAR2,
    STATE$                  IN  NVARCHAR2,
    COUNTRY$                IN  NVARCHAR2,
    PHONE1$                 IN  NVARCHAR2,
    PHONE2$                 IN  NVARCHAR2,
    FAX$                    IN  NVARCHAR2,
    EMAIL$                  IN  NVARCHAR2,
    -- Authentication Properties
    CERT_ID$                IN  NVARCHAR2,
    CERT_STATE$             IN  NVARCHAR2,
    CERT_REQST$             IN  NVARCHAR2,
    PWD_TYPE$               IN  NVARCHAR2,
    PWD_DAYS$               IN  INTEGER,
    PWD_STATE$              IN  NVARCHAR2,
    PWD_TEXT$               IN  NVARCHAR2,
    -- Billing Properties
    BILLING_TYPE$           IN  NVARCHAR2,
    BILLING_CODE$           IN  NVARCHAR2,
    CONTRACT_CODE$          IN  NVARCHAR2,
    CONTRACT_ANNEX$         IN  NVARCHAR2,
    COMPANY_RUT$            IN  NVARCHAR2,
    -- User Profiles
    PROFILES$               IN  NVARCHAR2,
    -- Output Parameters
    CREATED$                OUT INTEGER
)
AS
    DUMMY$                  NUMBER;
    INDEX$                  INTEGER;
    PROFILE_CODE$           INTEGER;
    PROFILES$$              NVARCHAR2(4000);
    PWD_TEXT$$              EcuACCUSU.PASSWORD%TYPE;
    USU_CODIGO$             EcuACCUSU.USU_CODIGO%TYPE;
BEGIN
    -- Asume the user exists
    CREATED$ := 0;

    -- Normalize specified user name
    USU_CODIGO$ := UPPER(RTRIM(USER_CODE$));

    -- Update the properties of specified user
    UPDATE EcuACCUSU
    SET    NOMBRES          = NVL(GIVEN_NAMES$,' '),
           APELLIDO_PAT     = NVL(FATHER_NAME$,' '),
           APELLIDO_MAT     = NVL(MOTHER_NAME$,' '),
           CARGO            = NVL(POSITION$,' '),
           RUT              = NVL(USER_RUT$,' '),
           FAMILIA          = NVL(DOMAIN$,' '),
           USU_ESTADO       = NVL(USER_STATE$,' '),
           FEC_VIG_DESD     = VALID_FROM$,
           FEC_VIG_HAST     = VALID_TO$,
           -- Contact Properties
           DIRECCION        = NVL(ADDRESS$,' '),
           COMUNA           = NVL(COUNTY$,' '),
           CIUDAD           = NVL(CITY$,' '),
           ESTADO           = NVL(STATE$,' '),
           PAIS             = NVL(COUNTRY$,' '),
           FONO1            = NVL(PHONE1$,' '),
           FONO2            = NVL(PHONE2$,' '),
           FAX              = NVL(FAX$,' '),
           EMAIL            = NVL(EMAIL$,' '),
           -- Authentication Properties
           CERTIF_ID        = NVL(CERT_ID$,' '),
           PSW_TIPO         = NVL(PWD_TYPE$,' '),
           PSW_DIAS_CADUC   = PWD_DAYS$,
           PSW_ESTADO       = NVL(PWD_STATE$,' '),
           -- Billing Properties
           FACTURACION      = NVL(BILLING_TYPE$,' '),
           COD_FACTURACION  = NVL(BILLING_CODE$,' '),
           COD_CONTRATO     = NVL(CONTRACT_CODE$,' '),
           ANEXO_CONTRATO   = NVL(CONTRACT_ANNEX$,' '),
           RUT_INST         = NVL(COMPANY_RUT$,' ')
    WHERE  USU_CODIGO = USU_CODIGO$;

    -- Create user if it didn't exist
    IF (SQL%ROWCOUNT = 0) THEN
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
             USU_CODIGO$
            -- General Properties
            ,NVL(GIVEN_NAMES$,' ')
            ,NVL(FATHER_NAME$,' ')
            ,NVL(MOTHER_NAME$,' ')
            ,NVL(POSITION$,' ')
            ,NVL(USER_RUT$,' ')
            ,NVL(DOMAIN$,' ')
            ,NVL(USER_STATE$,' ')
            ,VALID_FROM$
            ,VALID_TO$
            ,TO_CHAR(SYSTIMESTAMP,'YYYY-MM-DD:HH24:MI:SS.FF6')
            -- Contact Properties
            ,NVL(ADDRESS$,' ')
            ,NVL(COUNTY$,' ')
            ,NVL(CITY$,' ')
            ,NVL(STATE$,' ')
            ,NVL(COUNTRY$,' ')
            ,NVL(PHONE1$,' ')
            ,NVL(PHONE2$,' ')
            ,NVL(FAX$,' ')
            ,NVL(EMAIL$,' ')
            -- Authentication Properties
            ,NVL(CERT_ID$,' ')
            ,NVL(PWD_TYPE$,' ')
            ,PWD_DAYS$
            ,NVL(PWD_STATE$,' ')
            -- Billing Properties
            ,NVL(BILLING_TYPE$,' ')
            ,NVL(BILLING_CODE$,' ')
            ,NVL(CONTRACT_CODE$,' ')
            ,NVL(CONTRACT_ANNEX$,' ')
            ,NVL(COMPANY_RUT$,' ')
        );
        CREATED$ := 1;
    END IF;

    -- Update the user password (if supplied)
    PWD_TEXT$$ := RTRIM(PWD_TEXT$);
    IF (PWD_TEXT$$ IS NOT NULL) THEN
        UPDATE EcuACCUSU
        SET    PSW_ULTIMAS_006 = PSW_ULTIMAS_005,
               PSW_ULTIMAS_005 = PSW_ULTIMAS_004,
               PSW_ULTIMAS_004 = PSW_ULTIMAS_003,
               PSW_ULTIMAS_003 = PSW_ULTIMAS_002,
               PSW_ULTIMAS_002 = PSW_ULTIMAS_001,
               PSW_ULTIMAS_001 = PASSWORD,
               PASSWORD        = PWD_TEXT$$,
               PSW_ESTADO      = 'EXP',
               PSW_VIG_DESD    = 0
        WHERE  USU_CODIGO = USU_CODIGO$;
    END IF;

    -- Delete all profiles of the user
    DELETE FROM EcuACCU2P
    WHERE CODIGO_ADI = USU_CODIGO$;

    -- Insert the supplied user profiles
    PROFILES$$ := RTRIM(PROFILES$);
    WHILE (PROFILES$$ IS NOT NULL) LOOP
        -- Locate "<LF>" of next "ProfileID<LF>"
        INDEX$ := INSTR(PROFILES$$, CHR(10));
        EXIT WHEN (INDEX$ = 0);

        -- Extract "ProfileCode" from list of profiles
        PROFILE_CODE$ := TO_NUMBER(SUBSTR(PROFILES$$, 1, INDEX$ - 1));
        PROFILES$$ := SUBSTR(PROFILES$$, INDEX$ + 1);

        -- Verify that the profile code exists
        BEGIN
            SELECT NULL INTO DUMMY$ FROM EcuACCPER
            WHERE  V_ACC_CODE_NUM = PROFILE_CODE$;
        EXCEPTION WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20005, 'Perfil no está definido: ' || PROFILE_CODE$);
        END;

        -- Assign a new profile to the user
        INSERT INTO EcuACCU2P
            (CODIGO_ADI, CODIGO_ECU)
        VALUES 
            (USU_CODIGO$, PROFILE_CODE$);
    END LOOP;

    -- Generate an audit record
    IF (CREATED$ = 0) THEN
        SECURITYFX$AUDIT_PUT(
            WSS_USER_CODE$, WSS_PROFILE_CODE$, WSS_STATION_CODE$, 
            15, 'Usuario fue modificado: ' || USER_CODE$);
    ELSE
        SECURITYFX$AUDIT_PUT(
            WSS_USER_CODE$, WSS_PROFILE_CODE$, WSS_STATION_CODE$, 
            13, 'Usuario fue creado: ' || USER_CODE$);
    END IF;
END SECURITYFX$USER_PUT;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
