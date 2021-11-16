require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it 'should save a new product if all validations are true' do
      @category = Category.new(name: "test")
      @product = Product.new(name: "Crabby Bearded Dragon Costume", price_cents: 3500, quantity: 17, category: @category)
      @product.valid?
      expect(@product.errors.full_messages).not_to include("Field can't be blank")
    end
  
    it 'should not save a new product if name field is empty' do
      @category = Category.new(name: "test")
      @product = Product.new(name: nil, price_cents: 3500, quantity: 17, category: @category)
      @product.valid?
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should not save a new product if quantity field is empty' do
      @category = Category.new(name: "test")
      @product = Product.new(name: "Crabby Bearded Dragon Costume", price_cents: 3500, quantity: nil, category: @category)
      @product.valid?
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should not save a new product if price field is empty' do
      @category = Category.new(name: "test")
      @product = Product.new(name: "Crabby Bearded Dragon Costume", price_cents: nil, quantity: 17, category: @category)
      @product.valid?
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'should not save a new product if category is empty' do
      @category = Category.new(name: "test")
      @product = Product.new(name: "Crabby Bearded Dragon Costume", price_cents: 3500, quantity: 17, category: nil)
      @product.valid?
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

  end
end
