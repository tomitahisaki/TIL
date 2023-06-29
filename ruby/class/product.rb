class Product
  attr_reader :grocery,
              :price

  def initialize(grocery, price)
    @grocery = grocery
    @price = price
  end

  # Objectクラスにもあるが、オーバーライドさせる
  # 人の目にはわからない文字列に変換されるので
  def to_s
    "grocery: #{grocery}, price: #{price}円"
  end
end

# product = Product.new("rice", 1000)
# product.grocery => "rice"
# product.price => 1000