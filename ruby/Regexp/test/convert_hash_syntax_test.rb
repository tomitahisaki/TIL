require 'minitest/autorun'
require './lib/convert_hash_syntax'

class ConvertHashSyntax < Minitest::Test
  def test_convert_hash_syntax
    old_syntax = <<~TEXT
      {
        :name => 'Alice',
        :age => 20,
        :gender => :female
        test
        test
      }
    TEXT
    expected = <<~TEXT
      {
        name: 'Alice',
        age: 20,
        gender: :female
      }
    TEXT
    assert_equal expected , convert_hash_syntax(old_syntax)
  end
end