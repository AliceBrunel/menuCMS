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

end
