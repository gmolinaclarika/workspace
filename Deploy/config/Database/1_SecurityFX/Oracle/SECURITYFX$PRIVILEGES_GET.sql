CREATE OR REPLACE PROCEDURE SECURITYFX$PRIVILEGES_GET
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
    PRIVILEGES_MAX$         IN  INTEGER,
    PRIVILEGES$             OUT SYS_REFCURSOR
)
AS
BEGIN
    -- #ResultSet PRIVILEGE PRIVILEGES
    --    #Column TYPE      NVARCHAR
    --    #Column INDEX     INTEGER
    --    #Column LABEL     NVARCHAR
    --    #Column CNAME     NVARCHAR
    --    #Column SNAME     NVARCHAR
    -- #EndResultSet
    OPEN PRIVILEGES$ FOR
        SELECT * FROM (
            SELECT RTRIM(V_PRV_TIPO)        AS TYPE,
                   V_PRV_NUMERO             AS "INDEX",
                   RTRIM(V_PRV_NOMBRE)      AS LABEL,
                   RTRIM(V_PRV_CONST)       AS CNAME,
                   RTRIM(V_PRV_SYSLOG)      AS SNAME
            FROM  EcuACCPRV
            ORDER BY V_PRV_TIPO, V_PRV_NUMERO ASC)
        WHERE ROWNUM <= PRIVILEGES_MAX$;
END SECURITYFX$PRIVILEGES_GET;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
