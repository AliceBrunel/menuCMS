class User < ActiveRecord::Base
  has_many :menus
  has_many :meals
  has_secure_password
end
