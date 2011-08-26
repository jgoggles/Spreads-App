require 'test_helper'

class WeekTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Week.new.valid?
  end
end
