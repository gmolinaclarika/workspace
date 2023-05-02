CREATE OR REPLACE PROCEDURE SECURITYFX$DOMAINS_GET
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
    DOMAIN_NAME$            IN  NVARCHAR2,
    DOMAINS_MAX$            IN  INTEGER,
    DOMAINS$                OUT SYS_REFCURSOR
)
AS
BEGIN
    -- #ResultSet DOMAIN DOMAINS
    --    #Column NAME      NVARCHAR
    --    #Column FUNCTION  NVARCHAR
    --    #Column LOCATION  NVARCHAR
    -- #EndResultSet
    OPEN DOMAINS$ FOR
        SELECT * FROM (
            SELECT RTRIM(V_FAM_FAMILIA)         AS NAME,
                   RTRIM(V_FAM_NOMBRE_USUARIO)  AS FUNCTION,
                   RTRIM(V_FAM_UBICACION)       AS LOCATION
            FROM  EcuACCFAM
            WHERE V_FAM_FAMILIA LIKE UPPER(DOMAIN_NAME$) || '%'
            ORDER BY V_FAM_FAMILIA ASC)
        WHERE ROWNUM <= DOMAINS_MAX$;
END SECURITYFX$DOMAINS_GET;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
