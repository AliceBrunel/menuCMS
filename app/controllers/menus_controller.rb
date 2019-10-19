class MenusController < ApplicationController

  get '/menus' do
    redirect_if_not_logged_in
      @menus = Menu.all
      erb :'menus/menus'
  end

  get '/menus/create-menu' do
    redirect_if_not_logged_in
      erb :'menus/create_menu'
  end

  get '/menus/:slug' do
    redirect_if_not_logged_in
      @menu = Menu.find_by_slug(params[:slug])
      if !@menu
        redirect to '/menus'
      else
        @creator = @menu.user
        erb :'menus/show'
      end
  end


  post '/menus' do
    redirect_if_not_logged_in
      if params[:name] == ""
        redirect to '/create-menu'
      else
        @menu = current_user.menus.build(name: params[:name], activated: 0)
        @menu.meals << Meal.find(params[:meals])
        @menu.save

        redirect to "/menus/#{@menu.slug}"

      end
  end

  patch '/menus/:slug/activate' do
    redirect_if_not_logged_in
      @deactivated_menu = Menu.where(activated: 1)
      if !@deactivated_menu.empty? && current_user.role == "manager"
        @deactivated_menu.each do |activated|
          activated.activated = 0
          activated.save
        end
      end
      @menu = Menu.find_by_slug(params[:slug])
      @menu.activated = 1
      @menu.save
      redirect to '/menus'
  end

  get '/menus/:slug/edit' do
    redirect_if_not_logged_in
    @menu = Menu.find_by_slug(params[:slug])
      if @menu && @menu.user == current_user
        erb :'menus/edit'
      else
        redirect to '/menus'
      end
  end

  patch '/menus/:slug' do
    redirect_if_not_logged_in
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
  end

  delete '/menus/:slug/DELETE' do
    redirect_if_not_logged_in
      @menu = Menu.find_by_slug(params[:slug])
        if @menu && @menu.user == current_user
          @menu.delete
        end
      redirect to '/menus'
  end

end
