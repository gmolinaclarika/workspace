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

@rem -b=0.0.0.0 => WildFly escucha por todas las interfaces
@rem -bmanagement=0.0.0.0 => consola WildFly en todas las interfaces
@rem -Djboss.socket.binding.port-offset=100 cambia todos los puertos WildFly

@set JAVA_HOME=C:\Java\jdk17.0.5

C:\Java\wildfly-27.0.1.Final\bin\standalone.bat -b=0.0.0.0 -bmanagement=0.0.0.0

@endlocal
@pause
