# frozen_string_literal: true
# encoding: utf-8

require 'spec_helper'

describe 'Types' do
  describe 'OnlyNumbers' do
    it 'returns only numbers' do
      expect( InvoiceBr::Types::OnlyNumbers['A1, 22. 333/ 4444\.55555--_666666'] ).to eq('122333444455555666666')
    end
  end

  describe 'UnaccentedText' do
    it 'removes accents of text' do
      expect( InvoiceBr::Types::UnaccentedText['Áá éÊêẽ Iíì óôõò úU'] ).to eq('Aa eEe? Iii oooo uU')
    end
  end

end