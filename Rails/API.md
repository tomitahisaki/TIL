RailsのAPIを使うときに設定するもの
Rails app を作成する　　apiモードを使用するため、オプションを指定する

```

rails _6.1.4_ new blog_api --api

```

## **CORS（Cross-Origin Resource Sharing）を設定**

デフォルトでは、React等の別のオリジンからRailsAPIにアクセス（GET, POST, PUT, DELETEなど）することは制限されています。 なので、フロント側（React）のアプリケーションからのアクセスすることを可能にする設定を書いていかなければいけません。

下記のgemを追加　bundle installをおこなう

```

gem "cors"

```

## Reactからの接続許可

React側からaxiosを設定するときに、networkエラー等の接続できないエラーが出るかも
下記ファイルが作成去れているので、こちらでReactから接続できるように設定しておく
***必ずRailsのローカルサーバーのポートをずらしておくこと！ 
config/initializer/cors.rb
```
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:3000'

    resource '*',
        headers: :any,
        methods: [:get, :post, :put, :patch, :delete, :options, :head],
        credentials: true
  end
end
```
