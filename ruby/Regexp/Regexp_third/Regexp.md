# 正規表現3回目

# スペースやタブ文字の入った空行を探す

## スペースの入った行を探し出す

```ruby
def hello(name)
  puts "Hello, #{name}!"
end

hello('Alice')
          
hello('Bob')
	
hello('Carol')
```

まず、 `+` を入れてみる「スペースとプラス」で正規表現をいれてみる

 `+` は「スペースが1文字以上続く」という正規表現

putsの行とその他のメソッド使用の行まで反応してしまう**(見えていないが、スペースが存在している)**

以下の感じ

```ruby
def hello(name)
  puts "Hello, #{name}!"
end

hello('Alice')
          
hello('Bob')
	
hello('Carol')
```

`^ +` を使ってみると、マッチする部分が減る

以下の感じになる

```ruby
def hello(name)
  puts "Hello, #{name}!"
end

hello('Alice')
          
hello('Bob')
	
hello('Carol')
```

`^` が行頭を示すメタ文字(**位置**を示すので**アンカー**と呼ぶ)

`^ +` は、「行頭からスペースが1文字以上続く」という表現となる

2行目の putsの行はマッチから除外したいので

`^ +$`を使ってみる

```ruby
def hello(name)
  puts "Hello, #{name}!"
end

hello('Alice')
          
hello('Bob')
	
hello('Carol')
```

`$`は`^`の反対の意味で、 行末の意味を持つメタ文字(アンカー)

`^ +$` は「行頭から行末までスペースが1文字以上つづく」という意味となる。

## タブが入った行を探し出す

タブ文字は、`\t` というメタ文字(文字クラス)で表現できる

`^[ \t]+$` という形でタブの入った行も抽出する

→一応、「行頭からスペース、タブが行末まで1文字以上続く」という意味

```ruby
def hello(name)
  puts "Hello, #{name}!"
end

hello('Alice')
          
hello('Bob')
	
hello('Carol')
```

Rubyでタブ、スペースを置換している

```ruby
text = <<-TEXT
def hello(name)
  puts "Hello, \#{name}!"
end

hello('Alice')
     
hello('Bob')
	
hello('Carol')
TEXT

puts text.gsub(/^[ \t]+$/, '')
# タブ、スペースを置換している
```

### 行末に入った無駄スペースを削除する

`^[ \t]+$` を応用することで、便利になる

今回は、`[ \t]+$` を使う

意味は、「スペースまたは、タブ文字が行末まで1文字以上続く」

```ruby
def hello(name)   
  puts "Hello, #{name}!"　　
end　　　　
```

### インデントがズレているものを、左寄せにする

今回は、行頭がずれている

`^[ \t]+` を使う

意味は、「行頭からスペースやタブ文字が1文字以上続く」

```ruby
   Lorem ipsum dolor sit amet.
Vestibulum luctus est ut mauris tempor tincidunt.
         Suspendisse eget metus
      Curabitur nec urna eget ligula accumsan congue.

# text変数に入れることを想定し、
p text.gsub(/^[ \t]+/,"")

Lorem ipsum dolor sit amet.
Vestibulum luctus est ut mauris tempor tincidunt.
Suspendisse eget metus
Curabitur nec urna eget ligula accumsan congue.
```

### 不揃いなスペースを揃える

コロン”:”のあとがおかしいので、揃えてみる

`:[ \t]*` をつかう

意味は、コロンのあとにスペース、タブが0文字以上」

```ruby
text = <<-TEXT
{
  japan:	'yen',
  america:'dollar',
  italy:     'euro'
}
TEXT
puts text.gsub(/:[ \t]*/,": ")
#置換後
# {
# japan: 'yen',
# america: 'dollar',
# italy: 'euro'
# }
```

### \sを[ \t]の代わりを使う

`\s` は　半角スペース、タブ文字、改行文字などの空白文字全般を表す文字クラス

`:[ \t]*` を `:\s*` と書くこともできる

**注意点に気をつける**

言語によって、`\s` に含まれる文字が違うので注意！！

Rubyの場合は半角スペース（ ``）、タブ文字（`\t`）、改行文字（`\n`）、復帰文字（`\r`）、改ページ文字（`\f`）だけですが、JSの場合は全角スペース（`\u3000`）のような空白文字も `\s` に含まれます。

## タグ→カンマ、カンマ→タグに置換する

### タグ→カンマ

検索文字列 = `,`

置換文字列 = `\t`

```ruby
text = <<-TEXT
name,email
alice,alice@example.com
bob,bob@example.com
TEXT

puts text.gsub(",", "  ")
# name  email
# alice  alice@example.com
# bob  bob@example.com
```

### カンマ→タグ

検索文字列 = `\t` 

置換文字列 = `,` 

```ruby
text_backed = <<-TEXT
name  email
alice  alice@example.com
bob  bob@example.com
TEXT

puts text_backed.gsub(/\t/, ",")
```

## ログから特定文字を含む行を削除する

```ruby
Feb 14 07:33:02 app/web.1:  Completed 302 Found ...
Feb 14 07:36:46 heroku/api:  Starting process ...
Feb 14 07:36:50 heroku/scheduler.7625:  Starting ...
Feb 14 07:36:50 heroku/scheduler.7625:  State ...
Feb 14 07:36:54 heroku/router:  at=info method=...
Feb 14 07:36:54 app/web.1:  Started HEAD "/" ...
Feb 14 07:36:54 app/web.1:  Completed 200 ...
```

ログには2種類存在している

１つ目は、`app/` のようなwebページアクセス

2つ目は、`heroku/` のような定期的に動いているインフラ側のログ

### スケジューラーの実行ログを削除する

`**heroku/api` が含まれる行を選択する**

正規表現は、`^.+heroku\/api.+$` 

`^.+` が「行頭から何らかの文字が1文字以上続く」

`.+$` が「行末までなんらかの文字が1文字以上続く」

`\/` の部分は、バックスラッシュ`\` がスラッシュ`/` をエスケープするためのエスケープ文字

`**heroku/scheduler` の行を選択する**

正規表現は、`^.+heroku\/scheduler.+$`  

### 2つの正規表現を1つにまとめたい

OR条件のメタ文字`|` をつかうことで、まとめて選択することができる

正規表現は、`^.+heroku\/(api|scheduler).+$` となる

```ruby
text = <<-TEXT
Feb 14 07:33:02 app/web.1:  Completed 302 Found ...
Feb 14 07:36:46 heroku/api:  Starting process ...
Feb 14 07:36:50 heroku/scheduler.7625:  Starting ...
Feb 14 07:36:50 heroku/scheduler.7625:  State ...
Feb 14 07:36:54 heroku/router:  at=info method=...
Feb 14 07:36:54 app/web.1:  Started HEAD "/" ...
Feb 14 07:36:54 app/web.1:  Completed 200 ...
TEXT

puts text.gsub(/^.+heroku\/(api|scheduler).+**$**/ , " ")
Feb 14 07:33:02 app/web.1:  Completed 302 Found ...

Feb 14 07:36:54 heroku/router:  at=info method=...
Feb 14 07:36:54 app/web.1:  Started HEAD "/" ...
Feb 14 07:36:54 app/web.1:  Completed 200 ...
```

行削除はできたが、空白行が残っている…

`\n` は改行を削除することを表す　

`$` の代わりに指定することで、改行文字も含まれるようになる。

```ruby
puts text.gsub(/^.+heroku\/(api|scheduler).+**\n**/ , "")
# Feb 14 07:33:02 app/web.1:  Completed 302 Found ...
# Feb 14 07:36:54 heroku/router:  at=info method=...
# Feb 14 07:36:54 app/web.1:  Started HEAD "/" ...
# Feb 14 07:36:54 app/web.1:  Completed 200 ...
```

行頭からの何らかの文字が1文字以上続き（`^.+`）

"heroku/"が現れ（`heroku\/`）

"api" または "scheduler" が続き（`(api|scheduler)`）

その後何らかの文字が1文字以上続いて（`.+`）

改行文字で終わる（`\n`）」

## 使われる場所で異なる`^` を理解

`^` は、表記位置によって異なる意味を持つ。

**1つ目の意味**

`^` は、「行頭を表すメタ文字」の意味

→`[^AB]` は、AでもBでもない文字1文字という理解となる

→否定条件をもつもので、`^`以降の文字は含まないという形

**2つ目の意味**

→`[AB^]` は、一文字扱いとなるので、「Aまたは、Bまたは、^のいずれかの文字」という理解

→`[]` の意味のみで、`^` の意味はない。否定条件となるのは先頭に来るときのみ。

ちなみに、`^.` は「行頭にくる任意の1文字」という意味

**3つ目の意味**

→`\^`　”^”という文字列のみを検索したいときは、バックスラッシュでエスケープさせることで検索する