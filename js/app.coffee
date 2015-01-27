tasks = new Tasks([
  {
    title: 'task1'
    completed: true
  }
  {
    title: 'task2'
  }
  {
    title: 'task3'
  }
])

tasksView = new TasksView collection: tasks
addTaskView = new AddTaskView collection: tasks
$('#tasks').html(tasksView.render().el)