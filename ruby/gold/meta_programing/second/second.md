# オブジェクトモデル
## まとめ
  - オブジェクトは複数のインスタンス変数とクラスへのリンクで構成される
  - オブジェクトのメソッドはオブジェクトのクラスに住んでいる。(クラスから見れば、**インスタンスメソッド**と呼ばれる。)
  - クラスは`Class`クラスのオブジェクト。クラス名は単なる定数
  - `class`は`Module`のサブクラス。モジュールは基本的にはメソッドをまとめたものである。それに加えてクラスは、`new`でインスタンス化したり、`superclass`で階層構造を作ったりできる
  - 定数はファイルシステムのようなツリー状に配置されている。モジュールやクラスの名前がディレクトリ、通常の定数がファイルのようになっている
  - クラスはそれぞれ`BasicObject`まで続く継承チェーンを持っている
  - メソッドを呼び出すと、Rubyはレシーバのクラスに向かって一歩右に進み、それから継承チェーンを上へ向かって進んでいく。メソッドを発見するか京諸チェーンが終わるまで、それは続く
  - クラスにモジュールがインクルードすると、そのクラスの継承チェーンの真上にモジュールが挿入される。モジュールをプリペンドすると、そのクラスの継承チェーンの真下にモジュールが挿入される。
  - メソッドを呼び出す時は、レシーバが`self`になる。
  - モジュール(あるいはクラス)を定義する時は、そのモジュールが`self`になる。
  - インスタンス変数は常に`self`のインスタンス変数とみなされる。
  - レシーバを明示的に指定せずにメソッドを呼び出すと、そのモジュールが`self`のメソッドだとみなされる。
  - `Refinement`はクラスのコードにパッチを当てて、通常のメソッド探索をオーバーライドするようなものである。ただし、`Refinement`は`using`を呼び出したところから、ファイルやモジュールの定義が終わるところまでの限られた部分でのみ有効になる。

## オープンクラス
いつでも既存のクラスを再オープンして、その場で修正可能。(既存クラスとは、`Array`や`String`なども含む)

Rubyはクラスの定義に入ったときに、初めてクラスを定義する。

クラス宣言というよりも、スコープ演算子のようなもの。存在しないクラスについては、作成する。

### Monetize
オープンクラスの例は、`Monetize`のgemで確認可能。

**Monetize** とは、金額や通貨のユーティリティクラスがまとめられたもの。

```
require "money"
require "monetize"

# from_numericを使って、Moneyオブジェクトを生成する
price = Monetize.from_numeric(99, "USD")
p price.format => $99.00

# to_moneyを使って、Moneyオブジェクトにする
price = 100.to_money("USD)
p price.format => $100.00
```
to_moneyメソッドは、Moneyクラスに存在しているので、注意! クラスメソッドに書いてある。(書籍だと、Numericクラス)
```
class Money
  class << self
    def to_money(given_currency = nil)
      given_currency = Currency.wrap(given_currency)
      if given_currency.nil? || self.currency == given_currency
        self
      else
        exchange_to(given_currency)
      end
    end
  end
end
```