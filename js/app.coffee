# Model
class Task extends Backbone.Model
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
class Tasks extends Backbone.Collection
  model: Task

# View
class TaskView extends Backbone.View
  tagName: 'li'
  className: 'task-item'

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

class AddTaskView extends Backbone.View
  el: '#addTask'

  events:
    'submit': 'submit'

  submit: (e) ->
    e.preventDefault();  # 画面遷移しない
    task = new Task
    if task.set({title: $('#title').val()}, {validate: true})
      @collection.add(task)
      $('#error').empty()
    return

class TasksView extends Backbone.View
  tagName: 'ul'
  className: 'task-list'

  initialize: ->
    @collection.on('add', @addNew, @)
    @collection.on('change', @updateCount, @)
    @collection.on('destroy', @updateCount, @)
    return

  addNew: (task) ->
    taskView = new TaskView model: task
    @$el.append(taskView.render().el)
    $('#title').val('').focus()  # 追加した後に空文字を挿入してフォーカスを残す
    @updateCount()
    return

  updateCount: ->
    uncompletedTasks = @collection.filter (task) ->
      return !task.get('completed')
    $('#count').html(uncompletedTasks.length)

  render: ->
    @collection.each (task) ->
      taskView = new TaskView model: task
      @$el.append taskView.render().el
      return
    , @
    @updateCount()
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