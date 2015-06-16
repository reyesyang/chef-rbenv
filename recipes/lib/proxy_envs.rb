# encoding: UTF-8

def proxy_envs
  envs = {}

  if http_proxy = node[:rbenv][:http_proxy]
    envs['http_proxy'] = http_proxy
  end

  if https_proxy = node[:rbenv][:https_proxy]
    envs['https_proxy'] = https_proxy
  end

  envs
end
