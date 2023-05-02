CREATE OR REPLACE PROCEDURE SECURITYFX$PROFILE_PWD
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
    PROFILE_CODE$           IN INTEGER,
    PROFILE_WORD$           IN DECIMAL
)
AS
BEGIN
    -- Update the password of the profile
    UPDATE EcuACCPER
    SET    V_ACC_OTRAS_PASSW_006 = V_ACC_OTRAS_PASSW_005,
           V_ACC_OTRAS_PASSW_005 = V_ACC_OTRAS_PASSW_004,
           V_ACC_OTRAS_PASSW_004 = V_ACC_OTRAS_PASSW_003,
           V_ACC_OTRAS_PASSW_003 = V_ACC_OTRAS_PASSW_002,
           V_ACC_OTRAS_PASSW_002 = V_ACC_OTRAS_PASSW_001,
           V_ACC_OTRAS_PASSW_001 = V_ACC_PASSWORD,
           V_ACC_PASSWORD        = PROFILE_WORD$
    WHERE  V_ACC_CODE_NUM = PROFILE_CODE$;
    IF (SQL%ROWCOUNT = 0) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Perfil no está definido: ' || PROFILE_CODE$);
    END IF;
END SECURITYFX$PROFILE_PWD;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
