require 'rails_helper'

RSpec.feature "Visitor click add to cart button", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "The item is added to cart" do
    selected_product = Product.find(1)
    # ACT
    visit root_path
    find("article.id_#{selected_product.id} button.add").click


    # DEBUG / VERIFY
    within('nav') { expect(page).to have_content('My Cart (1)') }
    save_screenshot
    # pp page.html
  end
end
