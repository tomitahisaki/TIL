require 'minitest/autorun'
require './lib/product'
require './lib/bank'

class DeepFreezableTest < Minitest::Test
  def test_deep_freeze_to_array
    # 配列の値を確認
    assert_equal  ['Japan','US','India'], Product::COUNTRIES
    # 配列がfreezeしているか確認
    assert  Product::COUNTRIES.frozen?
    # 配列の各要素がfreezeしているか確認
    assert  Product::COUNTRIES.all? {|country| country.frozen? }
  end

  def test_deep_freeze_to_hash
    # ハッシュの値を確認
    assert_equal(
        { 'Japan' => 'yen', 'US' => 'dollar', 'India' => 'rupee' },
        Bank::CURRENCIES
      )
    # ハッシュがfreezeしているか確認
    assert Bank::CURRENCIES.frozen?
    # ハッシュのkeyとvalueがfreezeしているか確認
    assert Bank::CURRENCIES.all? {|key, value| key.frozen? && value.frozen? }
  end
end