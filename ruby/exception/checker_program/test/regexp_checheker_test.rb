require 'minitest/autorun'
require './lib/regexp_checker'

# 標準出力のみテストの場合は、多分違う
class RegexpCheckerText < Minitest::Test
  def test_regexp_checker_matches
    # text = 123-456-789
    # pattern = [1-9]+
    assert "Matched: 123, 456, 789"
  end

  def test_regexp_checker_not_matches
    # Text: abcdef
    # Pattern: [1-9]
    assert "Nothing matched"
  end
end