module Formatting
  module Currency
    include Number

    def format_currency(record_or_currency, amount_or_method, opts = {})
      format_string = opts.fetch(:format, "<amount> <currency>")
      skip_currency = opts.fetch(:skip_currency, false)

      unless skip_currency
        currency = opts.fetch(:currency) {
          case record_or_currency
          when String, Symbol
            record_or_currency
          else
            record_or_currency.respond_to?(:currency) ? record_or_currency.currency : nil
          end
        }
        currency = nil if currency == false
      end

      if amount_or_method.is_a?(Symbol)
        amount = record_or_currency.public_send(amount_or_method)
      else
        amount = amount_or_method
      end

      return "" if amount.nil?

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
