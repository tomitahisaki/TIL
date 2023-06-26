class Product
  attr_reader :grocery,
              :price

  def initialize(grocery, price)
    @grocery = grocery
    @price = price
  end

  # 金額を出力するメソッド
  def self.format_price(price)
    "$#{price}"
  end

  def to_s
    format_price = Product.format_price(price)
    "grocery: #{grocery}, price: #{format_price}"
  end
end