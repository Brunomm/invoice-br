# encoding: utf-8
require 'invoice_br/version'

# Dependences
require "slim"

# Copyright (C) 2018 Bruno M. Mergen
#
# @author Bruno Mucelini Mergen <brunomergen@gmail.com>
#
#
module InvoiceBr
  TIME_FORMAT = "%Y-%m-%dT%H:%M:%S"
  DATE_FORMAT = "%Y-%m-%d"
  TRUE_VALUES = [true, :true, 'true', 't', :t, 1, '1', :TRUE, 'TRUE', 'T']

  class << self
    def root
      File.expand_path '../..', __FILE__
    end

    def setup
      yield self
    end
  end
end