module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module InfonetBancard
        class Helper < ActiveMerchant::Billing::Integrations::Helper
          include Common

          def initialize(order, account, options = {})
            @operation_type = options.delete(:operation_type) 
            entity = options.delete(:entity)
            brand = options.delete(:brand)
            product = options.delete(:product)
            afinity = options.delete(:afinity)
            super
            add_field("token", generate_operation_token())
            add_field("additional_data", create_additional_data(entity, brand, product, afinity)) 
          end

          # Replace with the real mapping
          mapping :amount, 'amount'
          mapping :account, 'store_id' 
          mapping :return_url, 'return_url'
          mapping :cancel_return_url, 'cancel_url'
          mapping :description, 'description'
          mapping :currency, 'currency'
          mapping :store_branch_id, 'store_branch_id'
          mapping :shop_process_id, 'shop_process_id'
        
          mapping :order, 'order'
          mapping :notify_url, ''
          mapping :tax, ''
          mapping :shipping, ''

          mapping :customer, :first_name => '',
                             :last_name  => '',
                             :email      => '',
                             :phone      => ''

          mapping :billing_address, :city     => '',
                                    :address1 => '',
                                    :address2 => '',
                                    :state    => '',
                                    :zip      => '',
                                    :country  => ''

          private
            def create_additional_data(entity, brand, product, afinity)
              "#{format_field(entity,3)}#{format_field(brand, 3)}#{format_field(product, 3)}#{format_field(afinity, 6)}"
            end

            def format_field(field, char_quantity)
              ("%-#{char_quantity}s" % field.to_s)[0..char_quantity-1]
            end
        end
      end
    end
  end
end
