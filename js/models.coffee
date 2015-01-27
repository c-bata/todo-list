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
