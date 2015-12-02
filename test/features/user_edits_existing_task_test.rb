require_relative '../test_helper'

class UserEditsTaskFromExistingTask < FeatureTest

  def create_tasks(num)
    num.times do |n|
      TaskManager.create({:title => "a title#{n+1}", :description => "a description#{n+1}"})
    end
  end

  def test_new_task_data_is_displayed
    create_tasks(1)

    visit '/tasks/1/edit'
    fill_in('task[title]', with: 'Make Dinner')
    fill_in('task[description]', with: 'Make it tonight')
    click_button('submit')
    visit '/tasks/1'
    within ('.card') do
      assert page.has_content?("Make Dinner")
      assert page.has_content?('Make it tonight')
    end
  end

end
