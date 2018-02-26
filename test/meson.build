# Executables for the testsuite.
kcapi = executable(
  'kcapi',
  'kcapi-main.c',
  c_args: additional_flags.get('overlength-strings'),
  include_directories: include_dirs,
  link_depends: libkcapi,
  link_args: '-pie',
  link_with: libkcapi,
  install: true,
)

kcapi_enc_test_large = executable(
  'kcapi-enc-test-large',
  'kcapi-enc-test-large.c',
  include_directories: include_dirs,
  link_depends: libkcapi,
  link_args: '-pie',
  link_with: libkcapi,
  install: true,
)

kcapi_convenience = executable(
  'kcapi-convenience',
  'kcapi-convenience.c',
  include_directories: include_dirs,
  link_depends: libkcapi,
  link_args: '-pie',
  link_with: libkcapi,
  install: true,
)


# Add sources for static analyzer.
scan_src += files(
  'kcapi-main.c',
  'kcapi-enc-test-large.c',
  'kcapi-convenience.c'
)
