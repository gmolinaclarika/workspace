DROP PROCEDURE IF EXISTS SECURITYFX$DOMAINS_GET;

DELIMITER $$
CREATE PROCEDURE SECURITYFX$DOMAINS_GET (
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
    IN  _DOMAIN_NAME        VARCHAR(100),
    IN  _DOMAINS_MAX        INTEGER
)
BEGIN
    -- #ResultSet DOMAIN DOMAINS
    --    #Column NAME      VARCHAR
    --    #Column FUNCTION  VARCHAR
    --    #Column LOCATION  VARCHAR
    -- #EndResultSet
    SELECT
           RTRIM(V_FAM_FAMILIA)         AS NAME,
           RTRIM(V_FAM_NOMBRE_USUARIO)  AS 'FUNCTION',
           RTRIM(V_FAM_UBICACION)       AS LOCATION
    FROM  EcuACCFAM
    WHERE V_FAM_FAMILIA LIKE CONCAT(_DOMAIN_NAME, '%')
    ORDER BY V_FAM_FAMILIA ASC
    LIMIT _DOMAINS_MAX;
END$$
DELIMITER ;
