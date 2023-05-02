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

@chcp 1252 > nul
@setlocal

@rem Copiar "C:\Java\wildfly-27.0.1.Final\docs\contrib\scripts\service"
@rem al directorio "C:\Java\wildfly-27.0.1.Final\bin\service"

@set JAVA_HOME=C:\Java\jdk17.0.5

C:\Java\wildfly-27.0.1.Final\bin\service\service.bat install ^
/controller localhost:9990 /jbossuser "admin" /jbosspass "adminadmin" ^
/name wildfly_27.0.0 /display "WildFly 27.0.1" /desc "WildFly 27.0.1"

@endlocal
@pause
