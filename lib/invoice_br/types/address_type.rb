require 'invoice_br/model/address'

module InvoiceBr::Types
  Address = InvoiceBr::Types.Constructor(InvoiceBr::Model::Address){ |values| InvoiceBr::Model::Address.new(values) }
end