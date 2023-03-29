# comice-about

comice-about is a powerful and simple `About Dialog`, that show your machine information like CPU, RAM Memory, Video Card, Disk Used Space, etc.

It is being developed for **comiceOS**.

## Screenshot
![Overview](https://raw.githubusercontent.com/libredeb/comice-about/master/screenshots/overview.png)
![Displays](https://raw.githubusercontent.com/libredeb/comice-about/master/screenshots/displays.png)
![Storage](https://raw.githubusercontent.com/libredeb/comice-about/master/screenshots/storage.png)
![Memory](https://raw.githubusercontent.com/libredeb/comice-about/master/screenshots/memory.png)


## Compilation

1. Install dependencies:
   * For Ubuntu:
      ```
      $ sudo apt-get install meson ninja-build cdbs valac libvala-*-dev libglib2.0-dev libgtk-3-dev python3 python3-wheel python3-setuptools baobab mesa-utils
      ```
   * For Fedora:
      ```
      $ sudo dnf install meson ninja-build cdbs vala libvala-devel glib-devel gtk3-devel python3 python3-wheel python3-setuptools baobab glx-utils
      ```
2. Create a build folder:
   ```
   $ meson build --prefix=/usr
   ```
3. Compile `comice-about`:
   ```
   $ cd build
   $ ninja
   ```
4. Install comice-about in the system:
   ```
   $ sudo ninja install
   $ sudo MESON_INSTALL_PREFIX="/usr" USER="$HOME" python3 ../post_install.py
   ```
5. (OPTIONAL) Uninstall comice-about:
   ```
   $ sudo ninja uninstall
   $ rm -Rf $HOME/.comicemem
   ```

## How to Debug?

To debug a Vala application, you must follow these steps:

1. Create build folder with type debug:
   ```bash
   $ meson build --prefix=/usr --buildtype=debug
   ```
2. Compile `comice-about`:
   ```bash
   $ cd build
   $ ninja
   ```
3. Run the application in debug mode:
   ```bash
   $ gdb ./com.github.libredeb.comice-about
   ```

   The above command has the next output:
   ```bash
   GNU gdb (Ubuntu 12.1-0ubuntu1~22.04) 12.1
   Copyright (C) 2022 Free Software Foundation, Inc.
   License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
   This is free software: you are free to change and redistribute it.
   There is NO WARRANTY, to the extent permitted by law.
   Type "show copying" and "show warranty" for details.
   This GDB was configured as "x86_64-linux-gnu".
   Type "show configuration" for configuration details.
   For bug reporting instructions, please see:
   <https://www.gnu.org/software/gdb/bugs/>.
   Find the GDB manual and other documentation resources online at:
      <http://www.gnu.org/software/gdb/documentation/>.

   For help, type "help".
   Type "apropos word" to search for commands related to "word"...
   Reading symbols from ./com.github.libredeb.comice-about...
   (gdb) █
   ```

   In this point, you need to type `r` command (also known as `run` command) and press ENTER.

   Then, debugging information will be displayed.

   To exit the debugger, type `q` command (also known as `quit` command) and press ENTER.

## Changelog

**Version 0.0.2**
* Fixed log level for startup disk
* Fixed a bug that caused unwanted information to be added when obtaining information from the graphics card
* Fixed a bug that caused the whole application to crash when getting information from the RAM memory
* Fixed a bug that prevents the application startup when there is more than one screen

**Version 0.0.1**
* Initial version, First release
* Implemented the first 4 important tabs
* New functions to show real hardware information

