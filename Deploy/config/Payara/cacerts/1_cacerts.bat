@rem ---------------------------------------------------------------------------
@rem Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
@rem
@rem All  rights to this product are owned by OBCOM INGENIERIA S.A. and may only
@rem be used under the terms of its associated license  document.  You  may  NOT
@rem copy,  modify, sublicense, or distribute this source file or portions of it
@rem unless previously authorized in writing by OBCOM  INGENIERIA  S.A.  In  any
@rem event, this notice and the above copyright must always be included verbatim
@rem with this file.
@rem ---------------------------------------------------------------------------

@rem ---------------------------------------------------------------------------
@rem Remove certificate from cacerts.jks
"C:\Java\jdk1.8.0_311\bin\keytool.exe" -v -delete ^
-keystore cacerts.jks -storepass changeit -alias "cert_46_cybertrust_global_root46"
@if %errorlevel% neq 0 goto errors

@rem ---------------------------------------------------------------------------
@rem List the contents of cacerts.jks -> cacerts.jks.txt
"C:\Java\jdk1.8.0_311\bin\keytool.exe" -v -list ^
-keystore cacerts.jks -storepass changeit > cacerts.jks.txt
@if %errorlevel% neq 0 goto errors

:errors
@pause
