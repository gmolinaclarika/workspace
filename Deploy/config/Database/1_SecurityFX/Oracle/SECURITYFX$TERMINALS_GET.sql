CREATE OR REPLACE PROCEDURE SECURITYFX$TERMINALS_GET
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
    TERMINAL_NAME$          IN  NVARCHAR2,
    TERMINALS_MAX$          IN  INTEGER,
    TERMINALS$              OUT SYS_REFCURSOR
)
AS
BEGIN
    -- #ResultSet TERMINAL TERMINALS
    --    #Column NAME      NVARCHAR
    --    #Column DOMAIN    NVARCHAR
    --    #Column TYPE      NVARCHAR
    --    #Column FUNCTION  NVARCHAR
    --    #Column LOCATION  NVARCHAR
    --    #Column STATE     NVARCHAR
    -- #EndResultSet
    OPEN TERMINALS$ FOR
        SELECT * FROM (
            SELECT RTRIM(V_NET_NOMBRE)          AS NAME,
                   RTRIM(V_NET_FAMILIA)         AS DOMAIN,
                   RTRIM(V_NET_TIPO)            AS TYPE,
                   RTRIM(V_NET_NOMBRE_USUARIO)  AS FUNCTION,
                   RTRIM(V_NET_UBICACION)       AS LOCATION,
                   RTRIM(V_NET_HABILITADO)      AS STATE
            FROM  EcuACCNET
            WHERE V_NET_NOMBRE LIKE UPPER(TERMINAL_NAME$) || '%'
            ORDER BY V_NET_NOMBRE ASC)
        WHERE ROWNUM <= TERMINALS_MAX$;
END SECURITYFX$TERMINALS_GET;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
