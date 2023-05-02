CREATE OR REPLACE PROCEDURE STORE_SQL_EXCEPTION
--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------
-- CREATE TABLE SQL_EXCEPTION
-- (
--     ID              DECIMAL(19)     DEFAULT 0             NOT NULL,
--     METHOD_NAME     NVARCHAR2(200)  DEFAULT ' '           NOT NULL,
--     DATE_TIME       TIMESTAMP(3)    DEFAULT SYSTIMESTAMP  NOT NULL,
--     SQL_STATE       NCHAR(5)        DEFAULT '00000'       NOT NULL,
--     ERROR_CODE      INTEGER         DEFAULT 0             NOT NULL,
--     MESSAGE         NVARCHAR2(500)  DEFAULT ' '           NOT NULL,
--     CONSTRAINT SQL_EXCEPTION_PK PRIMARY KEY (ID)
-- );
--
-- CREATE SEQUENCE SQL_EXCEPTION_SEQ
--     START WITH 1 INCREMENT BY 1
--     MINVALUE 1 NOCYCLE NOCACHE;
--------------------------------------------------------------------------------
-- https://en.wikipedia.org/wiki/SQLSTATE
-- https://docs.oracle.com/cd/E15817_01/appdev.111/b31228/appd.htm
--------------------------------------------------------------------------------
(
    METHOD_NAME$    IN  NVARCHAR2,      -- Method that threw SQLException
    SQL_STATE$      IN  NCHAR,          -- SQLException SQL State
    ERROR_CODE$     IN  INTEGER,        -- SQLException Error Code
    MESSAGE$        IN  NVARCHAR2       -- SQLException Message
)
AS
BEGIN
    INSERT INTO SQL_EXCEPTION (
        ID,
        METHOD_NAME,
        SQL_STATE,
        ERROR_CODE,
        MESSAGE
    ) VALUES (
        SQL_EXCEPTION_SEQ.NEXTVAL,
        METHOD_NAME$,
        SQL_STATE$,
        ERROR_CODE$,
        MESSAGE$
    );
END STORE_SQL_EXCEPTION;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
