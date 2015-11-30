require 'net/ssh/proxy/command'
server '10.39.16.60', user: 'work', roles: %w{web}
role :web, %w{work@172.21.31.65}
set :ssh_options, {
  keys: %w(~/.ssh/id_rsa),
  proxy: Net::SSH::Proxy::Command.new('ssh work@test1 -W %h:%p')
}
