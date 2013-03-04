require File.dirname(__FILE__) + '/infonet_bancard/helper.rb'
require File.dirname(__FILE__) + '/infonet_bancard/notification.rb'
require File.dirname(__FILE__) + '/infonet_bancard/common.rb'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module InfonetBancard

        mattr_accessor :service_url
        mattr_accessor :production_url
        self.production_url = 'https://vpos.infonet.com.py/vpos/api/0.1/'
        # Look for a sandbox!
        mattr_accessor :test_url
        self.test_url = 'https://vpos.infonet.com.py/vpos/api/0.1/'

        def self.service_url
          case ActiveMerchant::Billing::Base.integration_mode
          when :production
            self.production_url
          when :test
            self.test_url
          else
            raise "Integration mode set to an invalid value: #{ActiveMerchant::Billing::Base.integration_mode}"
          end
        end

        def self.notification(post)
          Notification.new(post)
        end
      end
    end
  end
end
