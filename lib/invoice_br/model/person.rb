# frozen_string_literal: true
# encoding: utf-8

require 'invoice_br/types/address_type'

module InvoiceBr::Model
  class Person < Base
    TaxCodeEnum = InvoiceBr::Types::Strict::Int.enum(1, 2, 3) | InvoiceBr::Types::Strict::String.enum('1', '2', '3')
    StateRegistrationIndicatorEnum = InvoiceBr::Types::Strict::Int.enum(1, 2, 9) | InvoiceBr::Types::Strict::String.enum('1', '2', '9')

    # @!attribute address
    #   Address of person.
    #
    #   pt-BR::
    #     <b>Endereço da pessoa.</b><br>
    #
    #   NF-e Rules::
    #     * <b>Type:</b>    +Group+
    #
    #   @return [Address]
    #
    attribute :address,  InvoiceBr::Types::Address.optional.default( Address.new )

    # @!attribute name
    #   Name or Company Name.
    #
    #   pt-BR::
    #     <b>Nome ou Razão Social.</b><br>
    #
    #   NF-e Rules::
    #     * <b>Type:</b>    +String+
    #     * <b>Size:</b>    +2..60+
    #     * <b>Tag XML:</b> +xNome+
    #
    #   @return [String]
    #
    attribute :name, InvoiceBr::Types::Strict::String.optional.default(nil)

    # @!attribute cpf_cnpj
    #   Social security or corporate taxpayer registry.
    #
    #   pt-BR::
    #     <b>CPF OU CNPJ.</b><br>
    #
    #   NF-e Rules::
    #     * <b>Type:</b>    +Number+
    #     * <b>Size:</b>    +11 OR 14+
    #     * <b>Tag XML:</b> +CPF+
    #     * <b>Tag XML:</b> +CNPJ+
    #
    #   @return [String]
    #
    attribute :cpf_cnpj, InvoiceBr::Types::Strict::String.optional.default(nil)

    # @!attribute trading_name
    #   Company trading name. Usend only when the person is a legal person.
    #
    #   pt-BR::
    #     <b>Nome fantasia da empresa.</b><br>
    #     Utilizado apenas quando for uma pessoa jurídica.
    #
    #   NF-e Rules::
    #     * <b>Type:</b>    +String+
    #     * <b>Size:</b>    +1..60+
    #     * <b>Tag XML:</b> +xFant+
    #
    #   @return [String]
    #
    attribute :trading_name, InvoiceBr::Types::Strict::String.optional.default(nil)

    # @!attribute phone
    #   Phone of person.
    #
    #   pt-BR::
    #     <b>Telefone.</b><br>
    #
    #   NF-e Rules::
    #     * <b>Type:</b>    +Number+
    #     * <b>Size:</b>    +6..14+
    #     * <b>Tag XML:</b> +fone+
    #
    #   @return [String]
    #
    attribute :phone, InvoiceBr::Types::Strict::String.optional.default(nil)

    # @!attribute mail
    #   Mail of person.
    #
    #   pt-BR::
    #     <b>E-mail.</b><br>
    #
    #   NF-e Rules::
    #     * <b>Type:</b>    +String+
    #     * <b>Size:</b>    +1..60+
    #     * <b>Tag XML:</b> +email+
    #
    #   @return [String]
    #
    attribute :mail, InvoiceBr::Types::Strict::String.optional.default(nil)

    # @!attribute tax_code
    #   Company tax code.
    #
    #   pt-BR::
    #     <b>CRT - Código de Regime Tributário.</b><br>
    #     * 1=Simples Nacional;
    #     * 2=Simples Nacional, excesso sublimite de receita bruta;
    #     * 3=Regime Normal.
    #
    #   NF-e Rules::
    #     * <b>Type:</b>    +Number+
    #     * <b>Size:</b>    +1+
    #     * <b>Tag XML:</b> +CRT+
    #
    #   @return [TaxCodeEnum]
    #
    attribute :tax_code, TaxCodeEnum.optional.default(nil)

    # @!attribute state_registration_indicator
    #   State Registration Indicator.
    #
    #   pt-BR::
    #     <b>E16a - Indicador da IE do Destinatário.</b><br>
    #     * *1* = Contribuinte ICMS (informar a IE do destinatário);
    #     * *2* = Contribuinte isento de Inscrição no cadastro de Contribuintes do ICMS;
    #     * *9* = Não Contribuinte, que pode ou não possuir Inscrição Estadual no Cadastro de
    #       Contribuintes do ICMS.
    #
    #   NF-e Rules::
    #     * <b>Type:</b>    +Number+
    #     * <b>Size:</b>    +1+
    #     * <b>Tag XML:</b> +indIEDest+
    #
    #   @return [StateRegistrationIndicatorEnum]
    #   TODO: Will move to Recipient class when created.
    #
    attribute :state_registration_indicator, StateRegistrationIndicatorEnum.optional.default(nil)

    # @!attribute state_registration
    #   Company state registration.
    #
    #   pt-BR::
    #     <b>Inscrição estadual.</b><br>
    #     Informar somente os algarismos, sem os caracteres de formatação (ponto, barra, hífen, etc.).
    #     Na emissão de NF-e Avulsa pode ser informado o literal 'ISENTO' para os contribuintes do
    #     ICMS isentos de inscrição no Cadastro de Contribuintes de ICMS.
    #
    #   NF-e Rules::
    #     * <b>Type:</b>    +Number+
    #     * <b>Size:</b>    +2..14+
    #     * <b>Tag XML:</b> +IE+
    #
    #   @return [String]
    #
    attribute :state_registration, InvoiceBr::Types::Strict::String.optional.default(nil)

    # @!attribute municipal_registration
    #   Company municipal registration.
    #
    #   pt-BR::
    #     <b>Inscrição municipal.</b><br>
    #
    #   NF-e Rules::
    #     * <b>Type:</b>    +String+
    #     * <b>Size:</b>    +1..15+
    #     * <b>Tag XML:</b> +IM+
    #
    #   @return [String]
    #
    attribute :municipal_registration, InvoiceBr::Types::Strict::String.optional.default(nil)

    # @!attribute suframa_registration
    #   Company suframa registration.
    #
    #   pt-BR::
    #     <b>Inscrição na SUFRAMA.</b><br>
    #     Obrigatório, nas operações que se beneficiam de incentivos
    #     fiscais existentes nas áreas sob controle da SUFRAMA. A
    #     omissão desta informação impede o processamento da
    #     operação pelo Sistema de Mercadoria Nacional da SUFRAMA e
    #     a liberação da Declaração de Ingresso, prejudicando a
    #     comprovação do ingresso / internamento da mercadoria nestas
    #     áreas. (v2.0)
    #
    #   NF-e Rules::
    #     * <b>Type:</b>    +Number+
    #     * <b>Size:</b>    +8..9+
    #     * <b>Tag XML:</b> +ISUF+
    #
    #   @return [String]
    #
    attribute :suframa_registration, InvoiceBr::Types::Strict::String.optional.default(nil)

    # @!attribute special_tax_regime
    #   Special tax regime.
    #
    #   pt-BR::
    #     <b>W22g - Código do Regime Especial de Tributação.</b><br>
    #     * *1* = Microempresa Municipal;
    #     * *2* = Estimativa;
    #     * *3* = Sociedade de Profissionais;
    #     * *4* = Cooperativa;
    #     * *5* = Microempresário Individual (MEI);
    #     * *6* = Microempresário e Empresa de Pequeno Porte (ME/EPP)
    #
    #   NF-e Rules::
    #     * <b>Type:</b>    +Number+
    #     * <b>Size:</b>    +1+
    #     * <b>Tag XML:</b> +cRegTrib+
    #
    #   @return [Integer]
    #
    attribute :special_tax_regime, InvoiceBr::Types::Coercible::Int.optional.default(nil)


    # @!attribute fiscal_incentive_indicator
    #   Fiscal incentive indicator.
    #
    #   pt-BR::
    #     <b>U17 - Indicador de incentivo Fiscal.</b><br>
    #     * *1* = Sim;
    #     * *2* = Não;
    #
    #   NF-e Rules::
    #     * <b>Type:</b>    +Number+
    #     * <b>Size:</b>    +1+
    #     * <b>Tag XML:</b> +indIncentivo+
    #
    #   @return [Boolean]
    #
    attribute :fiscal_incentive_indicator, InvoiceBr::Types::Form::Bool.optional.default(nil)

    # Helping to know if the company is opting for the simple national.
    # @return [Boolean]
    #
    def simple_national?
      tax_code.to_i.in?([1,2])
    end

  end
end