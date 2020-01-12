require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "account_creation" do
    mail = UserMailer.account_creation
    assert_equal "Account creation", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
