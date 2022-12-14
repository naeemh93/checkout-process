require_relative '../lib/product'

RSpec.describe Product do
  describe '#product' do
  before do
    @product = Product.new(code:'code-product', name:'name-product',price: 99.99)
  end

  it { expect(@product.code).to eq('code-product') }
  it { expect(@product.name).to eq('name-product') }
  it { expect(@product.price).to eq(99.99) }
  end
end
