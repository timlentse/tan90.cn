require 'net/ssh/proxy/command'

role :web, %w{work@train1}
server 'train1', user: 'work', roles: %w{web}
server 'train2', user: 'work', roles: %w{web}
server 'train3', user: 'work', roles: %w{web}
server 'train4', user: 'work', roles: %w{web}

set :ssh_options, {
  keys: %w(~/.ssh/id_rsa),
  proxy: Net::SSH::Proxy::Command.new('ssh work@test1 -W %h:%p')
}
