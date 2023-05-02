IF OBJECT_ID(N'dbo.DESKTOPFX$PLUGIN_XML', N'P') IS NOT NULL 
    DROP PROCEDURE dbo.DESKTOPFX$PLUGIN_XML
GO

CREATE PROCEDURE dbo.DESKTOPFX$PLUGIN_XML
--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------
    @PLUGIN_PREFIX      NVARCHAR(200)
AS
BEGIN
    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON;

    -- #ResultSet PLUGIN PLUGINS
    --   #Column  NAME  NVARCHAR
    --   #Column  XML   NVARCHAR
    -- #EndResultSet
    IF (LEN(@PLUGIN_PREFIX) = 0) BEGIN
        SELECT NAME AS NAME,
               XML  AS XML
        FROM  dbo.DESKTOPFX_PLUGIN 
        WHERE ENABLED = 1
        ORDER BY NAME;
    END
    ELSE BEGIN
        SELECT NAME AS NAME,
               XML  AS XML
        FROM  dbo.DESKTOPFX_PLUGIN 
        WHERE NAME LIKE @PLUGIN_PREFIX + '%'
          AND ENABLED = 1
        ORDER BY NAME;
    END;
END;
GO
