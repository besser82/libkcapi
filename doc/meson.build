# Find some needed tools.
db2pdf = find_program(
  'db2pdf',
  native: true,
  required: false,
)

db2ps = find_program(
  'db2ps',
  native: true,
  required: false,
)

xmlto = find_program(
  'xmlto',
  native: true,
  required: false,
)


docproc_config = configuration_data()

docproc_config.set_quoted(
  'KERNELDOCPATH',
  meson.current_source_dir(),
)

docproc_config.set_quoted(
  'KERNSRCTREE',
  join_paths(meson.source_root(), 'lib'),
)

docproc_config.set_quoted(
  'LIBVERSION',
  meson.project_version(),
)

docproc_config.set_quoted(
  'SRCTREE',
  join_paths(meson.source_root(), 'lib'),
)

template_config = configuration_data()
template_config.set('LIBVERSION', meson.project_version())

docproc_version_header = configure_file(
  configuration: docproc_config,
  output: 'docproc-config.h',
)

docproc = executable(
  'docproc',
  'docproc.c',
  native: true,
  c_args: '-Wno-error',
  include_directories: include_dirs,
  link_args: '-pie',
  install: false,
)

docproc_template = configure_file(
  configuration: template_config,
  input: 'libkcapi.tmpl.in',
  output: 'libkcapi.tmpl',
)

libkcapi_xml = custom_target(
  'libkcapi_xml',
  build_by_default: true,
  capture: true,
  depends: docproc,
  command: [docproc, 'doc','@INPUT@'],
  input: docproc_template,
  output: 'libkcapi.xml',
)

docproc_man_template = configure_file(
  configuration: template_config,
  input: 'libkcapi_man.tmpl.in',
  output: 'libkcapi_man.tmpl',
)

libkcapi_man_xml = custom_target(
  'libkcapi_man_xml',
  build_by_default: true,
  capture: true,
  depends: docproc,
  command: [docproc, 'doc','@INPUT@'],
  input: docproc_man_template,
  output: 'libkcapi_man.xml',
)

if db2pdf.found()
  subdir('pdf')
endif

if db2ps.found()
  subdir('ps')
endif

if xmlto.found()
  custom_target(
    'html',
    build_by_default: get_option('HTML'),
    depends: libkcapi_xml,
    command: [
      xmlto, 'html-nochunks',
      '-m', join_paths(meson.current_source_dir(), 'stylesheet.xsl'),
      '--skip-validation',
      '-o', meson.current_build_dir(),
      '@INPUT@'
    ],
    input: libkcapi_xml,
    output: 'libkcapi.html',
    install: get_option('HTML'),
    install_dir: docdir,
  )

  custom_target(
    'man',
    build_by_default: get_option('MAN'),
    depends: libkcapi_man_xml,
    command: [
      xmlto, 'man',
      '-m', join_paths(meson.current_source_dir(), 'stylesheet.xsl'),
      '--skip-validation',
      '-o', join_paths(meson.current_build_dir(), 'man3'),
      '@INPUT@'
    ],
    input: libkcapi_man_xml,
    output: 'man3',
    install: get_option('MAN'),
    install_dir: get_option('mandir'),
  )
endif
