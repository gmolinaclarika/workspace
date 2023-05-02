CREATE OR REPLACE PROCEDURE MCASTADMIN$MRESPONSE_DIR
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
    MULTICAST_ID$           IN  DECIMAL,
    MRESPONSES_MAX$         IN  INTEGER,
    MRESPONSES$             OUT SYS_REFCURSOR
)
AS
BEGIN
    -- #ResultSet ENTRY ENTRIES
    --    #Column ID                DECIMAL
    --    #Column MESSAGE           NVARCHAR
    --    #Column STATION_CODE      NVARCHAR
    --    #Column REQUEST_TIME      DATETIME
    --    #Column RESPONSE_TIME     DATETIME
    --    #Column ATTACHMENT_TYPE   NVARCHAR
    --    #Column ATTACHMENT_SIZE   INTEGER
    -- #EndResultSet
    OPEN MRESPONSES$ FOR
        SELECT * FROM (
            SELECT ID                               AS ID,
                   MESSAGE                          AS MESSAGE,
                   STATION_CODE                     AS STATION_CODE,
                   REQUEST_TIME                     AS REQUEST_TIME,
                   RESPONSE_TIME                    AS RESPONSE_TIME,
                   ATTACHMENT_TYPE                  AS ATTACHMENT_TYPE,
                   DBMS_LOB.GETLENGTH(ATTACHMENT)   AS ATTACHMENT_SIZE
            FROM  DESKTOPFX_MRESPONSE
            WHERE MULTICAST_ID = MULTICAST_ID$
            ORDER BY RESPONSE_TIME)
        WHERE ROWNUM <= MRESPONSES_MAX$;
END MCASTADMIN$MRESPONSE_DIR;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
