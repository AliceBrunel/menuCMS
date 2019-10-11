class ApplicationController < Sinatra::Base
  layout "layout"

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'

    enable :sessions
    set :session_secret, "menuscollection"
  end

  get '/' do
    @menu = Menu.find_by activated: 1
    erb :restaurant_page, :layout => false
  end

  get '/team' do
    erb :homepage
  end

  helpers do

    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

  end

end
