CREATE OR REPLACE PROCEDURE MCASTNEWS$ITEMS_GET
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
    VALID_FROM$             IN  TIMESTAMP,
    ITEMS_MAX$              IN  INTEGER,
    ITEMS$                  OUT SYS_REFCURSOR
)
AS
BEGIN
    -- #ResultSet ITEM ITEMS
    --    #Column ID                DECIMAL
    --    #Column VALID_FROM        DATETIME
    --    #Column MESSAGE           NVARCHAR
    --    #Column ATTACHMENT_TYPE   NVARCHAR
    -- #EndResultSet
    OPEN ITEMS$ FOR
        SELECT * FROM (
            SELECT ID               AS ID,
                   VALID_FROM       AS VALID_FROM,
                   MESSAGE          AS MESSAGE,
                   ATTACHMENT_TYPE  AS ATTACHMENT_TYPE
            FROM   DESKTOPFX_MULTICAST
            WHERE  (VALID_FROM$ <= VALID_FROM) AND (SYSDATE <= VALID_TO)
            AND    (USER_FILTER    IS NULL OR USER_FILTER    = WSS_USER_CODE$)
            AND    (PROFILE_FILTER IS NULL OR PROFILE_FILTER = WSS_PROFILE_CODE$)
            AND    (STATION_FILTER IS NULL OR STATION_FILTER = WSS_STATION_CODE$)
            AND    NAME = 'news'
            ORDER BY VALID_FROM DESC)
        WHERE ROWNUM <= ITEMS_MAX$;
END MCASTNEWS$ITEMS_GET;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
