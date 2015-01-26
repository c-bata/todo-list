Task = Backbone.Model.extend
  defaults:
    title: "do something!"
    completed: false

  # モデルのバリデーション
  validate: (attrs) ->
    if _.isEmpty(attrs.title)
      "title must not be empty"

  # メソッドはこんなふうに作れる
  toggle: ->
    this.set('completed', !this.get('completed'))

task1 = new Task
  completed: true

# setter
task1.set('title': 'newTitle')

# getter
title = task1.get('title')

console.log(task1.toJSON())
task1.toggle()
console.log(task1.toJSON())

task1.set({title: ''}, {validate: true})
console.log(task1.toJSON())
