CREATE OR REPLACE PROCEDURE SECURITYFX$CAPACITIES_GET
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
    CAPACITIES_MAX$         IN  INTEGER,
    CAPACITIES$             OUT SYS_REFCURSOR
)
AS
BEGIN
    -- #ResultSet CAPACITY CAPACITIES
    --    #Column CODE  NVARCHAR
    --    #Column NAME  NVARCHAR
    --    #Column TYPE  INTEGER
    -- #EndResultSet
    OPEN CAPACITIES$ FOR
        SELECT * FROM (
            SELECT RTRIM(CAP_CODIGO)    AS CODE,
                   RTRIM(CAP_NOMBRE)    AS NAME,
                   CAP_TIPO             AS TYPE
            FROM  EcuACCCAP
            ORDER BY CAP_CODIGO)
        WHERE ROWNUM <= CAPACITIES_MAX$;
END SECURITYFX$CAPACITIES_GET;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
