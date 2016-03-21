require 'byebug'
require 'spec_helper'
describe Product do
  it 'Test create new product' do
    product = Product.new(name: "Test", category_id: 10, price: 10, description: "test", image: "test image")
    product.save
    expect(product.search("est").name).to eq("test")
  end
end