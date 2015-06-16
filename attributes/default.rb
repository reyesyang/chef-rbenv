user = (node[:rbenv] && node[:rbenv][:user]) || 'webuser'
group = (node[:rbenv] && node[:rbenv][:group]) || user

default[:rbenv] = {
  user: user,
  group: group,

  path: "/home/#{user}/.rbenv",
  repository: 'https://github.com/sstephenson/rbenv.git',
  branch: 'master',

  plugins: {
    ruby_build: {
      path: "home/#{user}/.rbenv/plugins/ruby-build",
      repository: 'https://github.com/sstephenson/ruby-build.git',
      branch: 'master'
    }
  },

  ruby_version: nil,
  ruby_build_url: nil,
  ruby_sha256sum: nil,

  gem_source_default: 'https://rubygems.org/',
  gem_source_mirror: nil,

  http_proxy: nil,
  https_proxy: nil
}
