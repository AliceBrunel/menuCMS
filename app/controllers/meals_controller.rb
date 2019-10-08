class MealsController < ApplicationController

  get '/meals' do
    if logged_in?
      @meals = Meal.all
      erb :'meals/meals'
    else
      redirect to '/signin'
    end
  end

end
