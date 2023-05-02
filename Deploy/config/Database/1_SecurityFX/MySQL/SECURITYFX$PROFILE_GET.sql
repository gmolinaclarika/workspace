DROP PROCEDURE IF EXISTS SECURITYFX$PROFILE_GET;

DELIMITER $$
CREATE PROCEDURE SECURITYFX$PROFILE_GET (
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
    -- General Properties ---------------
    OUT _CODE               INTEGER,
    OUT _NAME               VARCHAR(100),
    OUT _FLAGS              VARCHAR(100),
    OUT _MENU               VARCHAR(100),
    OUT _DOMAIN             VARCHAR(100),
    -- Privilege Properties -------------
    OUT _PRIV_MENU          VARCHAR(100),
    OUT _PRIV_VARL          VARCHAR(100),
    OUT _PRIV_VARM          VARCHAR(100),
    OUT _PRIV_REGL          VARCHAR(100),
    OUT _PRIV_REGM          VARCHAR(100),
    -- Restriction Properties -----------
    OUT _EXPIRES            INTEGER,
    OUT _HOUR_FROM          DECIMAL(4,2),
    OUT _HOUR_TO            DECIMAL(4,2),
    OUT _PWD_DAYS           INTEGER,
    -- Terminal Properties --------------
    OUT _TERMINAL01         VARCHAR(100),
    OUT _TERMINAL02         VARCHAR(100),
    OUT _TERMINAL03         VARCHAR(100),
    OUT _TERMINAL04         VARCHAR(100),
    OUT _TERMINAL05         VARCHAR(100),
    OUT _TERMINAL06         VARCHAR(100),
    OUT _TERMINAL07         VARCHAR(100),
    OUT _TERMINAL08         VARCHAR(100),
    OUT _TERMINAL09         VARCHAR(100),
    OUT _TERMINAL10         VARCHAR(100),
    OUT _TERMINAL11         VARCHAR(100),
    OUT _TERMINAL12         VARCHAR(100),
    OUT _TERMINAL13         VARCHAR(100),
    OUT _TERMINAL14         VARCHAR(100),
    OUT _TERMINAL15         VARCHAR(100),
    OUT _TERMINAL16         VARCHAR(100)
)
BEGIN
    DECLARE _MESSAGE_TEXT VARCHAR(200);

    -- Return the properties of specified profile
    SELECT
        -- General Properties
        V_ACC_CODE_NUM,
        RTRIM(V_ACC_NAME),
        RTRIM(V_ACC_INDICADORES),
        RTRIM(V_ACC_PROG_INI),
        RTRIM(V_ACC_FAMILIA),
        -- Privilege Properties
        RTRIM(V_ACC_PRIV_MEN),
        RTRIM(V_ACC_PRIV_VARL),
        RTRIM(V_ACC_PRIV_VARM),
        RTRIM(V_ACC_PRIV_REGL),
        RTRIM(V_ACC_PRIV_REGM),
        -- Restriction Properties
        V_ACC_EXP,
        V_ACC_HORA_INIC,
        V_ACC_HORA_FIN,
        V_ACC_DIAS_VIG_PASSW,
        -- Terminal Properties
        RTRIM(V_ACC_TERM_001),
        RTRIM(V_ACC_TERM_002),
        RTRIM(V_ACC_TERM_003),
        RTRIM(V_ACC_TERM_004),
        RTRIM(V_ACC_TERM_005),
        RTRIM(V_ACC_TERM_006),
        RTRIM(V_ACC_TERM_007),
        RTRIM(V_ACC_TERM_008),
        RTRIM(V_ACC_TERM_009),
        RTRIM(V_ACC_TERM_010),
        RTRIM(V_ACC_TERM_011),
        RTRIM(V_ACC_TERM_012),
        RTRIM(V_ACC_TERM_013),
        RTRIM(V_ACC_TERM_014),
        RTRIM(V_ACC_TERM_015),
        RTRIM(V_ACC_TERM_016)
    INTO
        -- General Properties
        _CODE,
        _NAME,
        _FLAGS,
        _MENU,
        _DOMAIN,
        -- Privilege Properties
        _PRIV_MENU,
        _PRIV_VARL,
        _PRIV_VARM,
        _PRIV_REGL,
        _PRIV_REGM,
        -- Restriction Properties
        _EXPIRES,
        _HOUR_FROM,
        _HOUR_TO,
        _PWD_DAYS,
        -- Terminal Properties
        _TERMINAL01,
        _TERMINAL02,
        _TERMINAL03,
        _TERMINAL04,
        _TERMINAL05,
        _TERMINAL06,
        _TERMINAL07,
        _TERMINAL08,
        _TERMINAL09,
        _TERMINAL10,
        _TERMINAL11,
        _TERMINAL12,
        _TERMINAL13,
        _TERMINAL14,
        _TERMINAL15,
        _TERMINAL16
    FROM   EcuACCPER
    WHERE  V_ACC_CODE_NUM = _PROFILE_CODE;
    IF (FOUND_ROWS() = 0) THEN
        SET _MESSAGE_TEXT = CONCAT('Perfil no está definido: ', _PROFILE_CODE);
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = _MESSAGE_TEXT;
    END IF;

    -- #ResultSet CAPACITY CAPACITIES
    --   #Column  CODE      VARCHAR
    --   #Column  VALUE     VARCHAR
    -- #EndResultSet
    SELECT CAP_CODIGO       AS CODE,
           CAP_VALOR        AS VALUE
    FROM  EcuACCC2P
    WHERE CODIGO_ECU = _PROFILE_CODE
    ORDER BY CAP_CODIGO;
END$$
DELIMITER ;
