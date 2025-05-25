# Project name and programming language
project(
    'com.github.libredeb.comice-about',
    'vala', 'c',
    version: '0.0.3',
    meson_version: '>=0.56.0'
)

PROJECT_NAME = 'comice-about'
prefix = get_option('prefix')
libdir = join_paths(prefix, get_option('libdir'))
datadir = join_paths(prefix, get_option('datadir'))

VAPI_DIR = join_paths(meson.project_source_root(), 'vapi')
vala = meson.get_compiler('vala')

# Global configuration data - matches vapi/config.vapi strings
conf = configuration_data()
conf.set_quoted('PROJECT_NAME', PROJECT_NAME)
conf.set_quoted('DATA_DIR', datadir)
conf.set_quoted('PACKAGE_LIBDIR', libdir)
conf.set_quoted('PACKAGE_SHAREDIR', datadir)

config_h = configure_file(
	output: 'config.h',
	configuration: conf
)

config_dep = declare_dependency(
	dependencies: vala.find_library('config', dirs: VAPI_DIR),
	sources: config_h
)

config_inc_dir = include_directories('.')

ComiceAboutValaArgs = [
    '--pkg=config',
    '--vapidir=' + VAPI_DIR,
    '--target-glib=2.56',
]

# Create a new executable, list the files we want to compile, list the dependencies we need, and install
executable(
    meson.project_name(),
    'src/ComiceAbout.vala',
    'src/Resources.vala',
    'src/widgets/OverviewBox.vala',
    'src/widgets/DisplaysBox.vala',
    'src/widgets/StorageBox.vala',
    'src/widgets/MemoryBox.vala',
    'src/functions/GetDeviceModel.vala',
    'src/functions/GetProcessor.vala',
    'src/functions/GetMemory.vala',
    'src/functions/GetStartupDisk.vala',
    'src/functions/GetGraphics.vala',
    'src/functions/GetSerialNumber.vala',
    'src/functions/GetInch.vala',
    'src/functions/GetStorageInfo.vala',
    'src/functions/StorageUsage.vala',
    'src/functions/MemoryRAM.vala',
    dependencies: [
        dependency('gio-unix-2.0', version: '>=2.56.0'),
        dependency('glib-2.0', version: '>=2.56.0'),
        dependency('gtk+-3.0', version: '>=3.22'),
        dependency('gdk-3.0', version: '>=3.22.0'),
        dependency('pango', version: '>=1.40.0'),
        # Similar to add options "-X -lm" in cmake to use Math.pow()
        meson.get_compiler('c').find_library('m', required: false)
    ],
    c_args: [
        '-w',
    ],
    vala_args: ComiceAboutValaArgs,
    include_directories: config_inc_dir,
    install: true
)

# Install CSS file
install_data(
    join_paths('data', 'application.css'),
    install_dir: join_paths(datadir, PROJECT_NAME)
)

# Install app icons
icon_sizes = ['scalable']
foreach i : icon_sizes
    install_data(
        join_paths('data', 'icons', 'comice-about.png'),
        install_dir: join_paths(datadir, 'icons', 'hicolor', i, 'apps')
    )
endforeach

install_data(
    join_paths('data','icons', 'logo.png'),
    install_dir: join_paths(datadir, PROJECT_NAME)
)
install_data(
    join_paths('data','icons', 'hdd.png'),
    install_dir: join_paths(datadir, PROJECT_NAME)
)
install_data(
    join_paths('data','icons', 'display.png'),
    install_dir: join_paths(datadir, PROJECT_NAME)
)

# Install our .desktop file so the Applications Menu will see it
install_data(
    join_paths('data', meson.project_name() + '.desktop'),
    install_dir: join_paths(datadir, 'applications')
)

# Install our .appdata.xml file so AppCenter will see it
install_data(
    join_paths('data', meson.project_name() + '.appdata.xml'),
    install_dir: join_paths(datadir, 'metainfo')
)

meson.add_install_script('post_install.py')

