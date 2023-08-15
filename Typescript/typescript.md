## 環境構築
```
npm init # 管理ツールの初期化 packageやらが生成される
```

jsファイルの確認
```
node ファイル名.js # ファイルが実行される
```

tsファイルの確認
```
tsc ファイル名.ts # ファイルが実行される
```
tsファイル実行できない時は、、、
```
npm install -g typescript # npmにインストールするコマンド

npm bin -g # コマンドの参照先

tsc -v # versionが表示されないなら、rehashする

# これでも実行できなかったので、
nodenv rehash # こちらで実行可能 作り直しのするみたいな意味
```