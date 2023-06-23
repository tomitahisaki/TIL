class User
  # user = User.new
  # => "initialized" @nameのインスタンス変数作成"
  def initialize(name)
    puts "initialized"
    @name = name
  end

  # user.introduce
  # => "hi, I am #{@name}" @nameはinitializeで共有去れる
  def introduce
    "hi, I am #{@name}"
  end

  # user.reverse
  # => "hi, I am #{reverse_name}" 名前を逆読みする
  def reverse
    reverse_name = @name.reverse
    "hi, I am #{reverse_name}"
  end

  # インスタンス変数を外部から参照するためのメソッド
  # user.name => "taro"  @nameが出力される   
  def name
    @name
  end

  # 外部から変更するには(アクセサメソッド)
  # user.name => "taro"
  # user.name = "jiro" 
  # user.name => "jiro"
  def name=(value)
    @name = value
  end

  # メソッドで名前を変更する(引数を与える)
  # user.name => "taro"
  # user.name("jiro")
  # user.name => "jiro"
  def change_name(value)
    @name = value
  end
end


