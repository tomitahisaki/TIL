# `enforce_available_locales!': :en is not a valid locale (I18n::InvalidLocale)を回避するため追加
require_relative 'config/initializers/i18n'

# [WARNING] The default rounding mode will change from `ROUND_HALF_EVEN` to `ROUND_HALF_UP` in the next major release. Set it explicitly using `Money.rounding_mode=` to avoid potential problems. の対応をした
require_relative 'config/initializers/money'

require "money"
require "monetize"

# currency = Money.from_cents(1000, "USD").currency
# p currency.iso_code #=> "USD"
# p currency.name   #=> "United States Dollar"


# price = Monetize.from_numeric(100, "USD")
# p price  #<Money fractional:10000 currency:USD>
# p price.format # "$100.00"


price = 100.to_money("USD")
p price.format # "$100.00"