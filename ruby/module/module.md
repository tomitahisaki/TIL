# モジュール

# モジュールとは

継承をつかわずに、クラスにインスタンスメソッドを追加する　または上書きする

複数のクラスに対して共通の特異メソッドを追加する

クラス名や定数名の衝突を防ぐために名前空間を作る

シングルトンオブジェクトのように設定値を保持する

## モジュールの定義

クラスの作り方と同じように作成できる

ただし、注意点がある

- モジュールからインスタンスを作成できない
- 他のモジュールやクラスを継承できない

```ruby
module Greeter
	def greet
		'hello'
	end
end
```

## モジュールのミックスイン

Rubyでは単一継承を採用している。

→１つのクラスは１つのスーパークラスしかもてない

複数のクラスにまたがる機能がほしい場合はどうしたら良いのか

→各クラスの重複するメソッドを定義する必要がある。

下記のように各クラスで使うために同じメソッドを定義する

```ruby
class Product
	def title
		log 'title is called'
				' goiod movie'
	end
	
	private
	def log(text)
		puts "[LOG]#{text}"
	end
end

class User
  def name
	log 'name is called'
			'alice'
	end

	private
	def log(text)
		puts "[LOG]#{text}
	end
end
```

### メソッドを共通化させる

moduleを使ってメソッドを共通化させて、クラスにincludeさせることでインスタンスメソッドとして呼び出せる

→重複したメソッドをまとめることができる

```ruby
# モジュールで、共通化させたいメソッドを定義
Module Logggable
	def log(text)
		puts "[LOG]#{text}"
	end
end

class Prduct
	include Loggable

	def title
	log 'title is called'
			' goiod movie'
	end
end

class User
	include Loggable

	def title
	log 'title is called'
			' goiod movie'
	end
end
	
```

- includeのように機能を追加することを　`ミックスイン` と呼ぶ
- `ミックスイン` をつかうことで、多重継承に似た仕組みを生み出している

### モジュールをextendする

ミックスインの方法としてextendする方法もある

extendすることで、クラスメソッド(特異メソッド)にすることができる

# 例題

配列やハッシュがdeep_freezeメソッドを使ってfreezeされるようにつくる

- 配列やハッシュ自体が、freezeされていることの確認
- 配列やハッシュの中身がfreezeされていることの確認(keyやvalueも確認する)

```ruby
class Product
	GROCERIES = deep_freeze(['Japan', 'US', 'India'])
end

class Bank
	CURRENCIESD = deep_freeze({ 'Japan' => 'yen', 'US' => 'dollar', 'India' => 'rupee' })
end

Product::GROCERIES.frozen? => true
Product::GROCERIES.all?{ |country| country.frozen? } => true

Bank::CURRENCIES.frozen? => true
Bank::CURRENSIES.all?{|key, value| key.frozen?　&& value.frozen? } => true
```

## モジュールの作成

```ruby
Module DeepFreezable
	def deep_freeze(array_or_hash)
	
	end
end
```

## クラスの作成

moduleを読み込む時は、extendとする

→クラス直下での読み込みなので、クラスメソッドになる

```ruby
class Product
	extend DeepFreezable

	GROCERIES = deep_freeze(['Japan', 'US', 'India'])
end	
```

```ruby
class Bank
	extend DeepFreezable
	
	CURRENCIESD = deep_freeze({ 'Japan' => 'yen', 'US' => 'dollar', 'India' => 'rupee' }CURRENCIESD = deep_freeze({ 'Japan' => 'yen', 'US' => 'dollar', 'India' => 'rupee' }
end
```

## 実装

テスト実装

```ruby
require 'minitest/autorun'
require './lib/product'
require './lib/bank'

class DeepFreezableTest < Minitest::Test
  def test_deep_freeze_to_array
    # 配列の値を確認
    assert_equal  ['Japan','US','India'], Product::COUNTRIES
    # 配列がfreezeしているか確認
    assert  Product::COUNTRIES.frozen?
    # 配列の各要素がfreezeしているか確認
    assert  Product::COUNTRIES.all? {|country| country.frozen? }
  end

  def test_deep_freeze_to_hash
    # ハッシュの値を確認
    assert_equal(
        { 'Japan' => 'yen', 'US' => 'dollar', 'India' => 'rupee' },
        Bank::CURRENCIES
      )
    # ハッシュがfreezeしているか確認
    assert Bank::CURRENCIES.frozen?
    # ハッシュのkeyとvalueがfreezeしているか確認
    assert Bank::CURRENCIES.all? {|key, value| key.frozen? && value.frozen? }
  end
end
```

モジュール実装　

```ruby
module DeepFreezable
  def deep_freeze(array_or_hash)
    # 配列とハッシュのfreezeをする
    case array_or_hash
    when Array
      array_or_hash.each do |element|
        element.freeze
      end
    when Hash
      array_or_hash.each do |key, value|
        key.freeze && value.freeze
      end
    end
    array_or_hash.freeze
  end
end
```

# ミックスイン詳細

モジュールがあるか確認するには？

include?メソッドを使って確認できる

```ruby
class Product
	include Loggable

end

Product.include?(Loggable) => true
```

## メソッドを使うモジュール

モジュールの中で、class内で定義したメソッドを使う

*include先で定義されていることが前提となる

```ruby
module Taggable
	def price_tag
		# priceメソッドは、incluce先で定義されている前提
		"#{price}円"
	end
end

class Product 
	include Taggable

	def price 
		1000
	end
end

product = Product.new
# priceメソッドが使われている前提
product.price_tag => 1000円
```

## Enumerableモジュール

配列やハッシュなどの繰り返し処理ができるクラスにincludeされているモジュ

下記の様にinclude?メソッドを使って、確認できる

```ruby
Array.include?(Enumerable) => true
```

### 代表的なEnumerableモジュールのメソッド

`map` `select` `find` `count` が代表的なメソッドになる

Enumerableモジュールをincludeしているクラスは、上記メソッドを呼び出すことができる

```ruby
[1,2,3].map {|n| n + 10} => [11,12,13]
{a: 1, b: 2, c: 3}.map {|k, v| [k, v+10]} => {a: 11, b: 12, c: 13}
```

## Comparableモジュール　＜＝＞演算子

比較演算を可能にするモジュール

モジュールのメソッドを使えるようにするには、include先のクラスで＜＝＞演算子を実装する必要がある

＜＝＞演算子とは、`a <=> b` が次のような実装を返す必要がある

- aがbより大きいなら正の整数
- aとbが等しいなら 0
- aがbより小さいなら負の整数
- aとbが比較できない場合は nil

```ruby
2 <=> 1 => 1
2 <=> 2 => 0
1 <=> 2 => -1
2 <=> 'abc' => nil

'xyz' <=> 'abc' => 1
'abc' <=> 'abc' => 0
'abc' <=> 'xyz' => -1
'abc' <=> 123 => nil
```

もちろん、比較演算子を使って、大小関係を判定できる

Comparableモジュールを使って、Tempoクラスにincludeさせて、使ってみる

```ruby
class Tempo 
	include Comparable

	attr_reader :bpm

	#bpmは音楽の速さを表す単位
	def initialize(bpm)
		@bpm = bpm
	end

	def <=>(other)
		if other.is_a?(Tempo)
			# bpm同士を比較した結果を返す
			bpm <=> other.bpm
		else
			nil
		end

		def inspect
			"{bpm}bpm"
		end
	end		

t_120 = Tempo.new(120) =>　120bpm
t_150 = Tempo.new(150) =>  150bpm

t_120 < t_150 => true
```

## Kernelモジュール

代表的なメソッドは

`puts` `p` `print` `require` `loop` になる

**********なぜ、 メソッドをどこでも使えているのか？**********

Objectクラスが Kernelモジュールを includeしているから

```ruby
Object.include?(Kernel) => true
```

### トップレベルはmainというObject

irbを起動したときに、どこにいるのか？

```ruby
irb起動
self => main
self.class => Object
```

Rubyはすべてがオブジェクトであることを気をつける

→モジュールやクラスもオブジェクトということ！！