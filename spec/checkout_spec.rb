require_relative '../lib/checkout'
require_relative '../lib/bulk_purchase_discount'
require_relative '../lib/item_total_discount'

require 'pry'

RSpec.describe Checkout do
  product = Product.new(name: "Lavender heart", price: 9.25, code: "001")
  product1 = Product.new(name: "Personalised cufflinks", price: 45.00, code: "002")
  product2 = Product.new(name: "Kids T-shirt", price: 19.95, code: "003")
  promotion1 = BulkPurchaseDiscount.new(purchases: 2, product: product, price: 8.50)
  promotion2 = ItemTotalDiscount.new(total: 60, percent: 10)

  let(:checkout_object) { described_class.new(promotion1,promotion2) }

  describe "#total" do
    context "Example1" do
      before do
        checkout_object
        checkout_object.scan(product)
        checkout_object.scan(product1)
        checkout_object.scan(product)
        checkout_object.scan(product2)
      end

      it { expect(checkout_object.total).to eq("£73.76") }
    end

    context "Example2" do
      before do
        product1 = Product.new(name: "Lavender heart", price: 9.25, code: "001")
        product2 = Product.new(name: "Personalised cufflinks", price: 45.00, code: "002")
        product3 = Product.new(name: "Kids T-shirt", price: 19.95, code: "003")
        promotion2 = BulkPurchaseDiscount.new(purchases: 2, product: product1, price: 8.50)
        promotion3 = ItemTotalDiscount.new(total: 60, percent: 10)
        checkout_object1 = Checkout.new(promotion2,promotion3)
        checkout_object1.scan(product1)
        checkout_object1.scan(product2)
        checkout_object1.scan(product3)
        @total = checkout_object1.total

      end

      it "should only encounter promotion 2" do
        expect(@total).to eq("£66.78")
      end
    end


  end
end
