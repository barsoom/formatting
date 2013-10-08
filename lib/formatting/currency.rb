module Formatting
  module Currency
    include Number

    def format_currency(number, opts = {})
      currency = opts.fetch(:currency, nil)
      fstring  = opts.fetch(:format, "<number> <currency>")

      number = format_number(number, opts)

      out = fstring.dup
      out.gsub!("<number>", number)
      out.gsub!("<currency>", currency.to_s)
      out.strip!
      out.gsub!(" ", NON_BREAKING_SPACE)
      out
    end
  end
end
