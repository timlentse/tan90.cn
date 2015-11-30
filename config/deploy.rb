lock '3.4.0'

set :application, 'www.elong.com.hotel'
set :repo_url, 'git@code.corp.elong.com:jinglun.xie/hotels.git'
set :deploy_to, '~/www.elong.com.hotel'

# Deploy the current branch
set :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp  }.call

# Default value for :linked_files is []
set :linked_file, %w{Gemfile.lock .bundle/config config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/sitemap', '.bundle', 'public/theme')

namespace :deploy do

  after :deploy, :symlink_config_files do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      execute "ln -s #{deploy_to}/shared/config/database.yml #{deploy_to}/current/config/database.yml"
    end
  end

  after :symlink_config_files, :update_gems do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      execute "cd #{deploy_to}/current && bundle install"
    end
  end

  task :update_sitemap do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      execute  "cd #{deploy_to}/current  && nohup rake sitemap:creating_basic_url 1>/dev/null 2>#{deploy_to}/current/log/update_sitemap.err &"
    end
  end

  # Start whenever schedule
  task :start_schedule do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      execute  "cd #{deploy_to}/current  && bundle exec whenever -i Special_hotel &"
    end
  end

  # Update assets
  after :update_gems, :update_assets  do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      execute  "cd #{deploy_to}/current && rake assets:precompile && config/unicorn.init.sh upgrade"
    end
  end

  # Update redis
  task :load_hot_hotels do 
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      execute "cd #{deploy_to}/current && bundle exec rake redis:load_hot_hotels 1>/dev/null 2>#{deploy_to}/current/update_redis.err &"
    end
  end

  task :create_html_links do 
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      execute "cd #{deploy_to}/current && bundle exec rake redis:create_html_links 1>/dev/null 2>#{deploy_to}/current/update_redis.err &"
    end
  end

end
