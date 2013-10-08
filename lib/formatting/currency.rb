module Formatting
  module Currency
    include Number

    def format_currency(number, opts = {})
      currency      = opts.fetch(:currency, nil)
      format_string = opts.fetch(:format, "<number> <currency>")

      number = format_number(number, opts)
      apply_format_string(format_string, number, currency)
    end

    private

    def apply_format_string(format_string, number, currency)
      out = format_string.dup
      out.gsub!("<number>", number)
      out.gsub!("<currency>", currency.to_s)
      out.strip!
      out.gsub!(" ", NON_BREAKING_SPACE)
      out
    end
  end
end
