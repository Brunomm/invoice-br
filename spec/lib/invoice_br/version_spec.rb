require 'spec_helper'
describe 'Version' do

  context 'CURRENT' do
    it 'have 3 versions type' do
      expect(InvoiceBr::Version::CURRENT.split('.').size).to eq(3)
    end
  end
end