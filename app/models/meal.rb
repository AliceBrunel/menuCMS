class Meal < ActiveRecord::Base
  belongs_to :user
  has_many :menu_meals
  has_many :menus, :through => :menu_meals

  def slug
    slug_name = self.name.downcase.split(" ")
    slug_name.join("-")
  end

  def self.find_by_slug(slug_name)
    Meal.all.find{|meal| meal.slug == slug_name}
  end
end
