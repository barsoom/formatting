module Formatting
  module Currency
    include Number

    def format_currency(record, amount_or_method, opts = {})
      opts = Formatting.defaults.merge(opts)

      format_string = opts.fetch(:format, "<amount> <currency>")

      currency = opts.fetch(:currency) {
        record.respond_to?(:currency) ? record.currency: nil
      }

      if amount_or_method.is_a?(Symbol)
        amount = record.public_send(amount_or_method)
      else
        amount = amount_or_method
      end

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
