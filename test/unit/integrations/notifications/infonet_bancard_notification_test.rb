require 'test_helper'

class InfonetBancardNotificationTest < Test::Unit::TestCase
  include ActiveMerchant::Billing::Integrations

  def setup
    @infonet_bancard = InfonetBancard::Notification.new(http_raw_data)
  end

  def test_accessors
    assert @infonet_bancard.complete?
    assert_equal "Approved", @infonet_bancard.status
    assert_equal "12313", @infonet_bancard.shop_process_id
    assert_equal "S", @infonet_bancard.response
    assert_equal "10100.00", @infonet_bancard.gross
    assert_equal "", @infonet_bancard.currency
    assert_equal "", @infonet_bancard.received_at
    assert @infonet_bancard.test?
  end

  def test_compositions
    assert_equal Money.new(3166, 'USD'), @infonet_bancard.amount
  end

  # Replace with real successful acknowledgement code
  def test_acknowledgement

  end

  def test_send_acknowledgement
  end

  def test_respond_to_acknowledge
    assert @infonet_bancard.respond_to?(:acknowledge)
  end

  private
  def http_raw_data
    '{"operation": 
      { 
        "token": "[generated_token]", 
        "shop_process_id": "12313", 
        "response": "S", 
        "response_details" : "respuesta: S", 
        "currency": "PYG", 
        "amount": "10100.00", 
        "authorization_number": "123456", 
        "ticket_number": "123456789123456", 
        "response_code": "00", 
        "response_description": "Transacción aprobada."
      }
    }'
  end
end
