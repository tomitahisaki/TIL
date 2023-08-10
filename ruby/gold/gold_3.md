## Integerクラス
`Fixnum`と`Bignum`は統合された。

## open-uri
`open`は`URI.open`に変更した。

## private
レシーバをつけられなかったが、`self`がつけられるように

呼び出すことが可能になった

## 番号指定パラメータ
`_1``_2`などと記法 `_0`からは始まらないので注意！

## 演算の戻り値クラス
`Integer` < `Rational` < `Float` < `Complex`の順で強いと覚える

## undef
undefを呼び出したクラスとそのサブクラスで未定義にしたメソッドの呼び出し不可になる
```
undef hoge
undef :hoge
```

## 組み込みライブラリ
`$0`はファイル名 `$1`以降は正規表現のグループ化された値を返す

```
%r|(http://www(\.)(.*)/)| =~ "http://www.example.com/"

p $0 => ファイル名
p $1 => "http://www.example.com/"
p $2 => "."
p $3 => "example.com"
p $4 => nil
```

## 出力メソッド
| メソッド | 呼び出すメソッド |
| -------- | ---------------- |
| p        | inspect          |
| puts     | to_s             |
| print    | to_s             |

## ヒアドキュメント
### <<識別子
最後の識別までを文字列とする
```
print <<EOS
  the string
  next line
EOS
```

### <<-識別子
`-`をつけて書くことで、終端行をインデントをすることが可能

ただし、終端行に余計な空白やコメントは書けない
```
print <<-EOS
  def foo
    print "foo\n"
  end
EOS
```

### <<~識別子
最もインデントの少ない行を基準にして、全ての行の先頭から空白を除く
```
print <<~SQUIGGLY_HEREDOC
  This would contain specially formatted text.

  That might span many lines
SQUIGGLY_HEREDOC
```