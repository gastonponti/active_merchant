require 'test_helper'

class InfonetBancardModuleTest < Test::Unit::TestCase
  include ActiveMerchant::Billing::Integrations

  def test_notification_method
    assert_instance_of InfonetBancard::Notification, InfonetBancard.notification('name=cody')
  end
end
