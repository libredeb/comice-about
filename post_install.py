#!/usr/bin/env python3

import os
import subprocess

hicolor = os.path.join(os.environ['MESON_INSTALL_PREFIX'], 'share', 'icons', 'hicolor')
user_home = os.environ['USER']

if not os.environ.get('DESTDIR'):
    print('Getting data about RAM Memory...')
    result = subprocess.run(['/bin/bash', '-c', "lspci | grep -i vmware"], stdout=subprocess.PIPE, text=True).stdout.strip()
    is_vm = True if result else False
    if is_vm:
        ram_kb = int(subprocess.run(['/bin/bash', '-c', "cat /proc/meminfo | grep MemTotal | xargs | cut -d ' ' -f 2"], stdout=subprocess.PIPE, text=True).stdout.strip())
        ram_kb = int((ram_kb * 1024) / 1000)
        ram_mb = int(ram_kb / 1000)
        wfile = user_home + "/.comicemem"
        with open(wfile, "w") as file:
            file.write("Size: " + str(ram_mb) + " MB\n")
            file.write("Speed: 0 MHz\n")
            file.write("Type: Unknown\n")
    else:
        subprocess.call(['/bin/bash', '-c', "sudo dmidecode --type 17 | cut -f2 -d $'\t' | grep -e Size: -e Type: -e '^Speed:' > " + user_home + "/.comicemem"])
    print('Updating icon cache...')
    subprocess.call(['gtk-update-icon-cache', '-q', '-t' ,'-f', hicolor])
