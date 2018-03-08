# frozen_string_literal: true
# encoding: utf-8

module InvoiceBr
  module Types
    include Dry::Types.module

    OnlyNumbers = Types::Strict::String.constructor do |value|
      value.gsub(/[^\d]/,'')
    end

    UnaccentedText = Types::Strict::String.constructor do |value|
      I18n.transliterate(value)
    end
  end
end