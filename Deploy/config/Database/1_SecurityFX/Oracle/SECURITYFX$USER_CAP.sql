CREATE OR REPLACE PROCEDURE SECURITYFX$USER_CAP
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
    USER_CODE$              IN  NVARCHAR2,
    CAPACITY_CODE$          IN  NVARCHAR2,
    CAPACITY_VALUE$         IN  NVARCHAR2,
    CAPACITY_STATE$         IN  NVARCHAR2
)
AS
BEGIN
    -- Add, modify or remove the user capacity
    IF (CAPACITY_STATE$ = 'A') THEN
        INSERT INTO EcuACCC2U (CODIGO_ADI, CAP_CODIGO, CAP_VALOR)
        VALUES (USER_CODE$, CAPACITY_CODE$, CAPACITY_VALUE$);
    ELSIF (CAPACITY_STATE$ = 'M') THEN
        UPDATE EcuACCC2U
        SET    CAP_VALOR = CAPACITY_VALUE$
        WHERE  CODIGO_ADI = USER_CODE$
        AND    CAP_CODIGO = CAPACITY_CODE$;
    ELSIF (CAPACITY_STATE$ = 'R') THEN
        DELETE FROM EcuACCC2U
        WHERE  CODIGO_ADI = USER_CODE$
        AND    CAP_CODIGO = CAPACITY_CODE$;
    ELSE
        RAISE_APPLICATION_ERROR(-20001, 'Capacidad en estado inválido: ' || CAPACITY_STATE$);
    END IF;
END SECURITYFX$USER_CAP;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
