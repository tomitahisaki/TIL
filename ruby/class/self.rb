class User
  attr_accessor :name

  def initialize
    @name = name
  end

  # selfなしで、nameメソッド=を呼ぶ
  def rename_to_taro
    name = "taro"
  end

  # self付きで、name=メソッドを呼ぶ
  def rename_to_saburo
    self.name = "saburo"
  end

  # インスタンス変数を直接書き換える
  def rename_to_shiro
    @name = "shiro"
  end
end

user = User.new("gon")

$ user.rename_to_saburo
=> user.name = "saburo"

$ user.rename_to_shiro
=> user.name = "saburo"

# セッターメソッドの呼び出しができていないので、書き換えられない
$ user.rename_to_taro
=> user.name = "gon"