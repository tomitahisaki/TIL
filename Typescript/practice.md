# サバイバルTypescript
## JSとTSの違い
TSは型注釈のような固有機能がある

型注釈に基づいて、コンパイラはより細かいチェックをしてくれる

### まとめ
- JSからTSへの書き換えは 拡張子を返るだけ
- コンパイラは型の問題を教えてくれる
- 型注釈を書き加えるとコンパイラは細かいチェックをしてくれる
- コンパイラが生成したJSをデプロイして使う
  - 型注釈はTS固有。ブラウザ・Node.jsでは実行されない。TSコンパイラはJS実行環境で動かすようにJSファイルを生成する。この成果物のJSファイルを本番環境にデプロイする

