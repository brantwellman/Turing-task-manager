require_relative '../test_helper'

class TaskManagerTest < Minitest::Test

  # def create_tasks(num)
  #   num.times do |n|
  #     TaskManager.create({:title => "a title#{n+1}", :description => "a description#{n+1}"})
  #   end
  # end

  def test_task_can_be_created
    TaskManager.create({ title: "Do it!",
                         description: "This must be done."})

    task = TaskManager.find(1)

    assert_equal "Do it!", task.title
    assert_equal "This must be done.", task.description
    assert_equal 1, task.id
  end

  def test_it_can_find_all_tasks
    TaskManager.create({ title: "Do it!",
                         description: "This must be done."})
    TaskManager.create({ title: "Drink!",
                         description: "This is optional."})
    TaskManager.create({ title: "Eat!",
                        description: "When you are hungry"})

    tasks = TaskManager.all
    task1 = tasks[0]
    task2 = tasks[1]
    task3 = tasks[2]

    assert_equal 3, tasks.count
    assert_equal "Do it!", task1.title
    assert_equal "Drink!", task2.title
    assert_equal "When you are hungry", task3.description
    assert_equal 1, task1.id
  end

  def test_it_finds_an_existing_task
    TaskManager.create({ title: "Do it!",
                         description: "This must be done."})
    TaskManager.create({ title: "Drink!",
                         description: "This is optional."})
    TaskManager.create({ title: "Eat!",
                        description: "When you are hungry"})

    task1 = TaskManager.find(2)
    task2 = TaskManager.find(3)

    assert_equal "Drink!", task1.title
    assert_equal "When you are hungry", task2.description
  end

  def test_it_updates_an_existing_task_and_doesnt_modify_other_tasks
    TaskManager.create({ title: "Drink!",
                         description: "This is optional."})
    TaskManager.create({ title: "Eat!",
                         description: "When you are hungry"})

    TaskManager.update(1, { title: "Consume",
                            description: "Everyone must do it"})

    task1 = TaskManager.find(1)
    task2 = TaskManager.find(2)

    assert_equal "Consume", task1.title
    assert_equal "Everyone must do it", task1.description
    assert_equal "Eat!", task2.title
  end

  def test_it_destroys_an_existing_task_without_destroying_other_tasks
    TaskManager.create({ title: "Do it!",
                         description: "This must be done."})
    TaskManager.create({ title: "Drink!",
                         description: "This is optional."})
    TaskManager.create({ title: "Eat!",
                         description: "When you are hungry"})

    tasks1 = TaskManager.all
    TaskManager.delete(1)
    
    tasks2 = TaskManager.all
    task2 = TaskManager.find(3)
    task3 = TaskManager.find(2)

    assert_equal 3, tasks1.count
    assert_equal 2, tasks2.count
    assert_equal "Eat!", task2.title
    assert_equal "Drink!", task3.title
    assert tasks2.none? { |task| task.title == "Do it!" }
  end
end
