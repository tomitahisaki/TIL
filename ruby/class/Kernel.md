# 継承

オブジェクト指向のプログラミングでは、継承が重要なポイントの一つ

# クラスの継承

ruby自体に標準ライブラリの継承関係が存在している

```ruby
BasicObject #頂点

Object #継承

String, Numeric, Array, Hash # Objectを継承

      Integer, Float, Rational, Complex # Numericを継承
```

## Productクラスと継承したDrinkクラスを作る

まずは、親クラスとなるProductクラスを作成する

initializeメソッドは、groceryとpriceの引数を指定し、initializeメソッドで値を入れられるようにしておく。

重要なポイントは、`attr_reader`を指定しないと、**drink.rb(Drinkクラス)を実行するときにgroceryとpiriceを呼び出せなくなるので注意**！！！

product.rb

```ruby
class Product
  attr_reader :grocery,
              :price

  def initialize(grocery, price)
    @grocery = grocery
    @price = price
  end
end

# product = Product.new("rice", 1000)
# product.grocery => "rice"
# product.price => 1000
```

drink.rb

```ruby
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
end
```

## メソッドのオーバーライド

サブクラスでスーパークラスと同名のメソッドを使うことで、スーパークラスのメソッドを上書きすることができる

### product.rb

```ruby
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
# product.price
```

drink.rb

```ruby
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
```

## クラスメソッドも継承される

```ruby
class Foo
	def sel.foo
		"クラスメソッド"
	end
end

class Buzz < Foo
end

Foo.foo => "クラスメソッド"
Buzz.foo => "クラスメソッド"
 
```

## メソッドの公開レベル

公開レベルが存在している

- public
- protected
- private

### publicメソッド

クラスの外部からでも呼び出せるメソッド　

initializeメソッド以外は、デフォルトがpublicメソッドになっている

```ruby
class User
	def greet
		"hi How are you ?"
	end
end

user = User.new
user.greet => "hi How are you?"
```

### privateメソッド

クラスの外部から呼び出し不可。　クラスの内部でのみ使えるメソッド

private配下に置くことで、クラス内部のみに指定できる

```ruby
class User

	private
	
	def greet
		"hi How are you?"
	end
end

user = User.new
# privateメソッドなので、呼び出せない
user.greet => NoMethodError private method 'greet' 
```

************************************************************************************************厳密には、レシーバを使って呼べないメソッド************************************************************************************************

selfをつかって、クラス内部のメソッドを呼べますが、self自体がレシーバの役割となるため、

下記の様に書いても、エラーが発生する

```ruby
class User
	def greet
		"hi I am #{self.name}"
	end

	private
	
	def name
		"taro"
	end
end

user = User.new
#  self自体が、レシーバとなるので、エラー
user.greet　=> NoMethodError private method 'greet'
```

selfなどのレシーバを使わなければ呼び出せる

privateメソッドを直接呼び出せないが、publicメソッド内部で使って、呼び出している。

```ruby
class User
	def greet
		"hi I am #{name}"
	end

	private
	
	def name
		"taro"
	end
end

user = User.new
user.greet => "hi I am taro"
```

### privateメソッドはサブクラスでも呼べる

クラスの内部だけでなく、サブクラス(継承したクラス) からでもスーパークラスのprivateメソッドを呼ぶことができる！

********************************************************************************************************************************privateメソッドもオーバライドされてしまうことは注意すること********************************************************************************************************************************

```ruby
class Product

	private

	def name 
		"Rice"
	end
end
```

```ruby
class Grocery < Product
	
	def to_s
		"grocery: #{name}"
	end

	private

	# 下記のprivateメソッドを書くと、出力がオーバライドされてしまう
	def name
		"Noodle"
	end
end

grocery = Grocery.new
# 内部でスーパークラスのprivateメソッド呼んでいる(エラーにならない)
grocery.to_s => "grocery: Rice"
```

### privateメソッドの定義

- クラスメソッドをprivateにしたい場合

privateキーワードにクラスメソッドを書いても、無効になる。

class << selfのようにかくことで、クラスメソッドでもprivateにすることが可能

```ruby
class User
	class << self

	private 
	
	def greet
		"hi How R U ? "
	end
end

user.greet => "hi How R U ?"
```

- privateメソッドから先に定義する場合(みたことない)

publicを明記する必要がある

```ruby
class User
	private

	def sample
	end

	public
	
	def foo
	end
end
```

- 公開レベルを後で変更する(みたことない)

privateキーワードに既存のメソッドを引数で渡すことで可能になる。

************ただし、privateキーワードの下のメソッドはpublicになるので、注意！！！************

```ruby
class User
	
	def buzz
	end
	
	def fizz
	end

	private :foo
	
	def foo
	end
end

```

### protectedメソッド

レシーバ付きで呼び出せるメソッドになる(privateメソッドと異なる部分)

```ruby
class User
	#nameのみ　公開されている
	#weightは、外部公開しない
	attr_reader :name

	def initialize(name, weight)
		@name = name
		@weight = weight
	end
end
```

しかし、weightを比較したい

下記のようなコードだと、`other_user.weight`は取得できない

```ruby
class User
	attr_reader :name

	def heavier_than?(other_user)
		other_user.weight < @weight
	end
end

alice = User.new("alice", 50)
bob = User.new("bob", 70)
alice.heavier_than(bob)
=> NoMethodError undefined error 'weight'
```

publicメソッドにすると、取得できるが、外部から全て取得できる

privateメソッドになると、レシーバ付きで呼び出せないので、`other_user.weight` みたいなメソッドで呼び出せない

外部に公開したくないが、同じクラスやサブクラスの中であれば、レシーバ付きで呼び出せる

```ruby
class User
	attr_reader :name
	
	def heavier_than?(other_user)
		other_user.weight < @weight
	end

	protected
	
	def weight
		@weight
	end
end

alice = User.new("alice", 50)
taro = User.new("taro", 60)
alice.heavier_than?(bob)
=> false
bob.heavier_than?(alice)
=> true

# クラスの外では、weightを呼べない
alice.weight
=> NoMethodError protected method "weight"
```

protectedメソッドも、後付で変更可能

```ruby
class User
	# 最初 publicメソッドとしてweightを定義する
	attr_reader :name, :weight
	
	# weightのみ、あとからprotectedメソッドに変更することができる
	protected :weight
```

## 定数について

クラスの外部から定数を参照

```ruby
class Product
	DEFAULT_PRICE :0
end

Product::DEFAULT_PRICE  => 0
```

外部から参照されたくない場合

```ruby
class Product 
	private_constant :DEFAULT_PRICE
end

Product::DEFAULT_PRICE => nameError private constant Product::DEFAULT::PRICE
```

さらに、メソッド内部でも作成できない

構文エラーとなってしまう。

```ruby
class Product 
	def foo
		DEFAULT_PRICE = 0
	end
end

# SyntaxError: dynamic constant assignment
# 	DEFAULT_PRICE = 0
```

## 定数の再代入

Rubyについては、定数の再代入が可能です。

```ruby
class Product
	DEFAULT_PRICE = 0
	DEFAULT_PRICE = 100
end
=> warning: already initialized constant Product::DEFAULT_PRICE

# 再代入後の値が入る
Product::DEFAULT_PRICE => 100

# クラスの外部からでも再代入可能です
Product::DEFAULT_PRICE = 300
=> warning: aleady initialized constant Product::DEFAULT_PRICE

# クラス外部から再代入後の値が返る
Product::DEFAULT_PRICE => 300
```

警告が表示されるものの、再代入自体は成功してしまう。

クラス外部から、再代入を防ぐ場合はクラスをfreeze(凍結)する

```ruby
Product.freeze

Product::DEFAULT_PRICE = 1000
=> RuntimeError: can't modify frozen
```

普通はやらないが、クラス内でfreeze呼んでも良いが。。。

メソッドの定義もできなくなってしまう。

```ruby
class Product
	DEFAULT_PRICE = 0

	freeze
	DEFAULT_PRICE = 1000
  # RuntimeError が発生する
end

```

## ミュータブルなオブジェクトに注意

文字列、配列、ハッシュなどの値をミュータブルなオブジェクトと呼ぶ

再代入をしなくても、ミュータブルなオブジェクトであれば、定数の値を変更可能

下記のように定数を変更してしまう　

```ruby
class Product
	NAME = "taro"
	SOME_NAMES = ["foo", "buz", "fizzbuzz"]
	SOME_PRICE = { "Foo" => 1000, "Bar" => 2000, "Baz" => 3000}
end

# 文字列を破壊的に大文字へ変更する
Product::NAME.update!
Product::NAME = "TARO"

# 配列に新しい要素を追加する
Product::SOME_NAMES << "hoge"
Product::SOME_NAMES => ["foo", "buz", "fizzbuzz", "hoge"]

# ハッシュに新しいキーと値を追加する
Product::SOME_PRICE["Fiz"] = 4000
Product::SOME_PRICE => { "Foo" => 1000, "Bar" => 2000, "Baz" => 3000, "Fiz" => 4000}
```

定数の値を変数にいれてしまうと、気づきにくくなる

```ruby
class Product
	SOME_NAMES = ["foo", "bar", "baz"]

	def self.names_without_foo(names = SOME_NAMES)
		# namesがデフォだと以下のコードは定数のSOME_NAMESを破壊的に変更している
		names.delete("foo")
		names
	end
end

Product.names_without_foo => ["bar", "baz"]

#　定数の中身が変わっている
Product::SOME_NAMES => ["bar", "baz"]
```

定数の値自体を凍結させることで、安易な変更ができないようにする

```ruby
class Product
	SOME_NAMES = ["foo", "bar", "baz"].freeze

	def self.names_without_foo(names = SOME_NAMES)
		# freezeしている配列には、破壊的変更ができない
		names.delete("foo")
		names
	end
end

Product.names_without_foo => RuntimeError: can't modify frozen Array
```

freezeしても、各要素に対しての変更は可能

```ruby
Product::SOME_NAMES[0].upcase!
=> ["FOO","bar","baz"]
```

これを防ぐには、
```ruby
# 各要素にfreezeを使うか
SOME_NAMES = ["foo".freeze, "bar".freeze, "baz".freeze].freeze

# mapメソッドをつかう
SOME_NAMES = ["foo", "bar", "baz"].map(&:freeze).freeze
```