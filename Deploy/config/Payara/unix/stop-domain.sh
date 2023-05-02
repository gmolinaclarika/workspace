#!/bin/sh
#-------------------------------------------------------------------------------
# Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
#
# All  rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
# used under the terms of its associated license document.  You  may  NOT  copy,
# modify,  sublicense,  or  distribute this source file or portions of it unless
# previously authorized in writing by OBCOM INGENIERIA S.A. In any  event,  this
# notice and above copyright must always be included verbatim with this file.
#-------------------------------------------------------------------------------

if [ $EUID -eq 0 ]; then
  NADMIN="/opt/payara-5.2022.5/glassfish/lib/nadmin"
  su -l payara -c "$NADMIN stop-domain domain1 &"
else
  ASADMIN="/opt/payara-5.2022.5/bin/asadmin"
  $ASADMIN stop-domain domain1
fi

#-------------------------------------------------------------------------------
