libkcapi_apps_src = files (
  'app-internal.h',
  'app-internal.c',
)

libkcapi_apps = shared_library(
  'kcapi_apps',
  libkcapi_apps_src,
  version: meson.project_version(),
  include_directories: include_dirs,
  link_depends: libkcapi,
  link_with: libkcapi,
  install: true,
)

app_libs = [libkcapi_apps, libkcapi]

if get_option('DGSTAPP')
  kcapi_dgst = executable(
    'kcapi-dgst',
    'kcapi-dgst.c',
    include_directories: include_dirs,
    link_depends: app_libs,
    link_args: '-pie',
    link_with: app_libs,
    install: true,
  )

  install_data(
    'kcapi-dgst.1',
    install_dir: join_paths(get_option('mandir'), 'man1'),
    install_mode: 'rw-r--r--',
  )

  scan_src += files('kcapi-dgst.c')
endif

if get_option('ENCAPP')
kcapi_enc = executable(
  'kcapi-enc',
  'kcapi-enc.c',
  include_directories: include_dirs,
  link_depends: app_libs,
  link_args: '-pie',
  link_with: app_libs,
  install: get_option('ENCAPP'),
)

  install_data(
    'kcapi-enc.1',
    install_dir: join_paths(get_option('mandir'), 'man1'),
    install_mode: 'rw-r--r--',
  )

  scan_src += files('kcapi-enc.c')
endif

if get_option('HASHER')
  kcapi_hasher_libs = []

  if not compiler.has_function('dlopen')
    dl_lib = compiler.find_library('dl', required: true)
    compiler.has_function('dlopen', dependencies: dl_lib)
    kcapi_hasher_libs += dl_lib
  endif

  kcapi_hasher = executable(
    'kcapi-hasher',
    'kcapi-hasher.c',
    dependencies: kcapi_hasher_libs,
    include_directories: include_dirs,
    link_depends: app_libs,
    link_args: '-pie',
    link_with: app_libs,
    install: true,
  )


  # Array with links needed for kcapi-hasher.
  kcapi_hasher_links += [
    'fipscheck',
    'fipshmac',
    'md5sum',
    'sha1hmac',
    'sha1sum',
    'sha224hmac',
    'sha224sum',
    'sha256hmac',
    'sha256sum',
    'sha384hmac',
    'sha384sum',
    'sha512hmac',
    'sha512sum',
  ]

  scan_src += files('kcapi-hasher.c')
endif

if get_option('RNGAPP')
  kcapi_rng = executable(
    'kcapi-rng',
    'kcapi-rng.c',
    include_directories: include_dirs,
    link_depends: app_libs,
    link_args: '-pie',
    link_with: app_libs,
    install: true,
  )

  install_data(
    'kcapi-rng.1',
    install_dir: join_paths(get_option('mandir'), 'man1'),
    install_mode: 'rw-r--r--',
  )

  scan_src += files('kcapi-rng.c')
endif
