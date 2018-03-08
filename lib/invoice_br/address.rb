# frozen_string_literal: true
# encoding: utf-8

module InvoiceBr
  class Address < StructBase
    # @!attribute description
    #   Full description for address.
    #
    #   pt-BR::
    #     <b>Descrição do endereço.</b><br>
    #     Utilizado para a leitura da NF-e quando a pessoa possui um unico
    #     campo com todos os dados do endereço
    #
    #   NF-e Rules::
    #     * <b>Type:</b> +String+
    #     * <b>Size:</b> +undefined+
    #
    #   @return [String]
    #
    attribute :description, Types::Strict::String.optional.default(nil)

    # @!attribute street
    #   Street.
    #
    #   pt-BR::
    #     <b>Rua/Logradouro.</b><br>
    #
    #   NF-e Rules::
    #     * <b>Type:</b>    +String+
    #     * <b>Size:</b>    +2..60+
    #     * <b>Tag XML:</b> +xLgr+
    #
    #   @return [String]
    #
    attribute :street, Types::Strict::String.optional.default(nil)

    # @!attribute number
    #   Address number.
    #
    #   pt-BR::
    #     <b>Número do endereço.</b><br>
    #
    #   NF-e Rules::
    #     * <b>Type:</b>    +String+
    #     * <b>Size:</b>    +1..60+
    #     * <b>Tag XML:</b> +nro+
    #
    #   @return [String]
    #
    attribute :number, Types::Coercible::String.optional.default(nil)

    # @!attribute number
    #   Address Complement.
    #
    #   pt-BR::
    #     <b>Complemento do endereço.</b><br>
    #
    #   NF-e Rules::
    #     * <b>Type:</b>    +String+
    #     * <b>Size:</b>    +1..60+
    #     * <b>Tag XML:</b> +xCpl+
    #
    #   @return [String]
    #
    attribute :complement, Types::Strict::String.optional.default(nil)

    # @!attribute neighborhood
    #   Address neighborhood.
    #
    #   pt-BR::
    #     <b>Bairro.</b><br>
    #
    #   NF-e Rules::
    #     * <b>Type:</b>    +String+
    #     * <b>Size:</b>    +2..60+
    #     * <b>Tag XML:</b> +xBairro+
    #
    #   @return [String]
    #
    attribute :neighborhood, Types::Strict::String.optional.default(nil)

    # @!attribute city
    #   City name.
    #
    #   pt-BR::
    #     <b>Nome do município.</b><br>
    #
    #   NF-e Rules::
    #     * <b>Type:</b>    +String+
    #     * <b>Size:</b>    +2..60+
    #     * <b>Tag XML:</b> +xMun+
    #
    #   @return [String]
    #
    attribute :city, Types::Strict::String.optional.default(nil)

    # @!attribute ibge_city_code
    #   IBGE City code.
    #
    #   pt-BR::
    #     <b>Nome do município.</b><br>
    #     Utilizar a Tabela do IBGE (Anexo IX- Tabela de UF, Município e País).
    #
    #   NF-e Rules::
    #     * <b>Type:</b>    +Number+
    #     * <b>Size:</b>    +7+
    #     * <b>Tag XML:</b> +cMun+
    #
    #   @return [Integer]
    #
    attribute :ibge_city_code, Types::Coercible::Int.optional.default(nil)

    # @!attribute uf
    #   State abbr.
    #
    #   pt-BR::
    #     <b>Sigla(UF) do estado.</b><br>
    #
    #   NF-e Rules::
    #     * <b>Type:</b>    +String+
    #     * <b>Size:</b>    +2+
    #     * <b>Tag XML:</b> +UF+
    #
    #   @return [String]
    #
    attribute :uf, Types::Strict::String.optional.default(nil)

    # @!attribute zip_code
    #   Zip code.
    #
    #   pt-BR::
    #     <b>CEP da localidade.</b><br>
    #     Informar os zeros não significativos. (NT 2011/004)
    #
    #   NF-e Rules::
    #     * <b>Type:</b>    +Number+
    #     * <b>Size:</b>    +8+
    #     * <b>Tag XML:</b> +CEP+
    #
    #   @return [String]
    #
    attribute :zip_code, Types::Coercible::String.optional.default(nil)

    # @!attribute country_code
    #   Country code.
    #
    #   *default:* +1058+
    #
    #   pt-BR::
    #     <b>Código do País.</b><br>
    #     1058=+Brasil+
    #
    #   NF-e Rules::
    #     * <b>Type:</b>    +Number+
    #     * <b>Size:</b>    +4+
    #     * <b>Tag XML:</b> +cPais+
    #
    #   @return [Integer]
    #
    attribute :country_code, Types::Coercible::Int.optional.default(1058)

    # @!attribute country_name
    #   Country name.
    #
    #   *default:* +BRAZIL+
    #
    #   pt-BR::
    #     <b>Nome do País.</b><br>
    #     ex: Brasil ou BRASIL
    #
    #   NF-e Rules::
    #     * <b>Type:</b>    +String+
    #     * <b>Size:</b>    +1..60+
    #     * <b>Tag XML:</b> +xPais+
    #
    #   @return [String]
    #
    attribute :country_name, Types::Strict::String.optional.default('BRASIL')


    # Returns the first 2 characters of the {#ibge_city_code}
    #
    # pt-BR::
    #   <b>Código IBGE do Estado (UF).</b><br>
    #
    # NF-e Rules::
    #   * <b>Type:</b>    +Number+
    #   * <b>Size:</b>    +2+
    #   * <b>Tag XML:</b> +cUF+
    #
    # @return [String]
    #
    def ibge_uf_code
      "#{ibge_city_code}"[0..1]
    end

    # Checks if any address information has been filled.
    #
    # @return [Boolean]
    #
    def is_present?
      street.present? || number.present?   || complement.present? ||
      city.present?   || zip_code.present? || neighborhood.present? ||
      ibge_city_code.present?
    end

    # Checks if the country is different from Brazil,
    # so it means that it is abroad.<br>
    # By default, the country code is 1058. See {#country_code}
    #
    # pt-BR::
    #   <b>Exterior?</b><br>
    #   Quando o código do país for diferente de 1058(Brasil), então
    #   entende-se que é um endereço do exterior.<br>
    #   Por padrão o código do país é 1058.
    #
    #
    # @return [Boolean]
    #
    def abroad?
      country_code.to_i != 1058
    end
  end
end