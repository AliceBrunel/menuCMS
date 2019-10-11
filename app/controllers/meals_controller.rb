class MealsController < ApplicationController

  get '/meals' do
    if logged_in?
      @meals = Meal.all
      erb :'meals/meals', :layout => :layout
    else
      redirect to '/signin'
    end
  end

  get '/meals/create-meal' do
    if logged_in?
      erb :'meals/create_meal'
    else
      redirect to '/signin'
    end
  end

  get '/meals/:slug' do
    if logged_in?
      @meal = Meal.find_by_slug(params[:slug])
      @creator = @meal.user
      erb :'meals/show'
    else
      redirect to '/signin'
    end
  end

  post '/meals' do
    if logged_in?
      if params[:name] == ""
        redirect to '/create-menu'
      else
        @meal = current_user.meals.build(name: params[:name], ingredients: params[:ingredients], method: params[:method] )
        @meal.save
        redirect to "/meals/#{@meal.slug}"
      end
    else
      redirect to '/signin'
    end
  end


  get '/meals/:slug/edit' do
    if logged_in?
    @meal = Meal.find_by_slug(params[:slug])
      if @meal && @meal.user == current_user
        erb :'meals/edit'
      else
        redirect to '/meals'
      end
    else
      redirect to '/signin'
    end
  end

  patch '/meals/:slug' do
    if logged_in?
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
    else
      redirect to '/login'
    end
  end

  delete '/meals/:slug/DELETE' do
    if logged_in?
      @meal = Meal.find_by_slug(params[:slug])
      if @meal && @meal.user == current_user
        @meal.delete
      end
      redirect to '/meals'
    else
      redirect to '/login'
    end
  end


end
