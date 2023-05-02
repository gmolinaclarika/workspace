DROP PROCEDURE IF EXISTS SECURITYFX$PROFILE_PUT;

DELIMITER $$
CREATE PROCEDURE SECURITYFX$PROFILE_PUT (
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
    IN  _PROFILE_CODE       INTEGER,
    IN  _NAME               VARCHAR(100),
    IN  _FLAGS              VARCHAR(100),
    IN  _MENU               VARCHAR(100),
    IN  _DOMAIN             VARCHAR(100),
    -- Privilege Properties -------------
    IN  _PRIV_MENU          VARCHAR(100),
    IN  _PRIV_VARL          VARCHAR(100),
    IN  _PRIV_VARM          VARCHAR(100),
    IN  _PRIV_REGL          VARCHAR(100),
    IN  _PRIV_REGM          VARCHAR(100),
    -- Restriction Properties -----------
    IN  _EXPIRES            INTEGER,
    IN  _HOUR_FROM          DECIMAL(4,2),
    IN  _HOUR_TO            DECIMAL(4,2),
    IN  _PWD_DAYS           INTEGER,
    -- Terminal Properties --------------
    IN  _TERM_COUNT         INTEGER,
    IN  _TERMINAL01         VARCHAR(100),
    IN  _TERMINAL02         VARCHAR(100),
    IN  _TERMINAL03         VARCHAR(100),
    IN  _TERMINAL04         VARCHAR(100),
    IN  _TERMINAL05         VARCHAR(100),
    IN  _TERMINAL06         VARCHAR(100),
    IN  _TERMINAL07         VARCHAR(100),
    IN  _TERMINAL08         VARCHAR(100),
    IN  _TERMINAL09         VARCHAR(100),
    IN  _TERMINAL10         VARCHAR(100),
    IN  _TERMINAL11         VARCHAR(100),
    IN  _TERMINAL12         VARCHAR(100),
    IN  _TERMINAL13         VARCHAR(100),
    IN  _TERMINAL14         VARCHAR(100),
    IN  _TERMINAL15         VARCHAR(100),
    IN  _TERMINAL16         VARCHAR(100),
    -- Output Parameters
    OUT _CREATED            INTEGER
)
BEGIN
    DECLARE _AUDIT_EVENT    INTEGER;
    DECLARE _AUDIT_MESSAGE  VARCHAR(100);

    -- Asume the profile exists
    SET _CREATED = 0;

    -- Update the properties of specified profile
    UPDATE EcuACCPER
    SET    V_ACC_NAME           = IFNULL(_NAME,''),
           V_ACC_INDICADORES    = IFNULL(_FLAGS,''),
           V_ACC_PROG_INI       = IFNULL(_MENU,''),
           V_ACC_FAMILIA        = IFNULL(_DOMAIN,''),
           -- Privilege Properties
           V_ACC_PRIV_MEN       = IFNULL(_PRIV_MENU,''),
           V_ACC_PRIV_VARL      = IFNULL(_PRIV_VARL,''),
           V_ACC_PRIV_VARM      = IFNULL(_PRIV_VARM,''),
           V_ACC_PRIV_REGL      = IFNULL(_PRIV_REGL,''),
           V_ACC_PRIV_REGM      = IFNULL(_PRIV_REGM,''),
           -- Restriction Properties
           V_ACC_EXP            = _EXPIRES,
           V_ACC_HORA_INIC      = _HOUR_FROM,
           V_ACC_HORA_FIN       = _HOUR_TO,
           V_ACC_DIAS_VIG_PASSW = _PWD_DAYS,
           -- Terminal Properties
           V_ACC_CANT_TERM      = _TERM_COUNT,
           V_ACC_TERM_001       = IFNULL(_TERMINAL01,''),
           V_ACC_TERM_002       = IFNULL(_TERMINAL02,''),
           V_ACC_TERM_003       = IFNULL(_TERMINAL03,''),
           V_ACC_TERM_004       = IFNULL(_TERMINAL04,''),
           V_ACC_TERM_005       = IFNULL(_TERMINAL05,''),
           V_ACC_TERM_006       = IFNULL(_TERMINAL06,''),
           V_ACC_TERM_007       = IFNULL(_TERMINAL07,''),
           V_ACC_TERM_008       = IFNULL(_TERMINAL08,''),
           V_ACC_TERM_009       = IFNULL(_TERMINAL09,''),
           V_ACC_TERM_010       = IFNULL(_TERMINAL10,''),
           V_ACC_TERM_011       = IFNULL(_TERMINAL11,''),
           V_ACC_TERM_012       = IFNULL(_TERMINAL12,''),
           V_ACC_TERM_013       = IFNULL(_TERMINAL13,''),
           V_ACC_TERM_014       = IFNULL(_TERMINAL14,''),
           V_ACC_TERM_015       = IFNULL(_TERMINAL15,''),
           V_ACC_TERM_016       = IFNULL(_TERMINAL16,'')
    WHERE  V_ACC_CODE_NUM = _PROFILE_CODE;

    -- Create profile if it didn't exist
    IF (ROW_COUNT() = 0) THEN
        INSERT INTO EcuACCPER (
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
             _PROFILE_CODE
            ,IFNULL(_NAME,'')
            ,IFNULL(_FLAGS,'')
            ,IFNULL(_MENU,'')
            ,IFNULL(_DOMAIN,'')
            -- Privilege Properties
            ,IFNULL(_PRIV_MENU,'')
            ,IFNULL(_PRIV_VARL,'')
            ,IFNULL(_PRIV_VARM,'')
            ,IFNULL(_PRIV_REGL,'')
            ,IFNULL(_PRIV_REGM,'')
            -- Restriction Properties
            ,_EXPIRES
            ,_HOUR_FROM
            ,_HOUR_TO
            ,_PWD_DAYS
            -- Terminal Properties
            ,_TERM_COUNT
            ,IFNULL(_TERMINAL01,'')
            ,IFNULL(_TERMINAL02,'')
            ,IFNULL(_TERMINAL03,'')
            ,IFNULL(_TERMINAL04,'')
            ,IFNULL(_TERMINAL05,'')
            ,IFNULL(_TERMINAL06,'')
            ,IFNULL(_TERMINAL07,'')
            ,IFNULL(_TERMINAL08,'')
            ,IFNULL(_TERMINAL09,'')
            ,IFNULL(_TERMINAL10,'')
            ,IFNULL(_TERMINAL11,'')
            ,IFNULL(_TERMINAL12,'')
            ,IFNULL(_TERMINAL13,'')
            ,IFNULL(_TERMINAL14,'')
            ,IFNULL(_TERMINAL15,'')
            ,IFNULL(_TERMINAL16,'')
        );
        SET _CREATED = 1;
    END IF;

    -- Generate an audit record
    IF (_CREATED = 0) THEN
        SET _AUDIT_EVENT = 56;
        SET _AUDIT_MESSAGE = CONCAT('Perfil fue modificado: ', _PROFILE_CODE);
    ELSE
        SET _AUDIT_EVENT = 55;
        SET _AUDIT_MESSAGE = CONCAT('Perfil fue creado: ', _PROFILE_CODE);
    END IF;
    CALL SECURITYFX$AUDIT_PUT(
        _WSS_USER_CODE, _WSS_PROFILE_CODE, _WSS_STATION_CODE,
        _AUDIT_EVENT, _AUDIT_MESSAGE);
END$$
DELIMITER ;
