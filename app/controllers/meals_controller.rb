class MealsController < ApplicationController

  get '/meals' do
    redirect_if_not_logged_in
      @meals = Meal.all
      erb :'meals/meals', :layout => :layout
  end

  get '/meals/create-meal' do
    redirect_if_not_logged_in
      erb :'meals/create_meal'
  end

  get '/meals/:slug' do
    redirect_if_not_logged_in
      @meal = Meal.find_by_slug(params[:slug])
      if !@meal
        redirect to '/meals'
      else
        @creator = @meal.user
        erb :'meals/show'
      end

  end

  post '/meals' do
    redirect_if_not_logged_in
      if params[:name] == ""
        redirect to '/create-menu'
      else
        @meal = current_user.meals.build( name: params[:name], ingredients: params[:ingredients], method: params[:method] )
        @meal.save
        redirect to "/meals/#{@meal.slug}"
      end
  end


  get '/meals/:slug/edit' do
    redirect_if_not_logged_in
    @meal = Meal.find_by_slug(params[:slug])
      if @meal && @meal.user == current_user
        erb :'meals/edit'
      else
        redirect to '/meals'
      end
  end

  patch '/meals/:slug' do
    redirect_if_not_logged_in
      if params[:name] == ""
        redirect to "/meals/#{@meal.slug}/edit"
      else
        @meal = Meal.find_by_slug(params[:slug])
          if @meal && @meal.user == current_user
            @meal.update(params[:meal])
            @meal.save
            redirect to "/meals/#{@meal.slug}"
          else
            redirect to "/meals/#{@meal.slug}/edit"
          end
      end
  end

  delete '/meals/:slug/DELETE' do
    redirect_if_not_logged_in
      @meal = Meal.find_by_slug(params[:slug])
      if @meal && @meal.user == current_user
        @meal.delete
      end
      redirect to '/meals'
  end


end
