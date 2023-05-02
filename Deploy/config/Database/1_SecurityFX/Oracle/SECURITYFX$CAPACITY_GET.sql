CREATE OR REPLACE PROCEDURE SECURITYFX$CAPACITY_GET
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
    CAPACITY_CODE$          IN  NVARCHAR2,
    -- General Properties
    CODE$                   OUT NVARCHAR2,
    NAME$                   OUT NVARCHAR2,
    TYPE$                   OUT INTEGER
)
AS
    CAP_CODIGO$     EcuACCCAP.CAP_CODIGO%TYPE;
BEGIN
    -- Normalize specified capacity name
    CAP_CODIGO$ := UPPER(RTRIM(CAPACITY_CODE$));

    -- Return the properties of specified capacity
    BEGIN
        SELECT
            -- General Properties
            RTRIM(CAP_CODIGO),
            RTRIM(CAP_NOMBRE),
            CAP_TIPO
        INTO
            -- General Properties
            CODE$,
            NAME$,
            TYPE$
        FROM   EcuACCCAP
        WHERE  CAP_CODIGO = CAP_CODIGO$;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'Capacidad no está definida: ' || CAP_CODIGO$);
    END;
END SECURITYFX$CAPACITY_GET;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
