require_relative "../spec_helper"
require_relative '../../lib/bulk_purchase_discount'

describe BulkPurchaseDiscount do
  context "with bulk purchases" do
    it "just returns items total without discount" do
      product = Product.new(name: "Lavender heart", price: 9.25, code: "001")
      product1 = Product.new(name: "Personalised cufflinks", price: 19.95, code: "002")
      promotion = BulkPurchaseDiscount.new(
        purchases: 2,
        product: product,
        price: 8.50,
      )

      checkout = Checkout.new(promotion)
      checkout.scan(product)
      checkout.scan(product)
      checkout.scan(product1)
      expect(checkout.total).to eq("£36.95")
    end
  end

  context "with price" do
    it "updates purchases price" do
      product = Product.new(name: "foo", price: 20, code: "001")
      promotion = BulkPurchaseDiscount.new(
        purchases: 2,
        product: product,
        price: 3.99,
      )

      checkout = Checkout.new(promotion)
      checkout.scan(product)
      checkout.scan(product)
      checkout.scan(Product.new(name: "bar", price: 10, code: "002"))

      expect(checkout.total).to eq("£17.98")
    end
  end

  context "with zero price and percent" do
    it "raises an ArgumentError" do
      promotion = -> () {
        BulkPurchaseDiscount.new(
          purchases: 2,
          product: nil,
          price: 0
        )
      }

      expect { promotion.() }.to raise_error(ArgumentError)
    end
  end

  context "with zero or nil product" do
    it "raises an ArgumentError" do
      promotion = -> () {
        BulkPurchaseDiscount.new(
          purchases: 2,
          product: nil,
          price: 10,
        )
      }

      expect { promotion.() }.to raise_error(ArgumentError)
    end
  end
end
