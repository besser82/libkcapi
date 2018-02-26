# Setup post-install script.
meson.add_install_script(
  'kcapi-hmac-link.sh',
  get_option('bindir'),
  get_option('libdir'),
  meson.project_version(),
  openssl.path(),
  ln.path(),
  ' '.join(kcapi_hasher_links),
)


# API check.
api_version = run_command(
  'get_api_ver.sh',
  libkcapi_mapfile,
).stdout().strip()

message('API version     = @0@'.format(api_version))
message('LIBRARY version = @0@'.format(meson.project_version()))

if not api_version.version_compare('=@0@'.format(meson.project_version()))
  error('API version != LIBRARY version')
endif
