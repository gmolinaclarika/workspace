IF OBJECT_ID(N'dbo.STORE_SQL_EXCEPTION', N'P') IS NOT NULL
    DROP PROCEDURE dbo.STORE_SQL_EXCEPTION
GO

CREATE PROCEDURE dbo.STORE_SQL_EXCEPTION
--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------
-- CREATE TABLE dbo.SQL_EXCEPTION
-- (
--     ID              BIGINT          IDENTITY(1,1)       NOT NULL,
--     METHOD_NAME     NVARCHAR(200)   DEFAULT ''          NOT NULL,
--     DATE_TIME       DATETIME        DEFAULT GETDATE()   NOT NULL,
--     SQL_STATE       NCHAR(5)        DEFAULT '00000'     NOT NULL,
--     ERROR_CODE      INTEGER         DEFAULT 0           NOT NULL,
--     MESSAGE         NVARCHAR(500)   DEFAULT ''          NOT NULL,
--     CONSTRAINT SQL_EXCEPTION_PK PRIMARY KEY NONCLUSTERED (ID),
--     CONSTRAINT SQL_EXCEPTION_IX UNIQUE CLUSTERED (METHOD_NAME,ID)
-- )
--------------------------------------------------------------------------------
-- https://en.wikipedia.org/wiki/SQLSTATE
-- https://docs.microsoft.com/en-us/sql/odbc/reference/appendixes/appendix-a-odbc-error-codes
--------------------------------------------------------------------------------
    @METHOD_NAME    NVARCHAR(200),      -- Method that threw SQLException
    @SQL_STATE      NCHAR(5),           -- SQLException SQL State
    @ERROR_CODE     INTEGER,            -- SQLException Error Code
    @MESSAGE        NVARCHAR(500)       -- SQLException Message
AS
BEGIN
    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON;

    -- Store specified SQLException
    INSERT INTO dbo.SQL_EXCEPTION (
        METHOD_NAME,
        SQL_STATE,
        ERROR_CODE,
        MESSAGE
    ) VALUES (
        @METHOD_NAME,
        @SQL_STATE,
        @ERROR_CODE,
        @MESSAGE
    );
END
GO
