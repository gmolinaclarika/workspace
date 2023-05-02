DROP PROCEDURE IF EXISTS SECURITYFX$USERS_GET;

DELIMITER $$
CREATE PROCEDURE SECURITYFX$USERS_GET (
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
    IN  _USERS_MAX          INTEGER
)
BEGIN
    -- #ResultSet USER USERS
    --    #Column CODE          NVARCHAR
    --    #Column GIVEN_NAMES   NVARCHAR
    --    #Column FATHER_NAME   NVARCHAR
    --    #Column MOTHER_NAME   NVARCHAR
    --    #Column DOMAIN        NVARCHAR
    --    #Column STATE         NVARCHAR
    -- #EndResultSet
    SELECT
           RTRIM(USU_CODIGO)    AS CODE,
           RTRIM(NOMBRES)       AS GIVEN_NAMES,
           RTRIM(APELLIDO_PAT)  AS FATHER_NAME,
           RTRIM(APELLIDO_MAT)  AS MOTHER_NAME,
           RTRIM(FAMILIA)       AS DOMAIN,
           RTRIM(USU_ESTADO)    AS STATE
    FROM  EcuACCUSU
    WHERE USU_CODIGO LIKE CONCAT(_USER_CODE, '%')
    ORDER BY USU_CODIGO ASC
    LIMIT _USERS_MAX;
END$$
DELIMITER ;
