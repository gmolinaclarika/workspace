IF OBJECT_ID(N'dbo.SECURITYFX$AUDIT_PUT', N'P') IS NOT NULL 
    DROP PROCEDURE dbo.SECURITYFX$AUDIT_PUT
GO

CREATE PROCEDURE dbo.SECURITYFX$AUDIT_PUT
--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------
    @USER_CODE          NVARCHAR(100),
    @PROFILE_CODE       INTEGER,
    @STATION_CODE       NVARCHAR(100),
    @EVENT_CODE         INTEGER,
    @MESSAGE            NVARCHAR(100)
AS
BEGIN
    INSERT INTO dbo.EcuACCLOG (
         V_ECULOG_HORA
        ,V_ECULOG_CODIGO_ADI
        ,V_ECULOG_CODIGO_ECU
        ,V_ECULOG_TERMINAL
        ,V_ECULOG_CODIGO_MSG
        ,V_ECULOG_MENSAJE
    ) VALUES (
         REPLACE(CONVERT(VARCHAR, GETDATE(), 121), ' ', ':') + '000'
        ,ISNULL(@USER_CODE, '?')
        ,ISNULL(@PROFILE_CODE, 9999999)
        ,ISNULL(@STATION_CODE, '?')
        ,ISNULL(@EVENT_CODE, 9999)
        ,ISNULL(@MESSAGE, '?')
    );
END
GO
