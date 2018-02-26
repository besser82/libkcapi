custom_target(
  'pdf',
  build_by_default: get_option('PDF'),
  depends: libkcapi_xml,
  command: [
    'HOME=@0@'.format(meson.current_build_dir()),
    db2pdf, '-o', meson.current_build_dir(), '@INPUT@',
  ],
  input: libkcapi_xml,
  output: 'libkcapi.pdf',
  install: get_option('PDF'),
  install_dir: docdir,
)
