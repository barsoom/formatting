# Formatting

Rails-less formatting for your unit-testable code.

*Does* currently depend on the `i18n` library for number separators.

Very much a work in progress currently.

Formats:
  * Numbers
  * Currency


## Usage

Call methods on `Formatting`:

``` ruby
Formatting.format_number(1234.567)  # => "1,234.57"
```

Or include the modules you want:

``` ruby
include Formatting::Number
format_number(1234)  # => "1,234"

include Formatting::Currency
format_currency("SEK", 1234)  # => "1,234 SEK"
```


### Number

``` ruby
Formatting.format_number(1234.567)  # => "1,234.57"
Formatting.format_number(0, blank_when_zero: true)  # => ""
Formatting.format_number(1, explicit_sign: true)  # => "+1"
```

#### Options

name                | allowed values | default | explanation
--------------------|----------------|---------|------------
thousands_separator | any string     | `I18n.t("number.format.delimiter")` if available, otherwise a non-breaking space |
decimal_separator   | any string     | `I18n.t("number.format.separator")` if available, otherwise `"."` |
round               | `false` or a non-negative integer  | `2` | Round to the given number of decimals. Don't round if given `false`.


### Currency

The currency formatter should usually be passed some object that
the currency can be determined from. The idea is that even if you
only have one currency now, you may add more later.

``` ruby
Formatting.format_currency("SEK", 1234)  # => "1,234 SEK"

item = Item.new(price: 1234, currency: "SEK")
Formatting.format_currency(item, :price)  # => "1,234 SEK"
Formatting.format_currency(company, item.price)  # => "1,234 SEK"

Formatting.defaults[:currency] = "SEK"
item = Item.new(price: 1234)  # Does not respond to "currency"
Formatting.format_currency(item, :price)  # => "1,234 SEK"

item = Item.new(price: 1234, currency: "SEK")
Formatting.format_currency(item, :price, show_currency: false)  # => "1,234"
Formatting.defaults[:show_currency] = false
Formatting.format_currency(item, :price)  # => "1,234"
```


## Installation

Add this line to your application's Gemfile:

    gem 'formatting'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install formatting


## TODO

* Use real i18n in specs so they're less fragile and ugly
* Document options
* Rename? This name is boring and also generic enough that collisions seem likely.
