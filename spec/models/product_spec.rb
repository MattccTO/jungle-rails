require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # Initialize a valid product for use in validation testing
    cat1 = Category.new(name: 'Ethereal')
    product = cat1.products.new
    product.name = 'Limited Release Test Kit'
    product.price = 999.99
    product.quantity = 1

    it 'should be a valid product' do
      expect(product).to be_valid
    end

    it 'should not be valid without a name' do
      product.name = nil
      expect(product).to_not be_valid
    end

    it 'should not be valid without a price' do
      product.price = nil
      expect(product).to_not be_valid
    end

    it 'should not be valid without a qty' do
      product.quantity = nil
      expect(product).to_not be_valid
    end

    it 'should not be valid without a category' do
      product.category = nil
      expect(product).to_not be_valid
    end
  end
end
