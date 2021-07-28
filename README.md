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
      $ sudo apt-get install meson ninja-build cdbs valac libvala-*-dev libglib2.0-dev libgtk-3-dev python3 python3-wheel python3-setuptools baobab
   ```
   * For Fedora:
   ```
      $ sudo dnf install meson ninja-build cdbs vala libvala-devel glib-devel gtk3-devel python3 python3-wheel python3-setuptools baobab
   ```
   2. Create a build folder:
   ```
      $ meson build --prefix=/usr
   ```
   3. Compile comice-about:
   ```
      $ cd build
      $ ninja
   ```
   4. Install comice-about in the system:
   ```
      $ sudo ninja install
   ```
   5. (OPTIONAL) Uninstall comice-about:
   ```
      $ sudo ninja uninstall
   ```


## Changelog
**Version 0.0.1**
* Initial version, First release
* Implemented the first 4 important tabs
* New functions to show real hardware information

