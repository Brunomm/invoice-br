# frozen_string_literal: true
# encoding: utf-8

require 'spec_helper'

describe InvoiceBr::Address do
  let(:address) { build(:address, description: 'ok') }

  describe 'Attributes' do
    context 'Default values' do
      let(:address) { InvoiceBr::Address.new  }
      it 'country_code' do
        expect( address.country_code ).to eq(1058)
      end
      it 'country_name' do
        expect( address.country_name ).to eq('BRASIL')
      end
    end
  end

  describe '#ibge_uf_code' do
    it 'returns the first 2 characters of the ibge_city_code' do
      expect( address.ibge_uf_code ).to eq( address.ibge_city_code.to_s[0..1] )
    end
  end

  describe '#is_present?' do
    let(:empty_address) { InvoiceBr::Address.new }
    context 'returns true when' do
      it 'principal params is embty' do
        expect( empty_address.is_present? ).to eq( false )
      end
    end
    context 'returns true when' do
      it 'street is present' do
        expect( empty_address.new(street: 'some').is_present? ).to eq( true )
      end
      it 'number is present' do
        expect( empty_address.new(number: 'some').is_present? ).to eq( true )
      end
      it 'complement is present' do
        expect( empty_address.new(complement: 'some').is_present? ).to eq( true )
      end
      it 'city is present' do
        expect( empty_address.new(city: 'some').is_present? ).to eq( true )
      end
      it 'zip_code is present' do
        expect( empty_address.new(zip_code: '89804-558').is_present? ).to eq( true )
      end
      it 'neighborhood is present' do
        expect( empty_address.new(neighborhood: 'some').is_present? ).to eq( true )
      end
      it 'ibge_city_code is present' do
        expect( empty_address.new(ibge_city_code: 1234567).is_present? ).to eq( true )
      end
    end
  end

  describe '#abroad?' do
    it 'returns true when country_code is different to 1058' do
      expect( address.new(country_code: 1057).abroad? ).to eq(true)
    end
    it 'returns false when country_code is equal to 1058' do
      expect( address.new(country_code: 1058).abroad? ).to eq(false)
    end
  end
end