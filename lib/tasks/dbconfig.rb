require 'active_record'
DB_ENV = {
  'development'=>{
    :seo=>{
      adapter: 'mysql2',
      host: "192.168.15.50",
      username: 'test',
      password: 'test',
      database: 'test',
      encoding: 'utf8'
    }
  },
}

class City < ActiveRecord::Base
  @env = ENV['db_env'] || 'development'
  self.establish_connection(DB_ENV[@env][:seo])
end

class Hotel < ActiveRecord::Base
  @env = ENV['db_env'] || 'development'
  self.establish_connection(DB_ENV[@env][:seo])
end

