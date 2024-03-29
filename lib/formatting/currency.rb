# frozen_string_literal: true

require "attr_extras"

module Formatting
  module Currency
    def format_currency(record_or_currency, amount_or_method, opts = {})
      FormatCurrency.new(record_or_currency, amount_or_method, opts).format
    end
  end

  class FormatCurrency
    attr_private :record_or_currency, :amount_or_method, :opts,
      :format_string, :skip_currency

    def initialize(record_or_currency, amount_or_method, opts)
      @record_or_currency = record_or_currency
      @amount_or_method = amount_or_method
      @opts = opts

      @format_string = opts.fetch(:format, "<amount> <currency>")
      @skip_currency = opts.fetch(:skip_currency, false)
    end

    def format
      currency = determine_currency
      amount = determine_amount

      return "" if amount.nil?

      amount = FormatNumber.new(amount, opts).format
      apply_format_string(format_string, amount, currency)
    end

    private

    def default_currency
      case record_or_currency
      when String, Symbol
        record_or_currency
      else
        record_or_currency.respond_to?(:currency) ? record_or_currency.currency : nil
      end
    end

    def determine_currency
      return nil if skip_currency

      currency = opts.fetch(:currency) { default_currency }
      currency == false ? nil : currency
    end

    def determine_amount
      if amount_or_method.is_a?(Symbol)
        record_or_currency.public_send(amount_or_method)
      else
        amount_or_method
      end
    end

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
