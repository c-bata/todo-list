// Generated by CoffeeScript 1.8.0
(function() {
  var Task, TaskView, Tasks, TasksView, tasks, tasksView;

  Task = Backbone.Model.extend({
    defaults: {
      title: 'do something',
      completed: false
    }
  });

  Tasks = Backbone.Collection.extend({
    model: Task
  });

  TaskView = Backbone.View.extend({
    tagName: 'li',
    events: {
      'click .delete': 'destroy',
      'click .toggle': 'toggle'
    },
    toggle: function() {
      this.model.set({
        'completed': !this.model.get('completed')
      });
    },
    initialize: function() {
      this.model.on('destroy', this.remove, this);
      return this.model.on('change', this.render, this);
    },
    destroy: function() {
      if (confirm('are you sure?')) {
        this.model.destroy();
      }
    },
    remove: function() {
      this.$el.remove();
    },
    template: _.template($('#task-template').html()),
    render: function() {
      var template;
      template = this.template(this.model.toJSON());
      this.$el.html(template);
      return this;
    }
  });

  TasksView = Backbone.View.extend({
    tagName: 'ul',
    render: function() {
      this.collection.each(function(task) {
        var taskView;
        taskView = new TaskView({
          model: task
        });
        this.$el.append(taskView.render().el);
      }, this);
      return this;
    }
  });

  tasks = new Tasks([
    {
      title: 'task1',
      completed: true
    }, {
      title: 'task2'
    }, {
      title: 'task3'
    }
  ]);

  tasksView = new TasksView({
    collection: tasks
  });

  $('#tasks').html(tasksView.render().el);

}).call(this);

//# sourceMappingURL=app.js.map
