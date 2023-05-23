# ブログ記事の一覧・詳細・作成APIの実装

migrationファイルやモデルの実装は省略する

rails側からコントローラーの設定を行う。

```ruby
class BlogsController < ApplicationController
  def index
    blogs = Blog.all
    render json: blogs
  end

  def show
    blog = Blog.find(params[:id])
    render json: blog
  end

  def create
    Blog.create(blog_params)
    head :created
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :contents)
  end
end
```

## json形式

indexやshowアクションでは、json形式でデータを返す

index だと`json: blogs`  showだと`json: blog`

routingを設定してあれば、`rails s` で確認してみると、
json形式で返ってきているのか確認できる(ハッシュの形で返ってきている)
