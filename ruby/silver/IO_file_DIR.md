# Ruby/silver試験の備忘録
silver試験の学習の中で、最も躓いている部分。

自分のために少しまとめてみようと思います。

## Dirクラス、Fileクラス、IOクラスってなに？
## Dirクラス
ディレクトリを扱うクラス。

ディレクトリの移動や作成、ファイル一覧の取得ができる。

`open` ディレクトリを開くメソッド。返り値はDirオブジェクトで`each`を回せば、ファイル一覧取得できる。

```
dir = Dir.open("/document/ruby/silver")
=> #<Dir:/document/ruby/silver>

# eachでファイル一覧を出力できる
dir.each{|file| puts file}
=>  hash.md
    symbol.md
    array.md
    regexp.md
    module.md
    exception.md
    practice.rb

# ブロックの場合は、自動でcloseされる
dir.open("/document/ruby/silver"){|dir| dir.path}
/document/ruby/silver
=> nil

# closeをつかって、開いたディレクトリを閉じる。
dir.close
=> nil
```

### メソッド一覧
`pwd`, `getwd` カレントディレクトリを取得する。ディレクトリがいる位置を取得する

`chdir` カレントディレクトリを指定したディレクトリに移動する 成功したら、0を返す

```
dir.chdir("document/ruby/gold")
=> 0
```

`mkdir` ディレクトリの作成をする。作成が成功した時は、0を返す

```
dir.mkdir("document/ruby/platinum")
=> 0
```

`rmdir` ディレクトリの削除をする。成功した時は、0を返す

```
dir.mkdir("document/ruby/silver")
```

## Fileクラス
ファイルに関するクラス。ファイルの作成、削除、読み取り、追記、属性変更などに対応できる。

メソッドの多くがUNIX系システム(Linux)のコマンドに対応している。

### ファイルの取得
`new`, `open`はファイルを開くときに使う。引数を与えることで、開くだけでなく、読み取りができる。存在しないファイルを指定するとエラーになる。
```
p file = File.open("ruby_gold.md")
=> #<File:ruby_gold.md>
file.read
=> "ルビーgoldのmdファイルです.\n"
file.close
=> nil
```

> ファイルのモード
`open`メソッドは、第2引数を与えることができて、開くモードを指定できる。

| 引数名             | 内容                                                      |
| ------------------ | ---------------------------------------------------------- |
| "r"                | 読み書きモード                                             |
| "w"                | 書き込みモード 既存ファイルの場合は、ファイル内容を空にする | 
| "a"                | 追記モード 常にファイル末尾に追記される                    |
| "r+"               | 読み書きモード ファイルの読み書き位置が先頭になる 書き換えられる。          |
| "w+"               | 読み書きモード "r+"と同じだが、既存ファイルの場合は、ファイル内容を空にする |
| "a+"               | 読み書きモード ファイルの読み込み位置は先頭、書き込み位置は末尾 |

### ファイルの属性取得
`basename` 指定されたパスからファイル名を取得する

`dirname` 指定されたパスからディレクトリ名を取得する

`extname` 指定されたパスからディレクトリ名とファイル名の配列を取得する

`stat`, `lstat` 属性を示すFile::Statクラスのオブジェクトを返す。

`atime` 最終アクセス時刻

`ctime` 変更された時刻

`mtime` 最終更新時刻

`path`, `lstat`, `atime`, `ctime`, `mtime`は、ファイルオブジェクトのメソッドでも取得可能

### テストメソッド
ファイルの存在確認、ディレクトリかどうかなどのファイルをテストするメソッドがある。

`exist?`  存在しているか確認するメソッド

`file?`, `directory?`, `symlink?`はファイル、ディレクトリ、シンボリックリンクか調べる

`executable?`, `readable?`, `writable?`は、実行可能か、読み取り可能か、書き込み可能か調べる

`size` ファイルのサイズを返す

### 属性の設定
`chmod` ファイルの属性を変更する パーミッションを加えることで、変更できる

`chown` ファイルの所有者を変更する

### その他
`utime` アクセス時刻や更新時刻を設定できる

`expand_path` 絶対パスを展開する

`delete`, `unlink` 削除する

`truncate` ファイルを指定したバイト数に切り詰める

`rename` ファイルをリネームする

## IOクラス
Fileクラスのスーパークラスであり、基本的な入出力機能を備えたクラス

`STDOUT` 標準出力, `STDIN`標準入力, `STDERR`標準エラー出力

### 入力メソッド
`read` 読み取り 長さが指定されていれば、その長さだけ読み取る

`foreach`, `each`, `each_lines` 各行に対して、読み取りをしていくことができる

`readlines` 全ての行を読み込んで、各行を配列で返す

`readline`, `gets` 1行だけ読み込んで、返すメソッド

`getbyte` 1バイト読み込んで、整数で返す

`each_char` 与えられたブロックに、IOのオブジェクトから1文字ずつ読み込んで、渡す。

`getc`, `readchar` は1文字つ読み込むために使える。

### 出力メソッド
`write`, `puts`, `print`, `printf`, etc  この部分は省略するが、引数の文字列やバイトを出力する

### オブジェクトの状態を調べる
`stat` オブジェクトの状態をしらべる

`closed?` オブジェクトが閉じられたかどうか

`eof?` ファイルの終端に到達しているかどうか

### ポインタの移動、設定
`rewind` ポインタを先頭に移動する

`pos` 現在のポインタの位置を取得、設定できる

`seek` ポインタを第2引数の一から、第1引数の数だけ、移動できる。

## まとめ
ざっくりまとめてみたが、もちろん一度では、頭に入りません…

なので、サンプルのディレクトリやファイルを作りながら、実際に試すことで少しは覚えられたと思います。

ありがとうございました〜