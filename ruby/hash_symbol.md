# symbol と hash

# シンボルの特徴

- 任意の文字列と1対1に対応するオブジェクト
- 文字列のかわりに用いることができる。ただし、文字列同じ振る舞いはしない
- 同じ内容のシンボルはおなじオブジェクト

特徴1　同じ内容は必ず同じオブジェクトを指す

```ruby
'melon'.object_id =>1111111
'melon'.object_id =>1111888
'melon'.object_id =>1112333
#　string型は、毎回異なるIDを生成する

:melon.object_id => 1111111
:melon.object_id => 1111111
:melon.object_id => 1111111
#　symbol型は、いつも同じIDとなる
```

特徴2　イミュータブルなオブジェクト 　　*イミュータブル(変更できない)

```ruby
string = "melon"
string.upcase! => "MELON"
# stringはミュータブルなオブジェクト

symbol = :melon
symbol.upcase! => NoMethodErrorになる
# symbolはイミュータブルなオブジェクト
```

## hashに使う

hashのキーにはシンボルを使う方が適している

```ruby
# hashのキーをシンボルにする
countries = { :japan => "こんにちは", :US => "hello", :spain => "ciao" }
countries[:japan] = "こんにちは"

# =>　を使わない
countries = { japan: "こんにちは", US: "hello", spain: "ciao" }
countries[:japan] = "こんにちは"

# キーも値もシンボルの場合
currencies = { japan: :yen, US: :dollar, spain: :euro }
```

## 異なる型をまとめてhashに格納する

```ruby
person = {
	#string
	name: "taro",
	# integer
	age: 21,
	# array
	favorite ["soccer", "baseball"]
	# hash
	phone: {home: "000-0000", mobile: "111-1111"}
}

person[:name] = "taro"
person[:age] = 21
person[:phone][:home] = "000-0000"
```

## メソッドのキーワードとして

hashのキーを使うことで、メソッド定義の場合にわかりやすく表記できる

### 悪い例

```ruby
# このようなメソッド
def buy_meal(menu, salad, drink)
   ~~~~
	if salad
	
	end

	if drink
 
	end
end

#　理解しにくい引数が存在するメソッドとなる(何がtrue、falseなのかぱっと見、分からない)
buy_meal("ramen", true, true)
buy_meal("katsudon", false, true)
```

最適例
