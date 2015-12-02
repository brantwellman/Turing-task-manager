require_relative '../test_helper'

class UserCreatesTaskFromNewForm < FeatureTest

  def test_task_is_created_from_new_form
    visit '/tasks/new'
    fill_in('task[title]', with: 'Make Dinner')
    fill_in('task[description]', with: 'Make it tonight')
    click_button('submit')
    visit '/tasks'
    within ('.card') do
      assert page.has_content?("Make Dinner")
      assert page.has_content?("Make it tonight")
    end
  end
end
