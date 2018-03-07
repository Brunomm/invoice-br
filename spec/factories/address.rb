FactoryBot.define do
  factory :address, class: InvoiceBr::Address do
    initialize_with do
      InvoiceBr::Address.new({
        description:    FFaker::AddressBR.full_address,
        street:         FFaker::AddressBR.street,
        number:         FFaker::AddressBR.building_number,
        complement:     FFaker::AddressBR.secondary_address,
        neighborhood:   FFaker::AddressBR.neighborhood,
        city:           FFaker::AddressBR.city,
        ibge_city_code: rand(1100015..5300108),
        uf:             FFaker::AddressBR.state_abbr,
        zip_code:       FFaker::AddressBR.zip_code
      }.merge(attributes))
    end
  end
end