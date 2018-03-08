# frozen_string_literal: true
# encoding: utf-8

require 'spec_helper'

describe InvoiceBr do
  describe '.root' do
    it 'returns root path ' do
      expect(InvoiceBr.root).to eq(File.expand_path '../../..', __FILE__)
    end
  end
end