class UserController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect to '/menus'
    end
  end

  get '/signin' do
    if params[:username] == "" || params[:email] == "" || params[:password] == "" || params[:role] == ""
      redirect to '/signup'
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password], :role => params[:role])
      @user.save
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
  end

end
