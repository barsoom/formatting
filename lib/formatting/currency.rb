module Formatting
  module Currency
    include Number

    def format_currency(record, amount_or_method, opts = {})
      currency      = opts.fetch(:currency, nil)
      format_string = opts.fetch(:format, "<amount> <currency>")

      amount = amount_or_method

      amount = format_number(amount, opts)
      apply_format_string(format_string, amount, currency)
    end

    private

    def apply_format_string(format_string, amount, currency)
      out = format_string.dup
      out.gsub!("<amount>", amount)
      out.gsub!("<currency>", currency.to_s)
      out.strip!
      out.gsub!(" ", NON_BREAKING_SPACE)
      out
    end
  end
end
