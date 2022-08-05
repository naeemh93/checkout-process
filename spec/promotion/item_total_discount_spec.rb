require_relative "../spec_helper"
require_relative '../../lib/item_total_discount'
require_relative '../../lib/checkout'
require_relative '../../lib/product'

describe ItemTotalDiscount do
  context "when order total is greater than the discount total" do
    it "calculates discount based on item total" do
      promotion = ItemTotalDiscount.new(total: 60, percent: 10)
      checkout = Checkout.new(promotion)
      checkout.scan(Product.new(name: "foo", price: 9.25, code: "001"))
      checkout.scan(Product.new(name: "foo", price: 45.00, code: "002"))
      checkout.scan(Product.new(name: "foo", price: 19.95, code: "003"))
      checkout.scan(Product.new(name: "foo", price: 19.95, code: "003"))
      expect(checkout.total).to eq("£84.74")
    end
  end

  context "when order total is equal to the discount total" do
    it "just returns items total without discount" do
      promotion = ItemTotalDiscount.new(total: 30, percent: 10)
      checkout = Checkout.new(promotion)
      checkout.scan(Product.new(name: "foo", price: 20, code: "001"))
      checkout.scan(Product.new(name: "foo", price: 10, code: "002"))
      expect(checkout.total).to eq("£30.0")
    end
  end

  context "when order total is less than the discount total" do
    it "just returns items total without discount" do
      promotion = ItemTotalDiscount.new(total: 30, percent: 10)
      checkout = Checkout.new(promotion)
      checkout.scan(Product.new(name: "foo", price: 20, code: "001"))
      checkout.scan(Product.new(name: "foo", price: 5, code: "002"))
      expect(checkout.total).to eq("£25.0")
    end
  end
end
