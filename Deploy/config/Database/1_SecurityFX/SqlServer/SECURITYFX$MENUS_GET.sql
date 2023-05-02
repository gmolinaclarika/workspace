IF OBJECT_ID(N'dbo.SECURITYFX$MENUS_GET', N'P') IS NOT NULL
    DROP PROCEDURE dbo.SECURITYFX$MENUS_GET
GO

CREATE PROCEDURE dbo.SECURITYFX$MENUS_GET
--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------
    @WSS_USER_CODE      NVARCHAR(100),
    @WSS_PROFILE_CODE   INTEGER,
    @WSS_STATION_CODE   NVARCHAR(100),
    ----------------------------------
    @MENU_NAME          NVARCHAR(200),
    @MENUS_MAX          INTEGER
AS
BEGIN
    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON;

    -- #ResultSet MENU MENUS
    --    #Column MENU_ID    BIGINT
    --    #Column MENU_NAME  NVARCHAR
    --    #Column REF_COUNT  INTEGER
    -- #EndResultSet
    SELECT TOP(@MENUS_MAX)
           MENU_ID   = ID,
           MENU_NAME = NAME,
           REF_COUNT = (SELECT COUNT(*)
                        FROM  dbo.EcuACCPER
                        WHERE RTRIM(V_ACC_PROG_INI) = NAME)
    FROM   dbo.DESKTOPFX_OBJECT
    WHERE  LOGIN_ID = 0 AND TYPE = 4
    AND    NAME LIKE @MENU_NAME + '%'
    ORDER BY NAME ASC;
END
GO
