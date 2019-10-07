class CreateMenuMeals < ActiveRecord::Migration[5.2]
  def change
    create_table :menu_meals do |t|
      t.integer :menu_id
      t.integer :meal_id
    end
  end
end
