require_relative 'order'
require 'pry'
class Checkout
  attr_reader :order

  def initialize(*promotions)
    @promotions = promotions || []
    @order = Order.new
    @total = 0
  end

  def scan(item)
    @order << item
    @total = @order.total
  end

  def total
    recalculate!
    @total = @total.to_f.round(2)
    format_price(@total)
  end

  def format_price(total)
    "£#{total}"
  end

  def recalculate!
    return @total if @promotions.empty?

    @promotions.each do |promotion|
      @order.total = promotion.perform(@order)
    end
    @total = @order.total
  end
end
