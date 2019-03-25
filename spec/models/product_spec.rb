require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # Initialize a valid product for use in validation testing
    cat1 = Category.new(name: 'Ethereal')
    subject {
      cat1.products.new(name: 'Limited Release Test Kit', price: 999.99, quantity: 1)
    }

    it 'should be a valid product' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      subject.save
      expect(subject.errors.full_messages[0]).to eql("Name can't be blank")
    end

    it 'is not valid without a price' do
      @product = cat1.products.new(name: 'testerino', quantity: 42)
      @product.save
      missing_price = false
      @product.errors.full_messages.each do |err|
        if err == "Price can't be blank" then missing_price = true end
      end
      expect(missing_price).to be true
    end

    it 'is not valid without a qty' do
      subject.quantity = nil
      subject.save
      expect(subject.errors.full_messages[0]).to eql("Quantity can't be blank")
    end

    it 'is not valid without a category' do
      subject.category = nil
      subject.save
      expect(subject.errors.full_messages[0]).to eql("Category can't be blank")
    end
  end
end
