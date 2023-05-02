CREATE OR REPLACE PROCEDURE SECURITYFX$PROFILE_PUT
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
    PROFILE_CODE$           IN  INTEGER,
    NAME$                   IN  NVARCHAR2,
    FLAGS$                  IN  NVARCHAR2,
    MENU$                   IN  NVARCHAR2,
    DOMAIN$                 IN  NVARCHAR2,
    -- Privilege Properties
    PRIV_MENU$              IN  NVARCHAR2,
    PRIV_VARL$              IN  NVARCHAR2,
    PRIV_VARM$              IN  NVARCHAR2,
    PRIV_REGL$              IN  NVARCHAR2,
    PRIV_REGM$              IN  NVARCHAR2,
    -- Restriction Properties
    EXPIRES$                IN  INTEGER,
    HOUR_FROM$              IN  DECIMAL,
    HOUR_TO$                IN  DECIMAL,
    PWD_DAYS$               IN  INTEGER,
    -- Terminal Properties
    TERM_COUNT$             IN  INTEGER,
    TERMINAL01$             IN  NVARCHAR2,
    TERMINAL02$             IN  NVARCHAR2,
    TERMINAL03$             IN  NVARCHAR2,
    TERMINAL04$             IN  NVARCHAR2,
    TERMINAL05$             IN  NVARCHAR2,
    TERMINAL06$             IN  NVARCHAR2,
    TERMINAL07$             IN  NVARCHAR2,
    TERMINAL08$             IN  NVARCHAR2,
    TERMINAL09$             IN  NVARCHAR2,
    TERMINAL10$             IN  NVARCHAR2,
    TERMINAL11$             IN  NVARCHAR2,
    TERMINAL12$             IN  NVARCHAR2,
    TERMINAL13$             IN  NVARCHAR2,
    TERMINAL14$             IN  NVARCHAR2,
    TERMINAL15$             IN  NVARCHAR2,
    TERMINAL16$             IN  NVARCHAR2,
    -- Output Parameters
    CREATED$                OUT INTEGER
)
AS
BEGIN
    -- Asume the profile exists
    CREATED$ := 0;

    -- Update the properties of specified profile
    UPDATE EcuACCPER
    SET    V_ACC_NAME           = NVL(NAME$,' '),
           V_ACC_INDICADORES    = NVL(FLAGS$,' '),
           V_ACC_PROG_INI       = NVL(MENU$,' '),
           V_ACC_FAMILIA        = NVL(DOMAIN$,' '),
           -- Privilege Properties
           V_ACC_PRIV_MEN       = NVL(PRIV_MENU$,' '),
           V_ACC_PRIV_VARL      = NVL(PRIV_VARL$,' '),
           V_ACC_PRIV_VARM      = NVL(PRIV_VARM$,' '),
           V_ACC_PRIV_REGL      = NVL(PRIV_REGL$,' '),
           V_ACC_PRIV_REGM      = NVL(PRIV_REGM$,' '),
           -- Restriction Properties
           V_ACC_EXP            = EXPIRES$,
           V_ACC_HORA_INIC      = HOUR_FROM$,
           V_ACC_HORA_FIN       = HOUR_TO$,
           V_ACC_DIAS_VIG_PASSW = PWD_DAYS$,
           -- Terminal Properties
           V_ACC_CANT_TERM      = TERM_COUNT$,
           V_ACC_TERM_001       = NVL(TERMINAL01$,' '),
           V_ACC_TERM_002       = NVL(TERMINAL02$,' '),
           V_ACC_TERM_003       = NVL(TERMINAL03$,' '),
           V_ACC_TERM_004       = NVL(TERMINAL04$,' '),
           V_ACC_TERM_005       = NVL(TERMINAL05$,' '),
           V_ACC_TERM_006       = NVL(TERMINAL06$,' '),
           V_ACC_TERM_007       = NVL(TERMINAL07$,' '),
           V_ACC_TERM_008       = NVL(TERMINAL08$,' '),
           V_ACC_TERM_009       = NVL(TERMINAL09$,' '),
           V_ACC_TERM_010       = NVL(TERMINAL10$,' '),
           V_ACC_TERM_011       = NVL(TERMINAL11$,' '),
           V_ACC_TERM_012       = NVL(TERMINAL12$,' '),
           V_ACC_TERM_013       = NVL(TERMINAL13$,' '),
           V_ACC_TERM_014       = NVL(TERMINAL14$,' '),
           V_ACC_TERM_015       = NVL(TERMINAL15$,' '),
           V_ACC_TERM_016       = NVL(TERMINAL16$,' ')
    WHERE  V_ACC_CODE_NUM = PROFILE_CODE$;

    -- Create profile if it didn't exist
    IF (SQL%ROWCOUNT = 0) THEN
        INSERT INTO EcuACCPER(
             V_ACC_CODE_NUM
            ,V_ACC_NAME
            ,V_ACC_INDICADORES
            ,V_ACC_PROG_INI
            ,V_ACC_FAMILIA
            -- Privilege Properties
            ,V_ACC_PRIV_MEN
            ,V_ACC_PRIV_VARL
            ,V_ACC_PRIV_VARM
            ,V_ACC_PRIV_REGL
            ,V_ACC_PRIV_REGM
            -- Restriction Properties
            ,V_ACC_EXP
            ,V_ACC_HORA_INIC
            ,V_ACC_HORA_FIN
            ,V_ACC_DIAS_VIG_PASSW
            -- Terminal Properties
            ,V_ACC_CANT_TERM
            ,V_ACC_TERM_001
            ,V_ACC_TERM_002
            ,V_ACC_TERM_003
            ,V_ACC_TERM_004
            ,V_ACC_TERM_005
            ,V_ACC_TERM_006
            ,V_ACC_TERM_007
            ,V_ACC_TERM_008
            ,V_ACC_TERM_009
            ,V_ACC_TERM_010
            ,V_ACC_TERM_011
            ,V_ACC_TERM_012
            ,V_ACC_TERM_013
            ,V_ACC_TERM_014
            ,V_ACC_TERM_015
            ,V_ACC_TERM_016
        ) VALUES (
             PROFILE_CODE$
            ,NVL(NAME$,' ')
            ,NVL(FLAGS$,' ')
            ,NVL(MENU$,' ')
            ,NVL(DOMAIN$,' ')
            -- Privilege Properties
            ,NVL(PRIV_MENU$,' ')
            ,NVL(PRIV_VARL$,' ')
            ,NVL(PRIV_VARM$,' ')
            ,NVL(PRIV_REGL$,' ')
            ,NVL(PRIV_REGM$,' ')
            -- Restriction Properties
            ,EXPIRES$
            ,HOUR_FROM$
            ,HOUR_TO$
            ,PWD_DAYS$
            -- Terminal Properties
            ,TERM_COUNT$
            ,NVL(TERMINAL01$,' ')
            ,NVL(TERMINAL02$,' ')
            ,NVL(TERMINAL03$,' ')
            ,NVL(TERMINAL04$,' ')
            ,NVL(TERMINAL05$,' ')
            ,NVL(TERMINAL06$,' ')
            ,NVL(TERMINAL07$,' ')
            ,NVL(TERMINAL08$,' ')
            ,NVL(TERMINAL09$,' ')
            ,NVL(TERMINAL10$,' ')
            ,NVL(TERMINAL11$,' ')
            ,NVL(TERMINAL12$,' ')
            ,NVL(TERMINAL13$,' ')
            ,NVL(TERMINAL14$,' ')
            ,NVL(TERMINAL15$,' ')
            ,NVL(TERMINAL16$,' ')
        );
        CREATED$ := 1;
    END IF;

    -- Generate an audit record
    IF (CREATED$ = 0) THEN
        SECURITYFX$AUDIT_PUT(
            WSS_USER_CODE$, WSS_PROFILE_CODE$, WSS_STATION_CODE$,
            56, 'Perfil fue modificado: ' || PROFILE_CODE$);
    ELSE
        SECURITYFX$AUDIT_PUT(
            WSS_USER_CODE$, WSS_PROFILE_CODE$, WSS_STATION_CODE$,
            55, 'Perfil fue creado: ' || PROFILE_CODE$);
    END IF;
END SECURITYFX$PROFILE_PUT;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
