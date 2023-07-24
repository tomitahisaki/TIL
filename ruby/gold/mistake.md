# 不正解ポイント
## protectメソッド
自クラスかサブクラスのレシーバーへ公開されているが、それ以外には隠蔽されている。

仲間クラス(自クラス、サブクラス)から参照するためにメソッドとしては公開されている。

## method_missing
継承チェーンを辿った末にメソッドが見つからない場合に呼び出される。

Bクラスのメソッドを呼び出すが、見つからずにClassクラスのインスタンスメソッドが呼ばれて、`method_missing`が呼ばれる。
```
class Class
  def method_missing(id, *args)
    puts "Class#method_missing"
  end
end
class A
  def method_missing(id, *args)
    puts "A#method_missing"
  end
end
class B < A
  def method_missing(id, *args)
    puts "B#method_missing"
  end
end

B.dummy_method
```

## 1i Complexクラス
複素数を扱うNumericクラスのサブクラス

Complex同士の計算は、Complexを返す。

## const_getメソッド
定義されている定数の値を取り出すメソッド

## YAML
設定ファイルとしてよく扱う。yamlファイル

hash array の組み合わせをインデントで表す。

yamlを読み込むには、`YAML.load(io)` `YAML.load(str)`がある。

```
require 'yaml'

yaml_data = <<-DATA
- Red
- Green
- Blue
---
- Yellow
- Pink
- White
DATA
YAML.load(yaml_data) => ["Red", "Green", "Blue"]
```
