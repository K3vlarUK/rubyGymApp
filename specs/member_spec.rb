require('minitest/autorun')
require('minitest/pride')
require_relative('../models/member.rb')

class TestMember < MiniTest::Test

  def setup

    @member = Member.new(
      {
      'id' => '1',
      'first_name' => 'kevin',
      'last_name' => 'mcdermott',
      'premium_member' => 'True'
      }
    )

  end

  def test_merge_name()
    assert_equal("Kevin Mcdermott", @member.merge_name())
  end

end
