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
      @creator = @menu.user
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
        @menu = current_user.menus.build(name: params[:name], activated: 0)
        @menu.meals << Meal.find(params[:meals])
        @menu.save

        redirect to "/menus/#{@menu.slug}"

      end
    else
      redirect to '/signin'
    end
  end

patch '/menus/:slug/activate' do
  if logged_in?

    # This is really terrible
    @deactivated_menu = Menu.where(activated: 1)

    if !@deactivated_menu.empty?

      @deactivated_menu.each do |activated|
        activated.activated = 0
        activated.save
      end

    end
    @menu = Menu.find_by_slug(params[:slug])
    @menu.activated = 1
    @menu.save

    redirect to '/menus'
  else
    redirect to '/signin'
  end
end

  get '/menus/:slug/edit' do
    if logged_in?
    @menu = Menu.find_by_slug(params[:slug])
      if @menu && @menu.user == current_user
        erb :'menus/edit'
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


    delete '/menus/:slug/DELETE' do
      if logged_in?
        @menu = Menu.find_by_slug(params[:slug])
        if @menu && @menu.user == current_user
          @menu.delete
        end
        redirect to '/menus'
      else
        redirect to '/login'
      end
    end

end
