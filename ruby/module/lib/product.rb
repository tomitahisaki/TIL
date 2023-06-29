require './lib/deep_freezable'

class Product
	extend DeepFreezable

	COUNTRIES = deep_freeze(['Japan', 'US', 'India'])
end	