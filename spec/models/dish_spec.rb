require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
  end
  describe "relationships" do
    it {should belong_to :chef}
    it {should have_many :ingredients}
    it {should have_many(:ingredients).through(:dish_ingredients)}
  end

  it "should find the total calories of all ingredients" do
    ramsey = Chef.create(name: "Gordon Ramsey")
    ingredient1 = Ingredient.create(name: "Spagetti", calories: 221)
    ingredient2 = Ingredient.create(name: "Meatball", calories: 284)
    dish_1 = ramsey.dishes.create(name: "Spagetti and Meatballs", description: "Lovely Spagetti and meatballs")
    DishIngredient.create(dish_id: dish_1.id, ingredient_id: ingredient1.id)
    DishIngredient.create(dish_id: dish_1.id, ingredient_id: ingredient2.id)
    
    expect(dish_1.total_calories).to eq(505)
  end
end
