Task = Backbone.Model.extend
  defaults:
    title: "do something!"
    completed: false

task = new Task
  completed: true

# View
TaskView = Backbone.View.extend
  tagName: 'li'

taskView = new TaskView
  model: task

console.log(taskView.el)  # <li></li>

# $をつけるとjQueryの要素になるためappendとかが使える.
console.log(taskView.$el)
