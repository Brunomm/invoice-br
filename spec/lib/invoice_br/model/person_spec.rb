# frozen_string_literal: true
# encoding: utf-8

require 'spec_helper'
require 'invoice_br/types/address_type'

Types = InvoiceBr::Types

describe InvoiceBr::Model::Person do
  let(:person) { InvoiceBr::Model::Person.new }

  describe 'Attributes' do
    subject { described_class }
    it { is_expected.to have_attribute(:address,                      InvoiceBr::Types::Address.optional.default( InvoiceBr::Model::Address.new ) ) }
    it { is_expected.to have_attribute(:name,                         Types::Strict::String.optional.default(nil) ) }
    it { is_expected.to have_attribute(:cpf_cnpj,                     Types::Strict::String.optional.default(nil) ) }
    it { is_expected.to have_attribute(:trading_name,                 Types::Strict::String.optional.default(nil) ) }
    it { is_expected.to have_attribute(:phone,                        Types::Strict::String.optional.default(nil) ) }
    it { is_expected.to have_attribute(:mail,                         Types::Strict::String.optional.default(nil) ) }
    it { is_expected.to have_attribute(:tax_code,                     InvoiceBr::Model::Person::TaxCodeEnum.optional.default(nil) ) }
    it { is_expected.to have_attribute(:state_registration_indicator, InvoiceBr::Model::Person::StateRegistrationIndicatorEnum.optional.default(nil) ) }
    it { is_expected.to have_attribute(:state_registration,           Types::Strict::String.optional.default(nil) ) }
    it { is_expected.to have_attribute(:municipal_registration,       Types::Strict::String.optional.default(nil) ) }
    it { is_expected.to have_attribute(:suframa_registration,         Types::Strict::String.optional.default(nil) ) }
    it { is_expected.to have_attribute(:special_tax_regime,           Types::Coercible::Int.optional.default(nil) ) }
    it { is_expected.to have_attribute(:fiscal_incentive_indicator,   Types::Form::Bool.optional.default(nil) ) }
  end

  describe '#simple_national?' do
    context 'returns true when' do
      it 'tax_code is 1' do
        person = InvoiceBr::Model::Person.new(tax_code: '1')
        expect( person.simple_national? ).to eq(true)
        person = person.new(tax_code: 1)
        expect( person.simple_national? ).to eq(true)
      end
      it 'tax_code is 2' do
        person =  InvoiceBr::Model::Person.new(tax_code: '2')
        expect( person.simple_national? ).to eq(true)
        person = person.new(tax_code: 2)
        expect( person.simple_national? ).to eq(true)
      end
    end
    context 'returns false when' do
      it 'tax_code is 3' do
        person = InvoiceBr::Model::Person.new(tax_code: '3')
        expect( person.simple_national? ).to eq(false)
        person = person.new(tax_code: 3)
        expect( person.simple_national? ).to eq(false)
      end
    end
  end
end