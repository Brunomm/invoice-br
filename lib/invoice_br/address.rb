# encoding: utf-8

module InvoiceBr
  class Address < StructBase
    # Descrição do endereço. Utilizado para a leitura da NF-e quando a pessoa
    # possui um unico campo com todos os dados do endereço
    attribute :description, Types::Strict::String.optional.default(nil)

    # pt-BR: Rua/Logradouro
    # NF-e:
    #  - rules:    String(2-60)
    #  - required: true
    #  - tag:      :xLgr
    #
    attribute :street, Types::Strict::String.optional.default(nil)

    # pt-BR: Número do endereço
    # NF-e:
    #  - rules:    String(1-60)
    #  - required: true
    #  - tag:      :nro
    #
    attribute :number, Types::Coercible::String.optional.default(nil)

    # pt-BR: Complemento
    # NF-e:
    #  - rules:    String(1-60)
    #  - required: false
    #  - tag:      :xCpl
    #
    attribute :complement, Types::Strict::String.optional.default(nil)

    # pt-BR: Bairro
    # NF-e:
    #  - rules:    String(2-60)
    #  - required: true
    #  - tag:      :xBairro
    #
    attribute :neighborhood, Types::Strict::String.optional.default(nil)

    # pt-BR: Nome do município
    # NF-e:
    #  - rules:    String(2-60)
    #  - required: true
    #  - tag:      :xMun
    #
    attribute :city, Types::Strict::String.optional.default(nil)

    # pt-BR: Código IBGE do município
    # NF-e:
    #  - obs:      Utilizar a Tabela do IBGE (Anexo IX- Tabela de UF, Município e País).
    #  - rules:    String(7)
    #  - required: true
    #  - tag:      :cMun
    #
    attribute :ibge_city_code, Types::Coercible::Int.optional.default(nil)

    # pt-BR: Sigla da UF
    # NF-e:
    #  - rules:    String(2)
    #  - required: true
    #  - tag:      :UF
    #
    attribute :uf, Types::Strict::String.optional.default(nil)

    # pt-BR: CEP da localidade
    # NF-e:
    #  - obs:      Informar os zeros não significativos. (NT 2011/004)
    #  - rules:    String(8) Number
    #  - required: true
    #  - tag:      :CEP
    #
    attribute :zip_code, Types::Coercible::String.optional.default(nil)

    # pt-BR: Código do País
    # NF-e:
    #  - obs:      1058=Brasil
    #  - rules:    Number(4)  Number
    #  - required: false
    #  - tag:      :cPais
    #
    attribute :country_code, Types::Coercible::Int.optional.default(1058)

    # pt-BR: Nome do País
    # NF-e:
    #  - obs:      ex: Brasil ou BRASIL
    #  - rules:    String(1-60)
    #  - required: false
    #  - tag:      :xPais
    #
    attribute :country_name, Types::Strict::String.optional.default('BRASIL')


    # pt-BR: Código IBGE do Estado (UF)
    # NF-e:
    #  - rules:    Number(2)
    #  - required: false
    #  - tag:      :cUF
    #
    def ibge_uf_code
      "#{ibge_city_code}"[0..1]
    end

    def is_present?
      street.present? || number.present?   || complement.present? ||
      city.present?   || zip_code.present? || neighborhood.present? ||
      ibge_city_code.present?
    end

    def abroad?
      country_code.to_i != 1058
    end
  end
end