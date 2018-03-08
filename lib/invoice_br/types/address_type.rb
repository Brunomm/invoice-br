require 'invoice_br/address'
AddressType = InvoiceBr::Types.Constructor(InvoiceBr::Address){ |values| InvoiceBr::Address.new(values) }