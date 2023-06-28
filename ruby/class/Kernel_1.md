# インスタンス変数

@から始まる変数

下記のコードは2種類の@変数が存在している。

インスタンス変数とクラスインスタンス変数

```ruby
class Product
	# クラスインスタンス変数
	@name = "goods"
	
	# クラスインスタンス変数
	def self.name
		@name
	end
	
	# インスタンス変数
	def initialize(name)
		@name = name
	end
	
	# attr_readerをつかわず、定義する
	# インスタンス変数
	def name
		@name
	end
end

Product.name => "goods"

product = Product.new("Drink")
product.name => "Drink"
product.name => "goods"
```

# クラス変数

@@some_valueのように変数名の最初の@@を重ねる

```ruby
class Product
	@@name = "product"

	def self.name
		@@name
	end

	def initilize(name)
		@@name = name
	end
	
	def name 
		@@name
	end
end

class DVD < Product
	@@name = "DVD"

	def self.name
		@@name
	end

	def upcase_name
		@@name.upcase
	end
end

# DVDクラスを定義したタイミングで@@name="DVD"に変更される
Product.name => "DVD"
DVD.name => "DVD"

product = Product.new("film")
product.name = "film"

# Product.newのタイミングで@@nameが"film"に変更される
Product.name => "film"
DVD.name => "film"

dvd = DVD.new("great film")
dvd.name => "great film"
dvd.upcase_name => "GREAT FILM"

# DVD.newのタイミングで@@nameが"great film"に変更される
product.name => "great film"
Product.name => "great film"
DVD.name => "great film"
```

# グローバル変数と組み込み変数

$ から始まる変数

グローバル変数は、クラスの内部、外部問わず、プログラムのどこからでも参照可能

```ruby
$global_name = "great program"

class Program
	def initilize(name)
		$global_name = name
	end

	def self.name
		$global_name
	end

	def name
		$global_name
	end
end

# $global_nameにはすでに名前が代入されている
Program.name => "great program"

program = Program.new("amazing program")
program.name = "amazing program"

# Program.newのタイミングで$global_nameが"amazing name"にへんこうされる
Program.name => "amazing program"
$global_name => "amazing program"
```

# エイリアスメソッド

## メソッドの定義

標準ライブラリでは、別の名前でも同じ動作をするメソッドが存在している

```ruby
s = "hello"
s.length => 5
s.size => 5
```

エイリアスメソッドを独自作成したクラスで定義できる

`alias 新しい名前 元の名前`

```ruby
class User
	def hello
		"hello"
	end
	
	# helloメソッドのエイリアスメソッドとしてgreetingを定義する
	alias greeting hello 
end

user = User.new
user.hello => "hello"
user.greeting => "hello"
```

## メソッドの削除

メソッドの定義のあとから削除できる

`undef 削除する名前`　

```ruby
class User
	# freezeメソッドの定義を削除する (Objectクラスのメソッド削除)
	undef freeze
end
user = User.new
# freezeメソッドを呼び出すとエラーになる
user.freeze => NoMethodError: undefined method 'freeze'
```

## ネストしたクラスの定義

クラスの内部にクラスを定義できる

`外側クラス::内側クラス`

```ruby
class User
	class BloodType
		attr_reader :type
		
		def initialize(type)
			@type = type
		end
	end
end

blood_type = User::Bloodtype.new("B")
blood_type.type => B
```

名前空間(ネームスペース)を作る場合に使う

ただし、**名前空間を作る場合はクラスよりもモジュールが使われることが多い**

### 演算子の挙動を独自に再定義する

Rubyでは、=終わるメソッドを定義できる

```ruby
class User
	# =で終わるメソッドを定義
	def name=(value)
		@name = value
	end
end

user = User.new
# 変数に代入する形で name=メソッドを呼び出す
user.name = "alice"
```