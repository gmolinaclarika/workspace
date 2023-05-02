--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------

DROP TABLE SQL_EXCEPTION CASCADE CONSTRAINTS;
DROP SEQUENCE SQL_EXCEPTION_SEQ;

--------------------------------------------------------------------------------
-- SQL_EXCEPTION ---------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE SQL_EXCEPTION
(
    ID              DECIMAL(19)     DEFAULT 0               NOT NULL,
    METHOD_NAME     NVARCHAR2(200)  DEFAULT ' '             NOT NULL,
    DATE_TIME       TIMESTAMP(3)    DEFAULT SYSTIMESTAMP    NOT NULL,
    SQL_STATE       NCHAR(5)        DEFAULT '00000'         NOT NULL,
    ERROR_CODE      INTEGER         DEFAULT 0               NOT NULL,
    MESSAGE         NVARCHAR2(500)  DEFAULT ' '             NOT NULL,
    CONSTRAINT SQL_EXCEPTION_PK PRIMARY KEY (ID)
);

CREATE SEQUENCE SQL_EXCEPTION_SEQ
    START WITH 1 INCREMENT BY 1
    MINVALUE 1 NOCYCLE NOCACHE;

--------------------------------------------------------------------------------

COMMIT;
QUIT;
