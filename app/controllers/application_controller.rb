require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_secret"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    redirect to('/tweets') if is_logged_in?
    erb :signup
  end

  post '/signup' do
    a = params[:username]
    b = params[:email]
    c = params[:password]

    [a, b, c].each do |param|
      redirect to('/signup') if param.empty?
    end

    User.new( username: a, email: b, password: c)
    redirect to('/tweets')
  end

  helpers do
    def is_logged_in?
      !session[:user_id].nil?
    end

    def current_user
      User.find(session[:user_id])
    end

  end

end
