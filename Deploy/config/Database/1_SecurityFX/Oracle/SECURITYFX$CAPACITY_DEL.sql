CREATE OR REPLACE PROCEDURE SECURITYFX$CAPACITY_DEL
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
    CAPACITY_CODE$          IN  NVARCHAR2
)
AS
    CAP_CODIGO$     EcuACCCAP.CAP_CODIGO%TYPE;
    COUNT$          INTEGER;
BEGIN
    -- Normalize specified capacity name
    CAP_CODIGO$ := UPPER(RTRIM(CAPACITY_CODE$));

    -- Check the capacity is not assigned to a user
    SELECT COUNT(*) INTO COUNT$ FROM EcuACCC2U WHERE CAP_CODIGO = CAP_CODIGO$ AND ROWNUM = 1;
    IF (COUNT$ > 0) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Capacidad ' || CAP_CODIGO$ || ' está asignada a uno o más usuarios');
    END IF;

    -- Check the capacity is not assigned to a profile
    SELECT COUNT(*) INTO COUNT$ FROM EcuACCC2P WHERE CAP_CODIGO = CAP_CODIGO$ AND ROWNUM = 1;
    IF (COUNT$ > 0) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Capacidad ' || CAP_CODIGO$ || ' está asignada a uno o más perfiles');
    END IF;

    -- Delete the properties of specified capacity
    DELETE FROM EcuACCCAP
    WHERE  CAP_CODIGO = CAP_CODIGO$;

    -- Generate an audit record
    SECURITYFX$AUDIT_PUT(
        WSS_USER_CODE$, WSS_PROFILE_CODE$, WSS_STATION_CODE$,
        12, 'Capacidad fue eliminada: ' || CAP_CODIGO$);
END SECURITYFX$CAPACITY_DEL;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
