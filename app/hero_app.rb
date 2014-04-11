require 'sinatra/base'
require './lib/hero_repository'
require './lib/user'

class HeroApp < Sinatra::Application
  # DB[:heroes].delete
  HEROES = HeroRepository.new(DB)
  USERS = User.new(DB)

  enable :sessions

  get '/' do
    erb :index, :locals => {:logged_in => session[:logged_in]}
  end

  get '/login' do
    erb :login, locals: {error_message: nil}
  end

  get '/logout' do
    session[:logged_in] = false
    redirect '/'
  end

  post '/login' do
    if params[:secret_password] == "password"
      session[:logged_in] = true
      redirect '/'
    else
      erb :login, locals: {error_message: "Incorrect Password"}
    end
  end

  get '/heroes' do
    heroes = HEROES.index
    erb :heroes, :locals => {:heroes => heroes}
  end

  get '/new' do
    erb :new
  end

  post '/heroes' do
    HEROES.create({:name => params[:name], :description => params[:description], :hero_type => params[:hero_type], :image => params[:image]})
    redirect '/heroes'
  end

  get '/show/:id' do
    hero = HEROES.show(params[:id].to_i)
    erb :show, :locals => {:hero => hero, :logged_in => session[:logged_in]}
  end

  get '/edit/:id' do
    hero = HEROES.show(params[:id].to_i)
    erb :edit, :locals => {:hero => hero}
  end

  post '/edit/:id' do
    HEROES.update(params[:id].to_i, {:name => params[:name], :description => params[:description], :hero_type => params[:hero_type], :image => params[:image]})
    redirect '/heroes'
  end

  post '/heroes/:id' do
    HEROES.delete(params[:id].to_i)
    redirect '/heroes'
  end

  get '/new_user' do
    erb :new_user
  end

  get '/users' do
    if session[:logged_in]
      users = USERS.index
      erb :users, :locals => {:users => users}
    else
      redirect '/'
    end
  end

  get '/user/:id' do
    user = USERS.find(params[:id].to_i)
    erb :user, :locals => {:user => user, :id => params[:id].to_i, :logged_in => params[:logged_in], }
  end

  post '/users' do
    USERS.create({:username => params[:username], :first_name => params[:first_name], :last_name => params[:last_name], :email => params[:email]})
    redirect '/'
  end

  post '/edit_user/:id' do
    USERS.update(params[:id].to_i, {:username => params[:username], :first_name => params[:first_name], :last_name => params[:last_name], :email => params[:email]})
    redirect '/users'
  end

  get '/edit_user/:id' do
    user = USERS.find(params[:id].to_i)
    erb :edit_user, :locals => {:user => user}
  end

  post '/user/:id' do
    USERS.delete(params[:id].to_i)
    redirect '/users'
  end

end
