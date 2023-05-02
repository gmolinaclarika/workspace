CREATE OR REPLACE PROCEDURE IMSERVER$USERS_GET
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
    -------------------------------------.
    USERS_MAX$              IN  INTEGER,
    USERS$                  OUT SYS_REFCURSOR
)
AS
BEGIN
    -- #ResultSet USER USERS
    --    #Column CODE          NVARCHAR
    --    #Column GIVEN_NAMES   NVARCHAR
    --    #Column FATHER_NAME   NVARCHAR
    --    #Column MOTHER_NAME   NVARCHAR
    --    #Column ADDRESS       NVARCHAR
    --    #Column COMMUNE       NVARCHAR
    --    #Column CITY          NVARCHAR
    --    #Column COUNTRY       NVARCHAR
    --    #Column POSITION      NVARCHAR
    --    #Column PHONE1        NVARCHAR
    --    #Column FAX           NVARCHAR
    --    #Column EMAIL         NVARCHAR
    --    #Column DOMAIN        NVARCHAR
    -- #EndResultSet
    OPEN USERS$ FOR
        SELECT * FROM (
            SELECT TRIM(USU_CODIGO)     AS CODE,
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
            ORDER BY USU_CODIGO)
        WHERE ROWNUM <= USERS_MAX$;
END IMSERVER$USERS_GET;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
