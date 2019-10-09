class Menu < ActiveRecord::Base
  belongs_to :user
  has_many :menu_meals
  has_many :meals, :through => :menu_meals

  def slug
    slug_name = self.name.downcase.split(" ")
    slug_name.join("-")
  end

  def self.find_by_slug(slug_name)
    Menu.all.find{|menu| menu.slug == slug_name}
  end
end
