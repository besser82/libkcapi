custom_target(
  'ps',
  build_by_default: get_option('PS'),
  depends: libkcapi_xml,
  command: [
    'HOME=@0@'.format(meson.current_build_dir()),
    db2ps, '-o', meson.current_build_dir(), '@INPUT@',
  ],
  input: libkcapi_xml,
  output: 'libkcapi.ps',
  install: get_option('PS'),
  install_dir: docdir,
)
