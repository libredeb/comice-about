#!/usr/bin/env python3

import os
import subprocess

hicolor = os.path.join(os.environ['MESON_INSTALL_PREFIX'], 'share', 'icons', 'hicolor')
user_home = os.environ['HOME']

if not os.environ.get('DESTDIR'):
    print('Getting data about RAM Memory...')
    subprocess.call(['/bin/bash', '-c', "sudo dmidecode --type 17 | cut -f2 -d $'\t' | grep -e Size: -e Type: -e '^Speed:' > " + user_home + "/.comicemem"])
    print('Updating icon cache...')
    subprocess.call(['gtk-update-icon-cache', '-q', '-t' ,'-f', hicolor])
