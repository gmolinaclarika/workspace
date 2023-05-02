CREATE OR REPLACE PROCEDURE SECURITYFX$CAPACITY_PUT
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
    NAME$                   OUT NVARCHAR2,
    TYPE$                   OUT INTEGER,
    CREATED$                OUT INTEGER
)
AS
    CAP_CODIGO$     EcuACCCAP.CAP_CODIGO%TYPE;
BEGIN
    -- Asume the capacity exists
    CREATED$ := 0;

    -- Normalize specified capacity name
    CAP_CODIGO$ := UPPER(RTRIM(CAPACITY_CODE$));

    -- Update the properties of specified capacity
    UPDATE EcuACCCAP
    SET    CAP_NOMBRE = NAME$,
           CAP_TIPO   = TYPE$
    WHERE  CAP_CODIGO = CAP_CODIGO$;

    -- Create capacity if it didn't exist
    IF (SQL%ROWCOUNT = 0) THEN
        INSERT INTO EcuACCCAP (
             CAP_CODIGO
            ,CAP_NOMBRE
            ,CAP_TIPO
        ) VALUES (
             CAP_CODIGO$
            ,NAME$
            ,TYPE$
        );
        CREATED$ := 1;
    END IF;

    -- Generate an audit record
    IF (CREATED$ = 0) THEN
        SECURITYFX$AUDIT_PUT(
            WSS_USER_CODE$, WSS_PROFILE_CODE$, WSS_STATION_CODE$,
            15, 'Capacidad fue modificada: ' || CAP_CODIGO$);
    ELSE
        SECURITYFX$AUDIT_PUT(
            WSS_USER_CODE$, WSS_PROFILE_CODE$, WSS_STATION_CODE$,
            16, 'Capacidad fue creada: ' || CAP_CODIGO$);
    END IF;
END SECURITYFX$CAPACITY_PUT;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
