require_relative '../test_helper'

class UserSeesGreetingOnHomePage < FeatureTest
  def test_greeting_is_displayed
    # As a guest - no code for this because all users equal
    # When I visit the home page '/'
    visit '/'
    # Then I see the greeting "Welcome to the TaskManager"
    within('#greeting') do
      assert page.has_content?("Welcome to the TaskManager!")
    end
  end
end
