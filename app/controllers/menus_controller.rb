class MenusController < ApplicationController

  get '/menus' do
    if logged_in?
      @menus = Menu.all
      erb :'menus/menus'
    else
      redirect to '/signin'
    end
  end

end
