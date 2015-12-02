require_relative '../test_helper'

class UserDeletesTaskFromExistingTask < FeatureTest

  def create_tasks(num)
    num.times do |n|
      TaskManager.create({:title => "a title#{n+1}", :description => "a description#{n+1}"})
    end
  end

  def test_deleted_task_is_not_displayed
    create_tasks(2)

    visit '/tasks/1'
    click_button('Delete Task')
    visit '/tasks'
    within ('.card') do
      refute page.has_content?("1")
    end
  end

end
