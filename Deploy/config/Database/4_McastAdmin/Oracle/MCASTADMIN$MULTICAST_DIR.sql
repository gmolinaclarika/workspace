CREATE OR REPLACE PROCEDURE MCASTADMIN$MULTICAST_DIR
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
    WSS_USER_CODE$          IN  VARCHAR2,
    WSS_PROFILE_CODE$       IN  INTEGER,
    WSS_STATION_CODE$       IN  VARCHAR2,
    -------------------------------------
    MULTICASTS_MAX$         IN  INTEGER,
    MULTICASTS$             OUT SYS_REFCURSOR
)
AS
BEGIN
    -- #ResultSet ENTRY ENTRIES
    --    #Column ID                DECIMAL
    --    #Column NAME              NVARCHAR
    --    #Column MESSAGE           NVARCHAR
    --    #Column VALID_FROM        DATETIME
    --    #Column VALID_TO          DATETIME
    --    #Column ATTACHMENT_TYPE   NVARCHAR
    --    #Column ATTACHMENT_SIZE   INTEGER
    --    #Column USER_FILTER       NVARCHAR
    --    #Column PROFILE_FILTER    INTEGER
    --    #Column STATION_FILTER    NVARCHAR
    -- #EndResultSet
    OPEN MULTICASTS$ FOR
        SELECT * FROM (
            SELECT ID                               AS ID,
                   NAME                             AS NAME,
                   MESSAGE                          AS MESSAGE,
                   VALID_FROM                       AS VALID_FROM,
                   VALID_TO                         AS VALID_TO,
                   ATTACHMENT_TYPE                  AS ATTACHMENT_TYPE,
                   DBMS_LOB.GETLENGTH(ATTACHMENT)   AS ATTACHMENT_SIZE,
                   USER_FILTER                      AS USER_FILTER,
                   PROFILE_FILTER                   AS PROFILE_FILTER,
                   STATION_FILTER                   AS STATION_FILTER
            FROM  DESKTOPFX_MULTICAST
            ORDER BY VALID_FROM)
        WHERE ROWNUM <= MULTICASTS_MAX$;
END MCASTADMIN$MULTICAST_DIR;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
