class Product
  attr_accessor :code, :name, :price

  def initialize(**args)
    @code = args.fetch(:code, "")
    @name = args.fetch(:name, "")
    @price = args.fetch(:price, 0)
  end
end
