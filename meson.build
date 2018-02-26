# Project metadata.
project(
  'libkcapi',
  'c',
  version: '1.0.3',
  license: 'BSD or GPLv2+',
  default_options: [
    'buildtype=debugoptimized',
    'c_std=c99',
    'unity=on',
    'warnlevel=3',
    'werror=false',
  ],
  meson_version: '>= 0.41',
)


# Get the compiler object for further use.
compiler = meson.get_compiler('c')


# Check availability of some basic functions.
system_config = configuration_data()

functions = [
  'getrandom',
  'secure_getenv',
]

foreach func : functions
  if compiler.has_function(func)
    system_config.set('HAVE_@0@'.format(func.to_upper()), 1)
  endif
endforeach


# Check for headers.
headers = [
  'linux/cryptouser.h',
]

foreach header : headers
  if compiler.has_header(header)
    system_config.set('HAVE_@0@'.format(header.to_upper().underscorify()), 1)
  endif
endforeach


# Generate general config header.
config_header = configure_file (
  configuration: system_config,
  output: 'kcapi_common_config.h'
)

# Set header include path.
include_dirs = include_directories('.', 'lib')


# Set sane default compiler and linker flags.
add_global_arguments('-fPIC', language: 'c')
add_global_arguments('-Wp,-D_FORTIFY_SOURCE=2', language: 'c')
add_global_link_arguments('-Wl,-z,relro,-z,now', language: 'c')


# Check compiler features for hardening.
hardening_flags = [
  ['-fasynchronous-unwind-tables'],
  ['-fcf-protection'],
  ['-fexceptions'],
  ['-fstack-clash-protection'],
  ['-fstack-protector-strong'],
  ['-fwrapv'],
  ['-grecord-gcc-switches'],
  ['-mcet'],
  ['-Werror=format-security'],
  ['--param ssp-buffer-size=4'],
]

foreach flag : hardening_flags
  if compiler.has_argument(flag)
    add_global_arguments(flag, language: 'c')
  endif
endforeach


# Additional compiler warnings.
warning_flags = [
  ['-pedantic'],
  ['-Wextra'],
  ['-Wpedantic'],
]

foreach flag : warning_flags
  if compiler.has_argument(flag)
    add_global_arguments(flag, language: 'c')
  endif
endforeach


# Flags used with certain targets.
test_flags = [
  ['overlength-strings', '-Wno-overlength-strings'],
  ['visibility-hidden', '-fvisibility=hidden'],
]

additional_flags = configuration_data()

foreach flag : test_flags
  if compiler.has_argument(flag[1])
    additional_flags.set(flag[0], flag[1])
  endif
endforeach


# Check for programs.
cppcheck = find_program(
  'cppcheck',
  native: true,
  required: false,
)

ln = find_program(
  'ln',
  native: true,
  required: true,
)

openssl = find_program(
  'openssl',
  native: true,
  required: true,
)


# Setup for additional configurable dirs.
if get_option('docdir') == ''
  docdir = join_paths(get_option('datadir'), 'doc', meson.project_name())
else
  docdir = get_option('docdir')
endif

if get_option('pkgconfigdir') == ''
  pkgconfigdir = join_paths(get_option('libdir'), 'pkgconfig')
else
  pkgconfigdir = get_option('pkgconfigdir')
endif


# Collect source files for static code analyzer.
scan_src = [config_header]


# Predefined variable.  Might be used by included subdirs.
kcapi_hasher_links = []


# Include subdirs.
subdir('doc')
subdir('lib')

if get_option('SPEED')
  subdir('speed-test')
endif

if get_option('TEST')
  subdir('test')
endif

if get_option('DGSTAPP') or get_option('ENCAPP') or get_option('HASHER') or get_option('RNGAPP')
  subdir('apps')
endif

subdir('scripts')


# Target for static code analyzer.
if cppcheck.found()
  custom_target(
    'cppcheck',
    command: [
      cppcheck,
      '--enable=performance,warning,portability',
      '@INPUT@',
    ],
    input: scan_src,
    output: 'cppcheck',
    build_by_default: false,
    build_always: false,
  )
endif
