require 'net/http'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module InfonetBancard
        class Notification < ActiveMerchant::Billing::Integrations::Notification
          def complete?
            status == 'Approved'
          end

          def order_id
            params['order_id']
          end

          def token 
            params['token']
          end 

          def shop_process_id 
            params['shop_process_id']
          end
          
          def response
            params['response']
          end 

          def response_details
            params['response_details']
          end

          def amount
            params['amount']
          end

          def currency
            params['currency']
          end 

          def authorization_number 
            params['authorization_number']
          end

          def ticket_number
            params['ticket_number']
          end

          def response_code
            params['response_code']
          end 

          def response_description
            params['response_description']
          end 

          # # When was this payment received by the client.
          # def received_at
          #   params['']
          # end

          # def security_key
          #   params['']
          # end

          def process_id
            params['process_id']
          end

          # the money amount we received in X.2 decimal.
          def gross
            amount
          end

          # # Was this a test transaction?
          # def test?
          #   params[''] == 'test'
          # end

          def status
            case response_code
              when '00'
                'Approved'
              when '51'
                'Insufficient Founds'
              when '12'
                'Invalid Transaction'
              else
                'Failed'
            end
          end

          # Acknowledge the transaction to InfonetBancard. This method has to be called after a new
          # apc arrives. InfonetBancard will verify that all the information we received are correct and will return a
          # ok or a fail.
          #
          # Example:
          #
          #   def ipn
          #     notify = InfonetBancardNotification.new(request.raw_post)
          #
          #     if notify.acknowledge
          #       ... process order ... if notify.complete?
          #     else
          #       ... log possible hacking attempt ...
          #     end
          def acknowledge
            payload = raw

            uri = URI.parse(InfonetBancard.notification_confirmation_url)

            request = Net::HTTP::Post.new(uri.path)

            request['Content-Length'] = "#{payload.size}"
            request['User-Agent'] = "Active Merchant -- http://home.leetsoft.com/am"
            request['Content-Type'] = "application/x-www-form-urlencoded"

            http = Net::HTTP.new(uri.host, uri.port)
            http.verify_mode    = OpenSSL::SSL::VERIFY_NONE unless @ssl_strict
            http.use_ssl        = true

            response = http.request(request, payload)

            # Replace with the appropriate codes
            raise StandardError.new("Faulty InfonetBancard result: #{response.body}") unless ["AUTHORISED", "DECLINED"].include?(response.body)
            response.body == "AUTHORISED"
          end
 private

          # Take the posted data and move the relevant data into a hash
          def parse(post)
            @raw = post
            for line in post.split('&')
              key, value = *line.scan( %r{^(\w+)\=(.*)$} ).flatten
              params[key] = value
            end
          end
        end
      end
    end
  end
end
