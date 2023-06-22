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

## まとめ

| 先読み・後読み | 正規表現 | 意味 |
| --- | --- | --- |
| 肯定先読み(positive look forward) | (?=abc) | 前方を見てabcがある位置にマッチ |
| 否定先読み(negative look forward) | (?!abc) | 前方を見てabcがない位置にマッチ |
| 肯定後読み(positive look behind) | (?<=abc) | 後方を見てabcがある位置にマッチ |
| 否定後読み(negative look behind) | (?<!abc) | 後方を見てabcがない位置にマッチ |

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

```ruby
Match 1
1.	http://google.com
Match 2
1.	http://facebook.com
```

# メタ文字の複雑な組み合わせ

```ruby
You say yes. - @jnchito 8s
I say no. - @BarackObama 12m
You say stop. - @dhh 7h
I say go go go. - @ladygaga Feb 20
Hello, goodbye. - @BillGates 11 Apr 2015
```

こちらから必要な情報だけ抜き出していく

## ツイートを抜き出す

ツイートの部分は、”You say yes.”となっていて、

「行頭から、ハイフンまでの任意の文字列」となっているので、

`^(.*) -` の感じになる。「行頭から任意の文字が1文字以上つづく」みたいになる。キャプチャしてあるので、ハイフン前までは、キャプチャされている。

## アカウントを抜き出す

アカウントは、@ではじまり、任意のアルファベットが続く文字列なので

`(@\w+)` というかたちとなる。キャプチャされているので、@からアカウント名が抜き出される

## ツイート日時を抜き出す

ツイートによって、日時の書き方がことなるので、順番に処理してく

1. 数秒、数分、数時間の場合

この場合は、数字とs/m/hという形になっているので、パターンで書ける

`(\d+[smh])` この形で、「半角数字とsmhのいずれかの文字」になる。

1. 一日以上前の場合

この場合は、「アルファベット３文字＋数字」になっている。

`(\w{3} \d+)`  としてみると、`\w{3}` はアルファベット３文字を、`\d+` は数字を表している。両者の間にはスペースがあるので注意

```ruby
You say yes. - @jnchito 8s
I say no. - @BarackObama 12m
You say stop. - @dhh 7h
I say go go go. - @ladygaga Feb 20
Hello, goodbye. - @BillGates 11 Apr 2015
```

上記のように、縛りがゆるいので、他のものも抜き出されてしまう。

もう少し厳し目にやってみる

`([A-Z][a-z]{2} \d{1,2})`  で良さそうです。 `\d{1,2}` としたのは、1年以上前のツイートを抜き出さないため

アルファベットと数字の間にスペースがあることを忘れないで！

### 一年以上前のツイートを抜き出す

このパターンは、「数字＋アルファベット3文字＋数字」のパターンとなっている

`((?:\d )?[A-Z][a-z]{2} \d+)` のようになる。「アルファベット3文字＋数字」の部分は日時を抜き出すときと同じ。

アルファベット3文字の前にある数字をどう抜き出すのかが鍵！

`(?:\d+ )?` の部分が、「数字あり、またはなし」の正規表現

`?` は「直前の文字が１つ、または0」の意味がある 

`()?` のように書くことで、「カッコに囲まれた文字が１つ、もしくは０」となる

単純に`()` で囲むとキャプチャとなるので、`(?: )` をつかってキャプチャ対象外としている

`(abc)` はグループ化と、キャプチャされている

`(?:abc)` は、グループ化のみされている。

また、 日にちの後にスペースが入るので`\d+`  のようになっている

## すべての日時を抜き出す

先程の時間と日時の正規表現をあわせる

`(\d+[smh]|(?:\d+ )?[A-Z][a-z]{2} \d+)` とすることで、あわせられる

OR条件を使うために`|` をつかっていることを忘れない   

## メタ文字のエスケープ

"users[100]" や "users[123]" という文字列があり、"[100]" や "[123]" の部分だけマッチさせたい場合は `\[\d+\]` と書きます。

`[ ]` をそのまま使うとメタ文字になるが、`\[ \]` のようにバックスラッシュでエスケープすることで、”[]”も文字にマッチするようになる

### よくする間違い

```ruby
users[100]
users[123]
user.rb
base.css
```

拡張子のファイルを探したいときに、`\w+.\w{1,3}` としてしまう。。。

ピリオドは「任意の１文字」なので、すべてにマッチする

正解は、`\w\.\w{1,3}` となる。ピリオドもエスケープすること！！！

## []内で働きが変わるメタ文字と変わらないメタ文字

こちらもつかってみる

```ruby
begin
  5.times { |n| puts (-10 * n + 1 / 0).zero? ^ true }
rescue
  puts $!
end
```

`[()$.*+?|{}]` をつかうと、下記のように抜き出す

要は、メタ文字の働きがなくて、「文字」として記号を抜き出している

```ruby
begin
  5.times { |n| puts (-10 * n + 1 / 0).zero? ^ true }
rescue
  puts $!
end
```

`[\w\d\s\n]` をつかうと、「英単語を構成する文字、半角数字、空白文字、改行文字のいずれか１文字」という意味となる。**メタ文字の働きをしている**

`\s` は空白スペース `\n` は改行(改行はアンダーライン引けてない)

```ruby
begin
  5.times { |n| puts (-10 * n + 1 / 0).zero? ^ true }
rescue
  puts $!
end
```

### 特殊なパターン

1. `^` `-` は、`[ ]` 内の位置によって意味が変わる。

`[a-z]` は半角英字(正確には、a またはｂ，c・・・がつづく)

`[ab-]` だと「a、b、-のいずれか１文字」という意味となる(文字列としての認識)

`[^abc]` は、「aでもaでもcでもない任意の1文字」の意味(否定の条件を表す)

`[abc^]` は、[a、b、c、^」のいずれか1文字の意味(文字列としての認識)

1. `\b` は、「単語の境界」を表す。(位置を表すアンカー文字)

`[\b]` は、バックスペース文字(0x08)として扱われる(使う機会が少ない)

1. 「n個以上」や「n個以下」を指定する

`{n,m]` のように書くことで、「直前の文字がn個以上m個以下」という意味を表す

`{n,}` `{,n}` のような書き方もある。「直前の文字がn個以上」「直前の文字がn個以下」の意味

下記の文書に`go{4,}gle` とすると、「”o”が4文字以上」にマッチする。

```ruby
google
gooogle
goooogle
gooooogle
goooooogle
```

こんどは、`go{,3}gle` とすると、「”o”が3文字以下」にマッチする

```ruby
google
gooogle
goooogle
gooooogle
goooooogle
```

1. 小文字と逆の意味になる\W \S \D \B

\w \s \d \b とは意味が逆になるので注意

- `\W` = 英単語の構成文字以外（記号や空白文字など）
- `\D` = 半角数字以外
- `\S` = 空白文字以外
- `\B` = 単語の境界以外の位置

# まとめ

- `\b` は単語の境界を表す
- `(?=abc)` は「abcという文字列の直前の位置」を表す（先読み）
- `(?<=abc)` 「abcという文字列の直後の位置」を表す（後読み）
- `(?!abc)` は「abcという文字列以外の直前の位置」を表す（否定の先読み）
- `(?<!abc)` 「abcという文字列以外の直後の位置」を表す（否定の後読み）
- キャプチャした文字列は正規表現内でも `\1` や `\2` といった連番で参照できる（後方参照）
- `?` や ``、`+` といった量指定子は `( )` の後ろに付けることもできる
- `|` を使ったOR条件では、各条件内でもメタ文字が使える
- 書き方によっては、とんでもなく遅い正規表現ができあがることもある
- メタ文字はバックスラッシュ（`\`）でエスケープする
- [ ]  `[ ]` 内ではメタ文字の種類や使われる位置によって各文字の働きが異なる
- `{n,}` や `{,n}` はそれぞれ「直前の文字がn個以上」「n個以下」の意味になる
- `\W`、`\S`、`\D`、`\B` はそれぞれ `\w`、`\s`、`\d`、`\b` の逆の意味になる