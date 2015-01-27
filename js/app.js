// Generated by CoffeeScript 1.8.0
var addTaskView, tasks, tasksView;

tasks = new TaskCollection([
  {
    title: '上記フォームからタスクを登録',
    completed: true
  }, {
    title: 'check buttonを押すとタスクを完了'
  }, {
    title: '右の[x]を押すとタスクを削除できます'
  }
]);

tasksView = new TasksView({
  collection: tasks
});

addTaskView = new AddTaskView({
  collection: tasks
});

$('#tasks').html(tasksView.render().el);

//# sourceMappingURL=app.js.map
