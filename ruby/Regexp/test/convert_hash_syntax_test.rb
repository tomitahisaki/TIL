require 'minitest/autorun'
require './lib/convert_hash_syntax'

class ConvertHashSyntax < Minitest::Test
  def test_convert_hash_syntax
    old_syntax = <<~TEXT
      {
        :name => 'John',
        :age=>40,
        :gender => :male
      }
    TEXT
    expected = <<~TEXT
      {
        name: 'John',
        age: 40,
        gender: :male
      }
    TEXT
      # actual = convert_hash_syntax(old_syntax)
      # puts actual
      # assert_equal expected, actual
    assert_equal expected , convert_hash_syntax(old_syntax)
  end
end