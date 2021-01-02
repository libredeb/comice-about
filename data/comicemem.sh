#!/bin/bash

ARCH=`uname -m`

if [ "$ARCH" == "x86_64" ] || [ "$ARCH" == "amd64" ] || [ "$ARCH" == "i386" ] || [ "$ARCH" == "i486" ] || [ "$ARCH" == "i586" ] || [ "$ARCH" == "i686" ]; then
    sudo dmidecode --type 17 | cut -f2 -d $'\t' | grep -e Size: -e Type: -e '^Speed:' > $HOME/.comicemem
else
    CPU=`sed -n 's/^Revision[ \t]*: *//p' /proc/cpuinfo`

    case "$CPU" in
        a020d3|a02082|a01040|a21041|a22042|a01041|a22042|a22082|a32082|a52082|a22083)
            cat > $HOME/.comicemem <<EOL
Size: 1 GB
Type: LPDDR2
Speed: 800 MHz
EOL
	        ;;
        9020e0|900092|900093|9000c1|920092|920093)
            cat > $HOME/.comicemem <<EOL
Size: 512 MB
Type: LPDDR2
Speed: 800 MHz
EOL
            ;;
        a03111)
            cat > $HOME/.comicemem <<EOL
Size: 1 GB
Type: LPDDR4
Speed: 3200 MHz
EOL
            ;;
        b03111|b03112|b03114)
            cat > $HOME/.comicemem <<EOL
Size: 2 GB
Type: LPDDR4
Speed: 3200 MHz
EOL
            ;;
        c03111|c03112|c03114)
            cat > $HOME/.comicemem <<EOL
Size: 4 GB
Type: LPDDR4
Speed: 3200 MHz
EOL
            ;;
        d03114|c03130)
            cat > $HOME/.comicemem <<EOL
Size: 8 GB
Type: LPDDR4
Speed: 3200 MHz
EOL
            ;;
        *)
            cat > $HOME/.comicemem <<EOL
Size: 0 GB
Type: LPDDR?
Speed: 0000 MHz
EOL
            ;;
    esac
fi
