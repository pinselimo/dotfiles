#!/usr/bin/env fish
if test (cat /home/pinselimo/.config/libreoffice/4/user/registrymodifications.xcu | grep  RecoveryList | grep OriginalURL); exec libreoffice; end
