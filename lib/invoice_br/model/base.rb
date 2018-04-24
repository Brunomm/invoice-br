# frozen_string_literal: true
# encoding: utf-8

module InvoiceBr::Model
  class Base < Dry::Struct
    constructor_type :strict_with_defaults
  end
end