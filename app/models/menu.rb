class Menu < ActiveRecord::Base
  belongs_to :user
  has_many :menu_meals
  has_many :meals, through: :menu_meals


end
