# Check presence of a function with or without a specefic lib.
kcapi_speed_libs = []

if not compiler.has_function('clock_gettime')
  rt_lib = compiler.find_library('rt', required: true)
  compiler.has_function('clock_gettime', dependencies: rt_lib)
  kcapi_speed_libs += rt_lib
endif

# Sources for executable.
kcapi_speed_src = files(
  'cryptoperf.h',
  'cryptoperf-aead.c',
  'cryptoperf-base.c',
  'cryptoperf-hash.c',
  'cryptoperf-main.c',
  'cryptoperf-rng.c',
  'cryptoperf-skcipher.c',
)


# Benchmark executable.
kcapi_speed = executable(
  'kcapi-speed',
  kcapi_speed_src,
  dependencies: kcapi_speed_libs,
  include_directories: include_dirs,
  link_depends: libkcapi,
  link_args: '-pie',
  link_with: libkcapi,
  install: true,
)


# Add sources for static analyzer.
scan_src += kcapi_speed_src
