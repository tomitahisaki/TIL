# 例外処理

例外とは、エラーが起きてプログラマの実行を続けることができなくなった状態という。

例外が発生した時点でプログラムが終了してしまうので、意図的にそのエラーを補足させて

プログラムを続行させるようにする

# 例外の補足

## 発生した例外を補足しない場合

モジュールではインスタンスを作成できないことを示すためのプログラム

```ruby
module Greeter
	def hello 
		puts "hello"
	end
end

greeter = Greeter.new
=> NoMethodError undefined method 'new'

# 例外処理のNoMethodErrorが発生している
# 例外が発生してしまい、プログラムが終了してしまう
```

例外を追っていくためにプログラムを書いてみる

```ruby
puts 'start'
module Greeter
	def hello 
		puts "hello"
	end
end

greeter = Greeter.new
puts 'end'

# 最後のendまで出力されていないことがわかる
=> start
=> undefinded method 'new'
```

## 例外処理を補足して実行する場合

例外が発生してもプログラムを実行できるようにする

```ruby
puts 'start'
module Greeter
	def hello 
		puts "hello"
	end
end

begin
	greeter = Greeter.new
rescue
	puts '例外が発生したが、続行する'
end

puts 'end'

=> start
=> 例外が発生したが、続行する
=> end
```

## 例外処理の流れ

例外処理の流れを、複雑な継承をつけて追ってみる

method_1からmethod_3 まで順番に呼び出される。

method_3が呼び出されて、例外が発生しても例外補足できないので、処理がmethod_2からmethod_1にもどり、例外補足されているために rescueで補足されて、`例外処理が発生しました` という文字列を出力して、`method_1 end` が出力されて終わる。

```ruby
def method_1
	puts 'method_1 start'
	begin
		method2
	rescue
		puts '例外が発生しました'
	end
	puts 'method_1 end'
end

def method_2
	puts 'method_2 start'
	method_3
	puts 'method_2 end'
end

def method_3
	puts 'method_3 start'
	# ZeroDivisionErrorを発生させる
	1 / 0
	puts 'method_3 end'
end

method_1
=> method_1 start
=> method_2 start
=> method_3 start
=> 例外が発生しました
=> method_1 end
```

### 例外処理をなくすと

```ruby
def method_1
	puts 'method_1 start'
	method_2
	puts 'method_1 end'
end

def method_2
	puts 'method_2 start'
	method_3
	puts 'method_2 end'
end

def method_3
	puts 'method_3 start'
	# ZeroDivisionErrorを発生させる
	1 / 0
	puts 'method_3 end'
end

method_1
=> method_1 start
=> method_2 start
=> method_3 start
=> ZeroDivisionError: divided by 0
```

## 例外オブジェクトから、情報を取得する

Rubyは、例外自身のオブジェクトが存在しているので、メソッドで呼び出せる

```ruby
def method_1
  begin
    divide_0
  rescue => e
    puts "エラークラス: #{e.class}"
    puts "エラーメッセージ: #{e.message}"
    puts "バックトレース -----"
    puts "e.backtrace"
    puts "--------"
  end
end

def divide_0
  1 / 0
end

method_1 

=>  エラークラス: ZeroDivisionError
=> エラーメッセージ: divided by 0
=> バックトレース -----
=> e.backtrace
=> --------
```

## クラスを指定して補足する例外

例外オブジェクトを一致させて、処理を進める

```ruby
begin
	1/0
rescue ZeroDivisionError
	puts "０で除算しました"
end

0で除算しました
Traceback (most recent call last):
	2: from class_exception.rb:12:in `<main>'
	1: from class_exception.rb:3:in `divide_0'
class_exception.rb:3:in `/': divided by 0 (ZeroDivisionError)
```

rescueに渡す例外オブジェクトが違うと、例外は捕捉されない

```ruby
begin
	# NoMethodErrorを発生させる
	'abc'.foo
rescue ZeroDivisionError
	puts '0で除算しました'
end

=> NoMethodError undefined method error 'foo'
```

NoMethodErrorも例外捕捉させるために追加する

さらに例外オブジェクトを変数に格納する

```ruby
begin
	# NoMethodErrorを発生させる
	'abc'.foo
rescue ZeroDivisionError, NoMethodError => e
	puts '0で除算したか、存在しないメソッドが呼ばれました'
	puts "エラー: #{e.class}, #{e.message}"
end

0で除算したか、存在しないメソッドが呼ばれました
エラー: NoMethodError, undefined method `foo' for "abc":String
```

## 例外クラスの継承関係

例外にもクラスが存在しており、継承が存在している

下記の様な継承関係がある

`NoMethodError` は `NameError` を継承している

```ruby
Exception

StandardError

RunTimeError NameError TypeError ArgumentError その他例外クラス
```

```ruby
NameError

NoMethodError
```

### 例外処理の継承にも注意！

継承関係とrescueの順番に注意しないと、スーパークラスに先に補足されてしまう

```ruby
begin
	'abc'.foo
rescue NameError
	# NoMethodErrorでもスーパークラスのNameErrorに捕捉されてしまう
	puts "NameError"
rescue NoMethodError
	# このrescueは捕捉されない
	puts "NoMethodError"
end
```

必ず、サブクラスから書くようにすること

```ruby
begin
	Foo.new
rescue NoMethodError
	puts "NoMethodError"
rescue NameError
	puts "NameError"
rescue #例外クラスを指定しない、もしくはスーパークラスのStandardErrorでもよい
	puts "その他のエラーです"
end
```

### 例外をやり直す

一時的なエラーの可能性があれば、例外処理をやり直すことができる

ただし、例外が解決しない場合に無限ループとなってしまうので回数制限を設けたほうが良い

```ruby
begin
	例外処理
rescue
	retry
end
# 例外処理が解決しないと retryの無限ループとなる
```

制限を設ける

```ruby
retry_count = 0
puts "処理を開始する"

begin
  1 / 0
rescue
  retry_count += 1
  if retry_count <= 3
    puts "retryします #{retry_count}"
    retry
  else
    puts "retryに失敗"
  end
end
```

## 意図的な例外処理の発生

意図的に発生させる時は、`raise` を使う

```ruby
def currency_of(country)
	case country
	when :japan
		"yen"
	when :us
		"dollar"
	when :india
		"rupee"
	else
		raise "無効な国名です #{country}"
	end
end

currency_of(japan) => yen
ccurrency_of(italy) => RuntimeError 無効な国名です italy　
```

エラーメッセージ無しの場合(良くないパターン)

raiseメソッドに何も渡さないと、エラー詳細が分かりづらくなるので、気をつける

```ruby
def currency_of(country)
	case country
	when :japan
		"yen"
	when :us
		"dollar"
	when :india
		"rupee"
	else
		raise 
	end
end

currency_of(:italy) => RuntimeError:
```

### raiseメソッドに応用をきかせる

**基本的にはやらないこと！**

raiseメソッドの第1引数に例外クラス、第2引数にエラーメッセージをつけることで、

違う例外クラスのエラーを発生させることができる

```ruby
raise ArgumentError, "無効な国名です　#{country}"
=> ArgumentError 無効な国名です italy
```

例外クラスのインスタンスを渡すことでも同じようにできる

```ruby
raise ArgumentError.new("無効な国名です #{country}")
=> ArgumentError 無効な国名です italy
```

## 例外処理のベスト

### 安易なrescueは使わない

安易にrescueを使って、例外を捕捉しないほうが良い

→**例外が発生してもrescueはしない**

プログラムが正常に実行できないことを指しているのに、強制的に動かしていくことは他への影響が考えられる。

フレームワークなどの処理に投げたり、終了させるほうが良い。

### rescueの情報を残す

では、rescueする時はどのようなときか？

メール一斉送信のメソッドで、誰かのメールアドレスが間違っていて、送信メソッドで例外が発生してしまうときなどです

→1人のせいで、みんなに送れなくなる可能性がある。

1人送れなくても、最後の人まで送信メソッドは続行するようにrescueで処理を行う必要がある

下記のメソッドは最後の一人まで、メールを送るようなメソッドで、

例外が発生したときのみ、例外の情報を残すようにしている。

```ruby
users.each do |user|
	begin
		send_mail_to(user)
	rescue => e
		#例外クラスとメッセージ、バックトレースを出力させる
		puts "#{e.class}: #{e.message}"
		puts e.backtrace
	end
end
```

### 例外処理の対象範囲と対象クラスを絞り込む

例外が発生しそうな部分に予め予想し、例外処理のコードを書き込む

例外処理の範囲が広いと、例外クラスの種類が多かったり、異常終了するべき例外まで続行可能と判断してしまう可能性がある

```ruby
require 'date'

#　平成の日付をDateオブジェクトに変換する
def convert_heisei_to_date(heisei_text)
	begin
		m = heisei_text.match(/平成(?<jp_year>\d+)年(?<month>\d+)月(?<day>\d+)日/)
		year = m[:jp_year].to_i + 1988
		month = m[:month].to_i
		day = m[:day].to_i
		Date.new(year, month, day)
	rescue
		# 例外が起きたら、nilを返したい
		nil
	end
end
```

上記だと、例外処理の対象が広すぎる。。。。

実際に不正な値が渡されるのは、`Date.new` の部分だけ

```ruby
require 'date'

def convert_heisei_to_date(heisei_text)
		m = heisei_text.match(/平成(?<jp_year>\d+)年(?<month>\d+)月(?<day>\d+)日/)
		year = m[:jp_year].to_i + 1988
		month = m[:month].to_i
		day = m[:day].to_i
	begin
		Date.new(year, month, day)
	rescue ArgumentError
		nil
	end
end
```

例外処理を絞り込むことで、Dateオブジェクトの作成が失敗したときのみ例外が発生する。

### 例外処理ではなく、条件分岐を使う

予想できるような処理であれば、実行前にvalidationのような確認ができる

```ruby
require 'date'

def convert_heisei_to_date(heisei_text)
		m = heisei_text.match(/平成(?<jp_year>\d+)年(?<month>\d+)月(?<day>\d+)日/)
		year = m[:jp_year].to_i + 1988
		month = m[:month].to_i
		day = m[:day].to_i
	if date.valide_date?(year, month, day)
		Date.new(yead, month, day)
end
```

### 予期しない条件は、異常終了とする

`case` は想定した条件のもとに作成される。`when` を使って、想定した条件の処理を網羅する

`else` をつかて、想定外のパターンを例外処理する

今回のように、else文に想定外の国が引数として渡された場合に、例外処理を発生させてプログラムを強制的に終了させる。
```
def currency_of(country)
	case country
	when :japan
	  "yen"
	when :us
	  "dollar"
	when :india
	  "rupee"
	else
		# else文が無いと、想定外の国に時に"nil"が返ってくる
		raise "無効な国名です #{country}"
	end
end
```