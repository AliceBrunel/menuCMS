class UsersController < ApplicationController

  get '/user/:username' do
    @user = User.find_by(:username => params[:username])
    erb :'users/show'
  end

  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect to '/menus'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == "" || params[:role] == ""
      redirect to '/signup'
    elsif User.find_by(:username => params[:username])
      flash[:username_exists] = "This username already exists."
      redirect to '/signup'
    elsif User.find_by(:email => params[:email])
      flash[:email_exists] = "This email already exists."
      redirect to '/signup'
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password], :role => params[:role])
      @user.save
      session[:user_id] = @user.id
      redirect to '/menus'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect to '/menus'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/menus'
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/team'
    else
      redirect to '/team'
    end
  end

end
