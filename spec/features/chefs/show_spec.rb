require "rails_helper"

RSpec.describe "When I visit a chef's show page" do
  before(:each) do
    @ramsey = Chef.create(name: "Gordon Ramsey")
    @ingredient1 = Ingredient.create(name: "Spagetti", calories: 221)
    @ingredient2 = Ingredient.create(name: "Meatball", calories: 284)
    @dish_1 = @ramsey.dishes.create(name: "Spagetti and Meatballs", description: "Lovely Spagetti and meatballs")
    DishIngredient.create(dish_id: @dish_1.id, ingredient_id: @ingredient1.id)
    DishIngredient.create(dish_id: @dish_1.id, ingredient_id: @ingredient2.id)
  end

  it "I see the name of that chef and I see a link to view a list of all ingredients that this chef uses in their dishes" do

    visit "/chefs/#{@ramsey.id}"

    expect(page).to have_content(@ramsey.name)
    expect(page).to have_link("View Chef's Ingredients")
  end

  it "When I click on that link I'm taken to a chef's ingredient index page and I can see a unique list of names of all the ingredients that this chef uses" do

    visit "/chefs/#{@ramsey.id}"

    click_link "View Chef's Ingredients"
    
    expect(current_path).to eq("/#{@ramsey.dishes.igredients}/")
  end
end
