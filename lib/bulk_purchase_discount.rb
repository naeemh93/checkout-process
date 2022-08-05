require 'pry'
class BulkPurchaseDiscount
    def initialize(**args)
      @product = args.fetch(:product)
      @purchases = args.fetch(:purchases)
      @price = args.fetch(:price, 0)

      if @product.nil? || @product == 0
        raise ArgumentError, "Product cannot be nil or zero" 
      end

      if @price.zero?
        raise ArgumentError, "price cannot be zero"
      end
    end

    def eligible?(order, options = {})
      return false if @purchases.zero?
      @order_purchases = order.items.select { |p| p.code == @product.code }
      true unless @order_purchases.nil? || @order_purchases.count < @purchases
    end

    def perform(order)
      return order.total unless eligible?(order)
      update_price
      recalculate_total(order)

    end

    private

    def update_price
      @order_purchases.each do |p|
        p.price = @price
      end
    end

    def recalculate_total(order)
      (order.items - @order_purchases).map(&:price).sum + @order_purchases.map(&:price).sum
    end
  end
