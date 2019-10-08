class MenusController < ApplicationController

  get '/menus' do
    if logged_in?
      @menus = Menu.all
      erb :'menus/menus'
    else
      redirect to '/signin'
    end
  end

  get '/create-menu' do
    if logged_in?
      erb :'menus/create_menu'
    else
      redirect to '/signin'
    end
  end

  post '/menus' do
    if logged_in?
      if params[:name] == ""
        redirect to '/create-menu'
      else
        @menu = Menu.create(:name => params[:name])
        @menu.save
        redirect to "/menus/#{@menu.id}"
      end
    else
      redirect to '/signin'
    end
  end
end
