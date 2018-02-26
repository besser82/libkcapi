# Setup versioning defines.
libkcapi_version_array = meson.project_version().split('.')
libkcapi_version_config = configuration_data()
libkcapi_version_config.set('KCAPI_MAJVERSION', libkcapi_version_array[0])
libkcapi_version_config.set('KCAPI_MINVERSION', libkcapi_version_array[1])
libkcapi_version_config.set('KCAPI_PATCHLEVEL', libkcapi_version_array[2])


# Generate header file with versioning defines.
libkcapi_version_header = configure_file(
  configuration: libkcapi_version_config,
  output: 'kcapi-version.h'
)


# Source files for the library.
libkcapi_src = files(
  'internal.h',
  'kcapi.h',
  'kcapi-kernel-if.c',
  'kcapi-utils.c',
)

if not system_config.has('HAVE_LINUX_CRYPTOUSER_H')
  libkcapi_src += files('cryptouser.h')
endif


# Configurable features.
if get_option('LIB_SYM')
	libkcapi_src += files('kcapi-sym.c')
endif

if get_option('LIB_MD')
	libkcapi_src += files('kcapi-md.c')

	if get_option('LIB_KDF')
		libkcapi_src += files('kcapi-kdf.c')
	endif
endif

if get_option('LIB_AEAD')
	libkcapi_src += files('kcapi-aead.c')
endif

if get_option('LIB_RNG')
	libkcapi_src += files('kcapi-rng.c')
endif

if get_option('LIB_ASYM')
	libkcapi_src += files('kcapi-asym.c')
endif

if get_option('LIB_KPP')
	libkcapi_src += files('kcapi-kpp.c')
endif


# Add sources for static analyzer.
scan_src += libkcapi_src
scan_src += libkcapi_version_header


# Map file and flags for symbol versioning.
libkcapi_mapfile = join_paths(meson.current_source_dir(), 'version.lds')
vflags = [
  '-Wl,--version-script,@0@'.format(libkcapi_mapfile),
  additional_flags.get('visibility-hidden'),
]


# Build the library.
libkcapi = shared_library(
  'kcapi',
  libkcapi_src,
  version: meson.project_version(),
  c_args: additional_flags.get('visibility-hidden'),
  include_directories: include_dirs,
  link_args: vflags,
  link_depends: libkcapi_mapfile,
  pic: true,
  install: true,
)

libkcapi_static = static_library(
  'kcapi',
  libkcapi_src,
  version: meson.project_version(),
  c_args: additional_flags.get('visibility-hidden'),
  include_directories: include_dirs,
  pic: true,
  install: true,
)


# Install header file.
install_headers('kcapi.h')


# Generate and install pkgconfig file.
pkg = import('pkgconfig')
pkg.generate(
  libraries: libkcapi,
  version: meson.project_version(),
  name: meson.project_name(),
  description: 'Linux Kernel Crypto API User Space Interface Library',
  url: 'http://www.chronox.de/@0@.html'.format(meson.project_name()),
  filebase: meson.project_name(),
  install_dir: pkgconfigdir,
)
