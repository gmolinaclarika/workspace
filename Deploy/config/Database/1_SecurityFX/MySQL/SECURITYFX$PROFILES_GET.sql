DROP PROCEDURE IF EXISTS SECURITYFX$PROFILES_GET;

DELIMITER $$
CREATE PROCEDURE SECURITYFX$PROFILES_GET (
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
    IN  _PROFILES_MAX       INTEGER
)
BEGIN
    -- #ResultSet PROFILE PROFILES
    --    #Column CODE      INTEGER
    --    #Column NAME      VARCHAR
    --    #Column FLAGS     VARCHAR
    --    #Column MENU      VARCHAR
    --    #Column DOMAIN    VARCHAR
    -- #EndResultSet
    SELECT
           V_ACC_CODE_NUM               AS CODE,
           RTRIM(V_ACC_NAME)            AS NAME,
           RTRIM(V_ACC_INDICADORES)     AS FLAGS,
           RTRIM(V_ACC_PROG_INI)        AS MENU,
           RTRIM(V_ACC_FAMILIA)         AS DOMAIN
    FROM  EcuACCPER
    WHERE V_ACC_CODE_NUM >= _PROFILE_CODE
    ORDER BY V_ACC_CODE_NUM ASC
    LIMIT _PROFILES_MAX;
END$$
DELIMITER ;
