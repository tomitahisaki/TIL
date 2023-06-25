class User
  def initialize(name)
    @name = name
  end

  def self.create_user(names)
    names.map do |name|
      User.new(name)
    end
  end

  def hello
    puts "I am #{@name}"
  end
end