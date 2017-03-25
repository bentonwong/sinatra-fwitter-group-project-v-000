require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    "<h1>Welcome to Fwitter</h1><p><a href='/signup'>Sign Up</a></p><p><a href = '/login'>Log In</a></p>"
  end

  get '/signup' do
    if session[:id].nil?
      erb :'users/create_user'
    else
      redirect to '/tweets'
    end
  end

  get '/tweets' do
    erb :index
  end

  post '/signup' do
    if !params.values.any? {|value| value.empty?}
      user = User.create(params)
      session[:id] = user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  get '/login' do
    erb :'users/login'
  end

end
