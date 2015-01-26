# Model
Task = Backbone.Model.extend
  defaults:
    title: 'do something'
    completed: false

# Collection
Tasks = Backbone.Collection.extend
  model: Task

# View
TaskView = Backbone.View.extend
  tagName: 'li'
  events:
    'click .delete': 'destroy'
    'click .toggle': 'toggle'
  toggle: ->
    @model.set 'completed': !@model.get('completed')
    return
  initialize: ->
    @model.on('destroy', @remove, @)
    @model.on('change', @render, @)
  destroy: ->
    if confirm('are you sure?')
      @model.destroy()
      return
  remove: ->
    @$el.remove()
    return
  template: _.template($('#task-template').html())
  render: ->
    template = @template( @model.toJSON() )
    @$el.html(template)
    return @

TasksView = Backbone.View.extend
  tagName: 'ul'
  render: ->
    @collection.each (task) ->
      taskView = new TaskView model: task
      @$el.append taskView.render().el
      return
    , @
    return @

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
$('#tasks').html(tasksView.render().el)