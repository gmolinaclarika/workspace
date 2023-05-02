DROP PROCEDURE IF EXISTS IMSERVER$USERS_GET;

DELIMITER $$
CREATE PROCEDURE IMSERVER$USERS_GET (
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
    IN  _USERS_MAX          INTEGER
)
BEGIN
    -- #ResultSet USER USERS
    --    #Column USER_CODE     VARCHAR
    --    #Column GIVEN_NAMES   VARCHAR
    --    #Column FATHER_NAME   VARCHAR
    --    #Column MOTHER_NAME   VARCHAR
    --    #Column ADDRESS       VARCHAR
    --    #Column COMMUNE       VARCHAR
    --    #Column CITY          VARCHAR
    --    #Column COUNTRY       VARCHAR
    --    #Column POSITION      VARCHAR
    --    #Column PHONE1        VARCHAR
    --    #Column FAX           VARCHAR
    --    #Column EMAIL         VARCHAR
    --    #Column DOMAIN        VARCHAR
    -- #EndResultSet
    SELECT
           TRIM(USU_CODIGO)     AS USER_CODE,
           TRIM(NOMBRES)        AS GIVEN_NAMES,
           TRIM(APELLIDO_PAT)   AS FATHER_NAME,
           TRIM(APELLIDO_MAT)   AS MOTHER_NAME,
           TRIM(DIRECCION)      AS ADDRESS,
           TRIM(COMUNA)         AS COMMUNE,
           TRIM(CIUDAD)         AS CITY,
           TRIM(PAIS)           AS COUNTRY,
           TRIM(CARGO)          AS POSITION,
           TRIM(FONO1)          AS PHONE1,
           TRIM(FAX)            AS FAX,
           TRIM(EMAIL)          AS EMAIL,
           TRIM(FAMILIA)        AS DOMAIN
    FROM   EcuACCUSU
    WHERE  USU_ESTADO = 'HA'
    AND    USUARIOIM  = 'S'
    ORDER BY USU_CODIGO
    LIMIT _USERS_MAX;
END$$
DELIMITER ;
