module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module InfonetBancard
        module Common
          def generate_operation_token_string
            case @operation_type
              when 'buy_single'
                "#{private_key}#{shop_process_id}#{amount_formatter(amount)}#{currency}"
              when 'buy_single_confirm'
                "#{private_key}#{shop_process_id}confirm{amount_formatter(amount)}#{currency}"
              when 'buy_single rollback'
                "#{private_key}#{shop_process_id}rollback0.00"
              else
                raise StandardError, 'Invalid Type'
            end
          end

          def generate_operation_token
            Digest::MD5.hexdigest(generate_operation_token_string)
          end

          private
            def amount_formatter(amount)
              amount.round(2).to_s
            end
        end
      end
    end
  end
end
