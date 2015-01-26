Task = Backbone.Model.extend
  defaults:
    title: "do something!"
    completed: false

task = new Task
  completed: true

# View
TaskView = Backbone.View.extend
  tagName: 'li'
  template: _.template( $('#task-template').html() )
  render: ->
    template = this.template( this.model.toJSON() )
    this.$el.html(template)
    return this

taskView = new TaskView
  model: task

console.log(taskView.render().el)  # <li></li>
$('body').append(taskView.render().el)
