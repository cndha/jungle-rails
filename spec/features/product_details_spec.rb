require 'rails_helper'

RSpec.feature "Product Details", type: :feature, js: true do
  before :each do 
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "Visitor at home page, clicks on product and navigates to product details" do
    visit root_path
    # first(".product h4").click #product.name in h4 element navigates to product details
    first(".product img").click #product thumbnail navigates to product details
    #first(".product").click_link("Details") #Details button navigates to product details
    
    expect(page).to have_content 'Description'
    
    # save_screenshot
  end

end
