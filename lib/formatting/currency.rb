module Formatting
  module Currency
    include Number

    def format_currency(number, opts = {})
      format_number(number, opts)
    end
  end
end
