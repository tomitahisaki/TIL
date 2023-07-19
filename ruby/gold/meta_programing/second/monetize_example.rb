require_relative 'config/initializers/i18n'
require_relative 'config/initializers/money'
require "money"

currency = Money.from_cents(1000, "USD").currency
p currency.iso_code #=> "USD"
p currency.name   #=> "United States Dollar"