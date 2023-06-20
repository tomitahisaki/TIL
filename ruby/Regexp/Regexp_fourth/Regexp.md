# 正規表現4回目

# 英単語にマッチ

```ruby
sounds that are pleasing to the ear.
ear is the organ of the sense of hearing.
I can't bear it.
Why on earth would anyone feel sorry for you?
```

上記の文章から、特定の単語を抜き出すときは？

```ruby
/ear/

sounds that are pleasing to the ear.
ear is the organ of the sense of hearing.
I can't bear it.
Why on earth would anyone feel sorry for you?
```

こんな感じになり、earという綴りをすべて抜き出すので、他の単語も引っかかる…

`\b` をつかう。「単語の境界」を表す(位置を表すのでアンカーの1種)

「単語の境界」はスペース、ピリオド、ダブルクオート、行頭や行末など様々。

位置を表す`\b` を使って再度、表すことで、”ear”のみ抜き出せる。

```ruby
\bear\b
# 見づらいが、\b+ear+\b　という意味(直前と直後の境界がある"ear"という意味)

sounds that are pleasing to the ear.
ear is the organ of the sense of hearing.
I can't bear it.
Why on earth would anyone feel sorry for you?
```

## 検索性の低いメソッドを抜き出す(`\b` 別パターン)

Railsでは、`I18n.t` で言語を抜き出せるメソッドがある

下記は、tメソッドに省略している

```ruby
<td>
<%= link_to I18n.t('.show'), user %>
<%= link_to t('.edit'), edit_user_path(user) %>
</td>
```

`t` のみを抜き出す場合は、どうしたら良いのか？

`/t/` とすると、全ての`t` がひっかかる

なので、`\bt\b` と書くことで、`t`メソッド部分を呼び出せる

→`\b` はソースコードから特定メソッドや変数を抜き出すときに便利

```ruby
\bt\b

<td>
<%= link_to I18n.t('.show'), user %>
<%= link_to t('.edit'), edit_user_path(user) %>
</td>
```

## ファイル名のみを抜き出す

```ruby
type=zip; filename=users.zip; size=1024;
type=xml; filename=posts.xml; size=2048;
```

テキストパターンは、(キー) = (値);を繋げて表示されている

ファイル名のみ抜き出すには、`filename=[^;]+`

```ruby
/filename=[^;]+/

type=zip; filename=users.zip; size=1024;
type=xml; filename=posts.xml; size=2048;
```

`filename=`の部分は、いらないのでキャプチャしてみても良い

```ruby
/filename=([^;]+)/

type=zip; filename=users.zip; size=1024;
type=xml; filename=posts.xml; size=2048;

Match 1
1.	users.zip
Match 2
1.	posts.xml
```

### 「肯定の背後読み」をつかってみる

`(?<=filename=)` とすると、`”=u”` ,`”=p”`の部分に隙間は無いですが、その部分にハイライトがあたる

→”filename=”の文字列の「直後の位置」にマッチする

**(肯定の)後読み：**　一般に`(?<=abc)` はその文字列の「直後の位置」にマッチする

```ruby
(?<=filename=)[^;]+

type=zip; filename=users.zip; size=1024;
type=xml; filename=posts.xml; size=2048;
```

### 使わない場合

後読みを使うと、下記の様に抜き出せる

```ruby
text = <<-TEXT
type=zip; filename=users.zip; size=1024;
type=xml; filename=posts.xml; size=2048;
TEXT
text.scan(/(?<=filename=)[^;]+/)
# => ["users.zip", "posts.xml"]
```

rubyのメソッドを使えば、後読みを使わなくても良い

```ruby
text = <<-TEXT
type=zip; filename=users.zip; size=1024;
type=xml; filename=posts.xml; size=2048;
TEXT
text.scan(/filename=[^;]+/).map { |s| s.split('=').last }
# => ["users.zip", "posts.xml"]
```

### 肯定の先読みをつかう

```ruby
John:guitar, George:guitar, Paul:bass, Ringo:drum
Freddie:vocal, Brian:guitar, John:bass, Roger:drum
```

baseを担当してるメンバーを抜き出したい

`\w+:bass` とすれば、

```ruby
John:guitar, George:guitar, Paul:bass, Ringo:drum
Freddie:vocal, Brian:guitar, John:bass, Roger:drum
```

ただし、`:bass`の部分はいらない

`(?=:bass)` という正規表現の先読みテクニックをつかう。

後読みの逆パターンとなり、「直前の位置」をハイライトする 

→今回は、`”:l”` `”:n”` のような部分

`\w+(?=:bass)` とすると、名前のみ抜き出すことができる

```ruby
John:guitar, George:guitar, Paul:bass, Ringo:drum
Freddie:vocal, Brian:guitar, John:bass, Roger:drum
```

Rubyだと

```ruby
text = <<-TEXT
John:guitar, George:guitar, Paul:bass, Ringo:drum
Freddie:vocal, Brian:guitar, John:bass, Roger:drum
TEXT
p text.scan(/\w+(?=:bass)/)
# => ["Paul", "John"]
```

### 肯定の先読みと後読み

先読みは `(?=abc)` のように”abc”の文字列ではなく、直前の位置にマッチする

後読みは`\w+(?=abc)` は”abc”の文字列の直前の位置にマッチする

## 否定の後読み

先読みと後読みは、否定条件を指定することも可能

間違った都道府県の使い方を抜き出す

`(?<!東京)都` とすることで、間違った部分を抽出できる

```ruby
東京都
千葉県
神奈川県
埼玉都
```

`(?<!abc)` は、”abc”の文字列以外の直後の位置にマッチする

`(?<!東京)都` は “東京”以外の文字列の直後にでてくる”都”にマッチしている

## 否定の先読み

同じように先程の文章で否定の先読みをしてみる

`東京(?!都)`

```ruby
東京都
東京
```

`(?!abc)`のように”abc”という文字列以外の直前の位置にマッチする。

`東京(?!都)` は、”都”以外の文字列の直前に出てくる”東京”の意味になる。そのため、”東京”二反応する

# URLがそのまま画面上に表示されているリンクを見つける(後方参照)

`()`をつかってキャプチャすることで、置換するときに`\1` `$1` のような連番に参照できる。

置換だけでなく、正規表現の内部でも同じように参照できる

**後方参照**という

```ruby
<a href="http://google.com">http://google.com</a>
<a href="http://yahoo.co.jp">ヤフー</a>
<a href="http://facebook.com">http://facebook.com</a>
```

`<a href="(.+?)>\1</a>` として、値を取り出してみる

これは、`(.+?)` と`\1` は同じ文字列を指すことになる。つまり同じ文字列を指す

```ruby
<a href="http://google.com">http://google.com</a>
<a href="http://yahoo.co.jp">ヤフー</a>
<a href="http://facebook.com">http://facebook.com</a>
```

下記のようにキャプチャして取り出せる。