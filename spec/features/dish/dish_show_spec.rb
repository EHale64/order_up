require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "When I visit a dish's show page" do
    before(:each) do
      @ramsey = Chef.create(name: "Gordon Ramsey")
      @ingredient1 = Ingredient.create(name: "Spagetti", calories: 221)
      @ingredient2 = Ingredient.create(name: "Meatball", calories: 284)
      @dish_1 = @ramsey.dishes.create(name: "Spagetti and Meatballs", description: "Lovely Spagetti and meatballs")
      DishIngredient.create(dish_id: @dish_1.id, ingredient_id: @ingredient1.id)
      DishIngredient.create(dish_id: @dish_1.id, ingredient_id: @ingredient2.id)
    end
    it "I see a list of ingredients for that dish and the chef's name" do

      visit "/dishes/#{@dish_1.id}"

      within '.ingredients' do
        expect(page).to have_content(@ingredient1.name)
        expect(page).to have_content(@ingredient2.name)
      end
      expect(page).to have_content(@ramsey.name)
    end

    it "@dish.chef.name" do

      visit "/dishes/#{@dish_1.id}"

      expect(page).to have_content("Total calories: 505")
    end
  end
end
