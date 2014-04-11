require 'sequel'
require 'dotenv'

Dotenv.load




DB = Sequel.connect(ENV['DATABASE_URL'])


require_relative 'app/hero_app'

run HeroApp