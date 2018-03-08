# frozen_string_literal: true
# encoding: utf-8

module InvoiceBr
  class StructBase < Dry::Struct
    constructor_type :strict_with_defaults
  end
end