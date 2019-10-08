class MenusController < ApplicationController

  get '/menus' do
    if logged_in?
      @menus = Menu.all
      erb :'menus/menus'
    else
      redirect to '/signin'
    end
  end

  get '/menus/create-menu' do
    if logged_in?
      erb :'menus/create_menu'
    else
      redirect to '/signin'
    end
  end

  get '/menus/:slug' do
    if logged_in?
      @menu = Menu.find_by_slug(params[:slug])
      erb :'menus/show'
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
        redirect to "/menus/#{@menu.slug}"
      end
    else
      redirect to '/signin'
    end
  end

  get '/menus/:slug/edit' do
    if logged_in?
    @menu = Menu.find_by_slug(params[:slug])
      if @menu && @menu.user == current_user
        erb :'menu/edit'
      else
        redirect to '/menus'
      end
    else
      redirect to '/signin'
    end
  end

#Patch for partial update of menu
  patch '/menus/:slug' do
    if logged_in?
      if params[:name] == ""
        redirect to "/menus/#{@menu.slug}/edit"
      else
        @menu = Menu.find_by_slug(params[:slug])
          if @menu && @menu.user == current_user
            @menu.update(params[:menu])
            unless params[:meals].empty?
              @menu.meals << Meal.create(params[:meals])
            end
            @menu.save
            redirect to "/menus/#{@menu.slug}"
          else
            redirect to "/menus/#{@menu.slug}/edit"
          end
      end
    else
      redirect to '/login'
    end
  end

end
