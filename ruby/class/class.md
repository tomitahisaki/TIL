# クラスについて

## irbの立ち上げ方

RubyのIRB（Interactive Ruby）は、Rubyの対話型インタラクティブシェル

```ruby
# irbの起動
$ irb

# 必要なファイルの読み込み
$ require "./class.rb"

#　確認したい処理を打ち込む
$ user = User.new("taro")
```

# クラスという概念について

いわゆるオブジェクト指向の概念であるが、ここは省略しておく

細かい話は、専門書を読むこと

## クラスを使わない場合は？

クラスが使わない場合のユーザーを定義してみる

- ユーザーデータを作成する(users配列に、ハッシュのユーザーデータを入れていく)

```ruby
users = []
users << {first_name: "taro", last_name: "Ruby, age: 20, gender: "male"}
users << {first_name: "sakura", last_name: "Javascript", age: 30, gender: "female"}
```

- データを表示する

```ruby
users.each do |user|
	puts "#氏名：{user[:first_name]} #{user[:last_name]}, 年齢：{user[:age]}, 性別：{user[:gender]"
end
```

- 氏名だけメソッド化にする

```ruby
def full_name(user)
	"#{user[:first_name]} #{user[:last_name]"
end
```

- データ表示方法が少し楽になる

```ruby
users.each do |user|
	puts "#氏名：{full_name(user)}, 年齢：{user[:age]}, 性別：{user[:gender]"}
end
```

### ハッシュ管理の問題点

ハッシュだと、キーをタイポしたときにnilが帰ってくる

```ruby
users[0][:first_name] => "taro"
users[0][:first_**m**ame] => nil　# タイポが分かりづらい
```

さらに、新しくキーを追加できるし、内容も変更できる

「脆くて壊れやすいプログラム」になっている

```ruby
# 勝手に新しいキーを追加できる
users[0][:date_of_birth] => 19901010
# 勝手にfirst_nameを変更できる
users[0][:firts_name] = "jiro"
# ハッシュの中身が変更されてしまう
users[0] => { :first_name => "jiro", :last_name => "Ruby", :age => 20, 
              :gender => "male", :date_of_birth => 19901010 }
```

小さなプログラムでは、ハッシュのままでもよいが。。。

大きなプログラムになると、管理しきれない事になってしまう。。。

## クラス定義をつかってみる

```ruby
class User
	attr_reader :first_name, :last_name, age

	def initialize(first_name, last_name, age)
		@first_name = first_name
		@last_name = last_name
		@age = age
	end
end
```

- データを作成する

```ruby
users = []
users << User.new("taro", "Ruby", 35)
users << User.new("sakura", "Javascript", 40)
```

- 氏名をメソッド化する

```ruby
def full_name(user)
	"#{user[:first_name] #{user[:last_name]}"
end
```

- データを表示する

```ruby
users.each do |user|
	puts "氏名 : #{full_name(user)}, 年齢：#{user[:age]}
end
```

## ハッシュのときとの管理点の違い

クラス導入にすることで、タイポのエラーがなくなる

```ruby
users[0].first_name => "taro"

users[0].first_**m**ama => NoMethodError undefined method 'first_mama'
```

新しく項目を追加できない

```ruby
users[0].country = "japan"
=> NoMethodError undefined method 'country='
```

勝手にfirst_nameの変更ができない

```ruby
users[0].first_name = "jiro"
=> NoMethodError undefined method 'first_name='
```

## メソッドをクラスで管理できる

先程のfull_nameのメソッドをクラス内で定義可能

```ruby
class User
	attr_reader :first_name, :last_name, age

	def initialize(first_name, last_name, age)
		@first_name = first_name
		@last_name = last_name
		@age = age
	end

	def full_name
		"#{first_name} #{last_name}"
	end
end

# データ表示 full_nameを独自のメソッドとして使うことができる
users.each do |user|
	puts "氏名：#{user.full_name}、年齢：#{user.age}"
end
```

## オブジェクト指向の用語

クラス・・・データ型の1種　Rubyではオブジェクトはなんらかのクラスに必ず属している

オブジェクト、インスタンス、レシーバ・・・同じ意味を持つ言葉　「userクラスのオブジェクト」「userクラスのインスタンス」という呼び方をする　レシーバはreceiverという意味からきているので、「メソッドを呼び出された側」という認識で使われる。「introducedメソッドをもつレシーバはuser 」

```ruby
# bob 20才　USというユーザのオブジェクトを作成する
bob = User.new("bob", 20, "US")
# taro 30 japanというユーザのオブジェクトを作成
taro = User.new("taro", 30, "japan")

# introducedメソッドを持つが、データは異なるので、戻り値は違う
bob.introduced => "名前：bob、年齢：20才”
taro.introduced => "名前：taro、年齢：30才"
```

メソッド、メッセージ・・・オブジェクトが持つ動作や振る舞いのこと　他の言語だと、関数やサブルーチン。 　メッセージは、「userというレシーバに対して、introducedというメッセージを送る」という認識　レシーバ・メッセージはsmalltalkという

ステート(状態)・・・オブジェクトごとに保持されるデータ　「信号機オブジェクトの状態は赤」のようなこと　Userクラスがもっている「年齢」「名前」のデータも「Userの状態」となる

プロパティ、アトリビュート(属性)・・・オブジェクトから取得できる値のこと　

# 定義

下記の様にinitializeメソッドを使うことで、オブジェクトを作成できる

今回は、**newメソッドを呼び出すときに、initializeメソッドが呼ばれていることがわかる**

initializeメソッドは、特殊メソッドで外部から呼び出せない。(デフォでprivateメソッド)

```ruby
class User
  def initialize
		puts "initialized"
	end
end

$ irb
irb(main):001:0> require "./class.rb"
=> true
irb(main):002:0> User.new
initialized
=> #<User:0x00000001469b9438>
```

## メソッド定義

クラス内でメソッドを定義することで、インスタンスメソッドになる

そのクラスのインスタンス(オブジェクト)に対して呼び出せるメソッドになる

```ruby
class User
	def hello 
		"hi"
	end
end

user = User.new
user.hello => "hi"
```

## インスタンス変数とアクセサメソッド

インスタンス変数は、クラス内部で共有される変数

先程のファイルに追加してみる

```ruby
class User
	def initialize(name)
		"initialized"
		@name = name
	end

	def introduce 
		puts "hi, I am #{@name}"
	end
end
```

## ローカル変数を使う

名前を逆読みにしてみる

定義する位置は インスタンスメソッドの内部とする ( 上部のhelloメソッドに追加)

```ruby
def hello
	reverse_name = @name.reverse
	puts "hi, I am #{reverse_name}"
end
```

## インスタンス変数を外部から参照するには

インスタンス変数は外部から参照できないので、参照したい場合は専用のメソッドを作る

```ruby
def name
	@name
end

user.name => "taro"
```

## 外部から変更したい場合

アクセサメソッドの場合は、`name=(value)` という形

`user.name = "jiro"` のような形で、名前を変更できる

**NG：`user.name(”jiro”)` のような書き方はできないので注意！！！！**

```ruby
def name=(value)
	@name = value
end

#OK
user.name => "taro"
user.name("jiro")
user.name => "jiro"

#NG 引数のエラーとなる
user.name("jiro")
=> `name': wrong number of arguments (given 0, expected 1) (ArgumentError)
```

メソッドを普通につかうには？

```ruby
def name(value)
	@name = value
end

user.name = > "taro"
user.name("jiro")
user.name => "jiro"
```

## アクセサメソッドを使って簡単に表記してみる

1. **attr_accessor**

nameメソッド・・・外部から参照するためのメソッド

name=(value)メソッド・・・外部から変更するメソッド

が必要ない　定義することなく使える。

```ruby
class User
	attr_accessor :name

	def initialize
		@name = name
	end	
	end

user.name => "taro"  # 名前を参照するメソッド
user.name = "jiro"   # 名前を変更するメソッド
```

1. **attr_reader(読み込み専用)**

nameメソッド・・・外部から参照するメソッド

が必要ない

```ruby
class User
	def initialize
		@name = name
	end
end

user.name => "taro" # 名前を参照するメソッド

user.name = "jiro" 
=> NoMethodError undefined method error 'name='
```

1. **attr_writer(書き込み専用)**

name=(value)メソッド・・・外部から変更するメソッド

が必要ない

```ruby
class User
	def initialize
		@name = name
	end
end

user.name = "jiro" # 名前を変更するメソッド

user.name　 
=> NoMethodError undefined method error 'name'
```

# クラスメソッド

インスタンスメソッドとちがい、クラスに関連するが、インスタンスのデータは使わないメソッド

```ruby
class User
	def initialize
		@name = name
	end

	# selfをつけることで、クラスメソッドになる
	def self.create_users(names)
		names.map do |name|
			User.new(name)
		end
	end

	# インスタンスメソッド
	def hello
		puts "I am #{@name}"
	end

names = {"taro", "jiro", "saburo"]
users = User.create_users(names) # クラスメソッドの呼び出し
users.each {|user| user.hello}
# 配列で格納されているので、順に出力される
```

# 改札機プログラム

テストとプログラムを実装する

１回ずつ、テストを実行していく(エラーが出たときの対処)

## フェーズ１

### gate.rb

1. まずはGateクラスを作成(中身は空)

```ruby
class Gate

end
```

### test_gate.rb

1. Gateオブジェクトができるか確認

```ruby
require "minitest/autorun"
require "./lib/gate"

class GateTest << Minitest::Text
	def test_gate
	
	assert Gate.new # オブジェクトが作成されているか確認
	end 
end
```

### テスト結果/tu

1回目　オブジェクトが作成されているのか

```ruby
$ ruby test/gate_test.rb
Run options: --seed 12775

# Running:

.

Finished in 0.000325s, 3076.9228 runs/s, 3076.9228 assertions/s.
1 runs, 1 assertions, 0 failures, 0 errors, 0 skips
```

## フェーズ2

テストから書いていく流れとする

### gate_test.rb

ながれは、

1. １５０円の切符購入
2. 梅田で入場、十三で出場する
3. 結果：出場できる

```ruby
require "minitest/autorun"
require "./lib/gate"

class GateTest << Minitest::Text
	def test_gate
		umeda = Gate.new(:umeda)
		juso = Gate.new(:juso)
		ticket = Ticket.new(150)
		umeda.enter(ticket)
		asser juso.exit(ticket)　#　結果：出場できるなので、trueが返ることが期待される
	end 
end
```

### gate.rb

まずは、

1. Gateクラスのオブジェクトが作れるように

```ruby
class Gate
	def initialize(name)
		@name = name
  end
end
```

### テスト結果

Ticketクラスが見つからないエラーが発生している

```ruby
$ ruby test/gate_test.rb
Run options: --seed 62037

# Running:

E

Error:
GateTest#test_gate:
NameError: uninitialized constant GateTest::Ticket
    test/gate_test.rb:8:in `test_gate'

rails test test/gate_test.rb:5

Finished in 0.001181s, 846.7400 runs/s, 0.0000 assertions/s.
1 runs, 0 assertions, 0 failures, 1 errors, 0 skips
```

## フェーズ３

### ticket.rb

チケットオブジェクトを作れるように クラス定義をする

```ruby
class Ticket
	def initialize(fare)
		@fare = fare
	end
end
```

### gate_test.rb

プログラムを追加する ticket.rbのファイルを呼び出せるようにします

```ruby
require "minitest/autorun"
require "./lib/gate"
require "./lib/ticket"

class GateTest << Minitest::Text
	def test_gate
		umeda = Gate.new(:umeda)
		juso = Gate.new(:juso)
		ticket = Ticket.new(150)
		umeda.enter(ticket)
		asser juso.exit(ticket)　#　結果：出場できるなので、trueが返ることが期待される
	end 
end
```

### テスト結果

enterメソッドがないとでているので、実装していく

```ruby
$ ruby test/gate_test.rb
Run options: --seed 31473

# Running:

E

Error:
GateTest#test_gate:
NoMethodError: undefined method `enter' for #<Gate:0x000000012da83d28 @name=:umeda>
    test/gate_test.rb:10:in `test_gate'

rails test test/gate_test.rb:6

Finished in 0.001104s, 905.7971 runs/s, 0.0000 assertions/s.
1 runs, 0 assertions, 0 failures, 1 errors, 0 skips
```

## フェーズ4

Gateクラスのメソッドを定義する

使うのは、enterメソッドとexitメソッド(とりあえず定義まで)

### gate.rb

```ruby
class Gate
  def initialize(name)
    @name = name
  end

	def enter(ticket)
	end

	def exit(ticket)
		true
	end
end
```

### テスト結果

```ruby
$ ruby test/gate_test.rb
Run options: --seed 36051

# Running:

.

Finished in 0.000379s, 2638.5218 runs/s, 2638.5218 assertions/s.
1 runs, 1 assertions, 0 failures, 0 errors, 0 skips
```

## フェーズ5　メソッドを実装していく

テストメソッドを新しく定義して、テストシナリオとしていく。

### gate.test.rb

```ruby
class GateTest < MiniTest::Test
	#省略　1つ目のテスト(クラスとメソッドの確認のみ)
	
	def test_umeda_to_mikuni_when_fare_is_not_enough
    umeda = Gate.new(:umeda)
    mikuni = Gate.new(:mikuni)

    ticket = Ticket.new(150)
    umeda.enter(ticket)
    refute mikuni.exit(ticket)
  end
end
```

### テスト結果

特にメソッドを定義していないので、エラーとなります

```ruby
$ ruby test/gate_test.rb
Run options: --seed 20610

# Running:

F

Failure:
GateTest#test_umeda_to_mikuni_when_fare_is_not_enough [test/gate_test.rb:20]:
Expected true to not be truthy.

rails test test/gate_test.rb:14

.

Finished in 0.000653s, 3062.7867 runs/s, 3062.7867 assertions/s.
2 runs, 2 assertions, 1 failures, 0 errors, 0 skips
```

## フェーズ6

シーケンス図のような形で設計を行い、実装する

1. **Gateクラスのenterメソッドは、引数に自分の駅名を保存する**
2. **Ticketのstampメソッドを用意。駅名を渡すと、その駅名がTicketクラスのインスタンスとして保存される**
3. **乗車駅の取得は、Ticketクラスのstamp_atメソッドで取得**
4. Gateクラスのexitメソッドは、引数として渡されるticketから運賃(fare)と乗車駅を取得する
5. exitメソッドでは、乗車駅と自分の駅名から運賃を割り出す。足りていれば”ture”、不足なら”false”となる

### gate.rb

enterメソッドを実装し、Ticketクラスのstampメソッドを呼び出し、引数に自分の駅名を保存

```ruby
class Gate
	#省略

	def enter(ticket)
		ticket.stamp(@name)
	end
end

```

### ticket.rb

さらにstampメソッドで、@stamped_atに格納しておく。

attr_readerのゲッタ−メソッドで、@stamped_atと@fareを外部から呼び出せるようにしておく

```ruby
class Ticket
	attr_reader :fare,
							:stamped_at

	def stamp(name)
		@stampe_at = name
	end
end
```

## フェーズ7

1. Gateクラスのenterメソッドは、引数に自分の駅名を保存する
2. Ticketのstampメソッドを用意。駅名を渡すと、その駅名がTicketクラスのインスタンスとして保存される
3. 乗車駅の取得は、Ticketクラスのstamp_atメソッドで取得
4. **Gateクラスのexitメソッドは、引数として渡されるticketから運賃(fare)と乗車駅を取得する**
5. exitメソッドでは、乗車駅と自分の駅名から運賃を割り出す。足りていれば”ture”、不足なら”false”となる

### gate.rb

exitメソッドまわりは、複雑になるので、処理の流れを再分解しておく

1. 運賃の配列の用意
2. 駅名も配列で用意
3. 駅名の配列から、乗車駅と降車駅を検索。その添字(要素番号,index)を取得
4. [降車駅の添字 - 乗車駅の添字]で、区間の長さを取得
5. [区間の長さ - 1]を添え字として運賃の配列から適切な運賃を取得する

実際にコードで書いていく

```ruby
class Gate
	STATIONS = [:umeda, :juso, :mikuni]
	FARES = [150, 190]

	def calc_fare(ticket)
		from = STATIONS.index(ticket.stamped_at)
		to = STATIONS.index(@name)
		distance = to - from
		FARES[distance - 1]
	end
end
```

### GPT解説

1. **`from = STATIONS.index(ticket.stamped_at)`**
    - **`ticket`**オブジェクトの**`stamped_at`**メソッドを呼び出し、その値を**`STATIONS`**という配列内でのインデックスに変換しています。
    - **`STATIONS`**配列は、駅の名前を要素として持つもので、**`ticket.stamped_at`**の値（チケットの発行駅）がどのインデックスに対応するかを特定します。
2. **`to = STATIONS.index(@name)`**
    - メソッド内で定義された**`@name`**（おそらくインスタンス変数）の値を**`STATIONS`**配列内でのインデックスに変換します。
    - **`@name`**の値は、メソッドが呼び出されたオブジェクトの現在の駅を示していると仮定します。
3. **`distance = to - from`**
    - **`from`**と**`to`**の値から、出発駅から目的地までの駅の距離を計算します。
4. **`FARES[distance - 1]`**
    - **`FARES`**という配列内の要素にアクセスし、運賃を取得します。
    - **`distance - 1`**をインデックスとして使用することで、距離に基づいた適切な運賃を取得します。
    - このメソッドの戻り値として、計算された運賃が返されます。

indexメソッドは、添字(要素番号)の取得するメソッド

```ruby
[:apple, :melon, :banana].index(:banana) => 2
```

calc_fareメソッドは、

乗車駅と降車駅を取得し、配列のindexから distanceを求めて、distanceから運賃の配列に当てはめている

calc_farメソッドは、外部からアクセスされないので、プライベートメソッドになる。

しかし、公開レベルの方法を説明していないので、publicでも現状良い。

## フェーズ8

最後にexitメソッドを作る

```ruby
def exit(ticket)
	fare = calc_fare(ticket)
	fare <= ticket.fare
end
```

### テスト結果

```ruby
$ ruby test/gate_test.rb
Run options: --seed 7049

# Running:

..

Finished in 0.000459s, 4357.2985 runs/s, 4357.2985 assertions/s.
2 runs, 2 assertions, 0 failures, 0 errors, 0 skips
```

# わからないところ抽出

```ruby
# テストファイル呼び出し
irb(main):002:0> require "./test/gate_test.rb"
=> true

# ticket変数を作成、@fare = 150 の値をいれる
irb(main):003:0> ticket = Ticket.new(150)
=> #<Ticket:0x000000011704f5c0 @fare=150>

# @umeda変数を作成 @name = :umedaの値を入れる
irb(main):007:0> @umeda = Gate.new(:umeda)
=> #<Gate:0x00000001262e3e80 @name=:umeda>

# enterメソッドを使い Ticketクラスの@stamped_at = :umedaの値を入れる
irb(main):008:0> @umeda.enter(ticket)
=> :umeda
irb(main):009:0> ticket
=> #<Ticket:0x000000011704f5c0 @fare=150, @stamped_at=:umeda>

# @mikuniを作成 @name = :mikuniの値を入れる
irb(main):010:0> @mikuni = Gate.new(:mikuni)
=> #<Gate:0x0000000126273b58 @name=:mikuni>

# exitメソッドをつかい、計算している
irb(main):011:0> @mikuni.exit(ticket)
=> false
```

# リファクタリング

今回のテストコードには一貫性が無いので、リファクタリングして読みやすくする

```ruby
def test_umeda_to_mikuni_when_fare_is_not_enough
  umeda = Gate.new(:umeda)
  mikuni = Gate.new(:mikuni)

  ticket = Ticket.new(150)
  umeda.enter(ticket)
  refute mikuni.exit(ticket)
end
```

1. テストメソッドの一貫性

```ruby
def test_umeda_to_juso_when_fare_is_enough
```

運賃が足りるときもおなじようにして良いが、今回は足りない場合をつくらないので、

出発から到着地点への意味をもたせるだけで良い

```ruby
def test_umeda_to_juso
```

1. Gateオブジェクトに共通化を図る

テストごとに、Gateオブジェクトを呼ぶのはDRYではないので、まとめてしまう

```ruby
def setup
	@umeda = Gate.new(:umeda)
	@juso = Gate.new(:juso)
	@mikuni = Gate.new(:mikuni)
end
```

### リファクタリング後

```ruby
class GateTest < Minitest::Test
  def setup #共通の変数を呼ぶためのメソッドを作成
    @umeda = Gate.new(:umeda)
    @juso = Gate.new(:juso)
    @mikuni = Gate.new(:mikuni)
  end

  def test_umeda_to_juso　# 足りるときのみのテストなので、メソッドは短い
    ticket = Ticket.new(150)
    @umeda.enter(ticket)n
    assert @juso.exit(ticket)
  end

  def test_umeda_to_mikuni_when_fare_is_not_enough
    ticket = Ticket.new(150)
    @umeda.enter(ticket)
    refute @mikuni.exit(ticket)
  end
end
```

# 他のテストを作成

残り２つもつくる

1. ２区間で運賃ちょうどの場合
2. 梅田以外の駅から乗車

```ruby
def test_umeda_to_mikuni_when_fare_is_enough
	ticket = Ticket.new(190)
	@umeda.enter(ticket)
	assert @mikuni.exit(ticket)
end

def test_juso_to_mikuni
	ticket = Ticket.new(150)
	@juso.enter(ticket)
	assert @mikuni.exit(ticket)
end
```
# selfキーワード

### アクセサメソッドを使うとき

アクセサメソッドを呼び出すときには、必要！

今回はセッターメソッドを呼び出す時は、selfをつけないと呼び出せない。

```ruby
class User
  attr_accessor :name

  def initialize
    @name = name
  end

  # selfなしで、nameメソッド=を呼ぶ
  def rename_to_taro
    name = "taro"
  end

  # self付きで、name=メソッドを呼ぶ
  def rename_to_saburo
    self.name = "saburo"
  end

  # インスタンス変数を直接書き換える
  def rename_to_shiro
    @name = "shiro"
  end
end

user = User.new("gon")

$ user.rename_to_saburo
=> user.name = "saburo"

$ user.rename_to_shiro
=> user.name = "saburo"

# セッターメソッドの呼び出しができていないので、書き換えられない
$ user.rename_to_taro
=> user.name = "gon"
```

## クラスメソッドを使うとき

使う位置によって、selfの意味が異なるので注意

```ruby
class User
	puts "クラス直下のselfキーワード #{self}"

	def self.class_method
		"クラスメソッド内のselfキーワード "#{self}"
	end

	def instance_method
		"インスタンスメソッド内のselfキーワード "#{self}"
	end
end
```

## クラスメソッドをインスタンスメソッドで呼ぶ

`クラス名.メソッド` でクラスメソッドを呼ぶ

```ruby
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
		# クラスメソッドをインスタンスメソッド内で呼び出している。
    # self.class.format_price(price)という書き方でも良い
    format_price = Product.format_price(price)
    "grocery: #{grocery}, price: #{format_price}"
  end
end
```