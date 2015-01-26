# Model
Task = Backbone.Model.extend
  defaults:
    title: 'do something'
    completed: false

  validate: (attrs) ->
    if _.isEmpty attrs.title
      'title must not be empty!'

  initialize: ->
    @on 'invalid', (model, error) ->
      $('#error').html(error)
      return
    return

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

AddTaskView = Backbone.View.extend
  el: '#addTask'

  events:
    'submit': 'submit'

  submit: (e) ->
    e.preventDefault();  # 画面遷移しない
    task = new Task
    if task.set({title: $('#title').val()}, {validate: true})
      @collection.add(task)
    return

TasksView = Backbone.View.extend
  tagName: 'ul'
  initialize: ->
    @collection.on('add', @addNew, @)
    return

  addNew: (task) ->
    taskView = new TaskView model: task
    @$el.append(taskView.render().el)
    return

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
addTaskView = new AddTaskView collection: tasks
$('#tasks').html(tasksView.render().el)