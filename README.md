# Formatting

Rails-less formatting for your unit-testable code.

Will use the `i18n` library for formatting defaults if present, but it's not a requirement.

Formats:
  * Numbers
  * Currency
  * Percent


## Usage

Call methods on `Formatting`:

``` ruby
Formatting.format_number(1234.567)  # => "1,234.57"
```

Or include the modules you want:

``` ruby
include Formatting::Number
format_number(1234)  # => "1,234.00"

include Formatting::Currency
format_currency(item, :price)  # => "1,234.00 SEK"

include Formatting::Percent
format_percent(12.3)  # => "12.30%"
```


### Number

#### Example usage

``` ruby
Formatting.format_number(1234.567)  # => "1,234.57"
Formatting.format_number(0, blank_when_zero: true)  # => ""
Formatting.format_number(1, explicit_sign: true)  # => "+1.00"
```

#### Options

name                           | default                                                                          | explanation
-------------------------------|----------------------------------------------------------------------------------|------------
thousands_separator            | `I18n.t("number.format.delimiter")` if available, otherwise a non-breaking space |
decimal_separator              | `I18n.t("number.format.separator")` if available, otherwise `"."`                |
round                          | `2`                                                                              | Round to the given number of decimals. Don't round if given `false`.
blank_when_zero                | `false`                                                                          | If `true`, returns `""` for a zero value.
min_decimals                   | `2`                                                                              | Show at least that number of decimals. Don't enforce if given `false`.
explicit_sign                  | `false`                                                                          | If `true`, prefixes positive values with a `"+"`. Doesn't prefix `0`.
decimals_on_integers           | `true`                                                                           | If `false`, integers won't include decimals.
treat_zero_decimals_as_integer | `false`                                                                          | If `true`, a zero value in the decimal column formats the number like an integer.


### Currency

The currency formatter should usually be passed some object that
the currency can be determined from. The idea is that even if you
only have one currency now, you may add more later.

But you can also pass an explicit currency, as the first argument
or as the `currency` option.

#### Example usage

``` ruby
item = Item.new(price: 1234, currency: "SEK")
Formatting.format_currency(item, :price)  # => "1,234.00 SEK"
Formatting.format_currency(company, item.price)  # => "1,234.00 SEK"
Formatting.format_currency(company, 4567)  # => "4,567.00 SEK"
Formatting.format_currency(company, 4567, currency: false)  # => "4,567.00"
Formatting.format_currency("SEK", 4567)  # => "4,567.00 SEK"
```


#### Options

Passes on all the number options and also takes these:

name            | default                                                                        | explanation
----------------|--------------------------------------------------------------------------------|------------
currency        | `first_argument.currency` if available, or `first_argument` if it's a currency | E.g. `"USD"`. Can be `false`.
format          | `"<amount> <currency>"`                                                        | A format string. Any spaces become non-breaking spaces.
skip_currency   | `false`                                                                        | If `true`, doesn't add the currency to the amount.


### Percent

#### Example usage

``` ruby
Formatting.format_percent(12.3)  # => "12.3%"
```


#### Options

Passes on all the number options and also takes these:

name            | default                                           | explanation
----------------|---------------------------------------------------|------------
format          | `"<number>%"` or `<number> %` depending on locale | A format string.


## Installation

Add this line to your application's Gemfile:

    gem 'formatting'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install formatting


## TODO

* Use real i18n in specs so they're less fragile and ugly
* Rename? This name is boring and also generic enough that collisions seem likely.
