require 'sequel'
require 'dotenv'

Dotenv.load

database = if !ENV['HEROKU_POSTGRESQL_COBALT_URL'].nil?
        ENV['HEROKU_POSTGRESQL_COBALT_URL']
           else
             ENV['DATABASE_URL']
           end


DB = Sequel.connect(database)


require_relative 'app/hero_app'

run HeroApp