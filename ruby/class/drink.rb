require "./product.rb"

class Drink < Product
  attr_reader :quality,
              :weight

  def initialize(grocery, price, quality, weight)
    # スーパークラス存在している(Productクラス)
    # @grocery = grocery
    # @price = price

    # スーパークラスのinitializeメソッドを引き継ぐ
    super(grocery, price)
    @quality = quality
    @weight = weight
  end

  # drinkクラスでもつ変数も入れるため Productクラスのto_sメソッドをオーバーライドさせる
  def to_s
    "#{super}, quality: #{quality}, weight: #{weight}円"
  end
end