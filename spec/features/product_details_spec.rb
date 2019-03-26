require 'rails_helper'

RSpec.feature "Visitor navigates from home page to product page", type: :feature, js: true do

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

  scenario "They see the product page for the item selected" do
    selected_product = Product.find(1)
    # ACT
    visit root_path
    find("article.id_#{selected_product.id} a.pull-right").click


    # DEBUG / VERIFY
    sleep(1.seconds)
    save_screenshot
    expect(page).to have_css 'article.product-detail'
    expect(page).to have_content selected_product.description
    # pp page.html
  end
end
