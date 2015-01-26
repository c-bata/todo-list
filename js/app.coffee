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
    template = @template( @model.toJSON() )
    @$el.html(template)
    @

# Collection

Tasks = Backbone.Collection.extend
  model: Task

TasksView = Backbone.View.extend
  tagName: 'ul'
  render: ->
    @collection.each (task) ->
      taskView = new TaskView({model: task})
      @$el.append(taskView.render().el)
      return
    ,@
    @

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

tasksView = new TasksView({collection: tasks})
$('#tasks').html(tasksView.render().el)