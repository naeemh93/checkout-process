class Order
  attr_accessor :items, :total

  def initialize
    @items = []
    @total = 0
  end

  def <<(item)
    @items << item
    @total += item.price
  end
end
