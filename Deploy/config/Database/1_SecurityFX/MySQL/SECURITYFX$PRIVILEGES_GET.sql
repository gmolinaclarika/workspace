DROP PROCEDURE IF EXISTS SECURITYFX$PRIVILEGES_GET;

DELIMITER $$
CREATE PROCEDURE SECURITYFX$PRIVILEGES_GET (
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
    IN  _PRIVILEGES_MAX     INTEGER
)
BEGIN
    -- #ResultSet PRIVILEGE PRIVILEGES
    --    #Column TYPE      VARCHAR
    --    #Column INDEX     INTEGER
    --    #Column LABEL     VARCHAR
    --    #Column CNAME     VARCHAR
    --    #Column SNAME     VARCHAR
    -- #EndResultSet
    SELECT
           RTRIM(V_PRV_TIPO)        AS TYPE,
           V_PRV_NUMERO             AS 'INDEX',
           RTRIM(V_PRV_NOMBRE)      AS LABEL,
           RTRIM(V_PRV_CONST)       AS CNAME,
           RTRIM(V_PRV_SYSLOG)      AS SNAME
    FROM  EcuACCPRV
    ORDER BY V_PRV_TIPO, V_PRV_NUMERO ASC
    LIMIT _PRIVILEGES_MAX;
END$$
DELIMITER ;
