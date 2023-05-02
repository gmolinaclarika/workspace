--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------

IF EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.SQL_EXCEPTION') AND type in (N'U'))
    DROP TABLE dbo.SQL_EXCEPTION
GO

--------------------------------------------------------------------------------
-- SQL_EXCEPTION ---------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE dbo.SQL_EXCEPTION
(
    ID              BIGINT          IDENTITY(1,1)       NOT NULL,
    METHOD_NAME     NVARCHAR(200)   DEFAULT ''          NOT NULL,
    DATE_TIME       DATETIME        DEFAULT GETDATE()   NOT NULL,
    SQL_STATE       NCHAR(5)        DEFAULT '00000'     NOT NULL,
    ERROR_CODE      INTEGER         DEFAULT 0           NOT NULL,
    MESSAGE         NVARCHAR(500)   DEFAULT ''          NOT NULL,
    CONSTRAINT SQL_EXCEPTION_PK PRIMARY KEY NONCLUSTERED (ID),
    CONSTRAINT SQL_EXCEPTION_IX UNIQUE CLUSTERED (METHOD_NAME,ID)
)
GO

--------------------------------------------------------------------------------
