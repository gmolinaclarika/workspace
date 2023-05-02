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
  echo "You cannot be root to backup a Payara domain"
  exit 1
fi

BACKUPDIR="/opt/payara-5.2022.5/backups"
ASADMIN="/opt/payara-5.2022.5/bin/asadmin"
$ASADMIN backup-domain --backupdir $BACKUPDIR domain1

#-------------------------------------------------------------------------------
