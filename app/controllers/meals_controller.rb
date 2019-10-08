class MealsController < ApplicationController

  get '/meals' do
    if logged_in?
      @meals = Meal.all
      erb :'meals/meals'
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
      erb :'meals/show'
    else
      redirect to '/signin'
    end
  end

end
