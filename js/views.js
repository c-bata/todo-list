// Generated by CoffeeScript 1.8.0
var AddTaskView, TaskView, TasksView,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

TaskView = (function(_super) {
  __extends(TaskView, _super);

  function TaskView() {
    return TaskView.__super__.constructor.apply(this, arguments);
  }

  TaskView.prototype.tagName = 'li';

  TaskView.prototype.className = 'task-item';

  TaskView.prototype.events = {
    'click .delete': 'destroy',
    'click .toggle': 'toggle'
  };

  TaskView.prototype.toggle = function() {
    this.model.set({
      'completed': !this.model.get('completed')
    });
  };

  TaskView.prototype.initialize = function() {
    this.model.on('destroy', this.remove, this);
    return this.model.on('change', this.render, this);
  };

  TaskView.prototype.destroy = function() {
    if (confirm('are you sure?')) {
      this.model.destroy();
    }
  };

  TaskView.prototype.remove = function() {
    this.$el.remove();
  };

  TaskView.prototype.template = _.template($('#task-template').html());

  TaskView.prototype.render = function() {
    var template;
    template = this.template(this.model.toJSON());
    this.$el.html(template);
    return this;
  };

  return TaskView;

})(Backbone.View);

AddTaskView = (function(_super) {
  __extends(AddTaskView, _super);

  function AddTaskView() {
    return AddTaskView.__super__.constructor.apply(this, arguments);
  }

  AddTaskView.prototype.el = '#addTask';

  AddTaskView.prototype.events = {
    'submit': 'submit'
  };

  AddTaskView.prototype.submit = function(e) {
    var task;
    e.preventDefault();
    task = new Task;
    if (task.set({
      title: $('#title').val()
    }, {
      validate: true
    })) {
      this.collection.add(task);
      $('#error').empty();
    }
  };

  return AddTaskView;

})(Backbone.View);

TasksView = (function(_super) {
  __extends(TasksView, _super);

  function TasksView() {
    return TasksView.__super__.constructor.apply(this, arguments);
  }

  TasksView.prototype.tagName = 'ul';

  TasksView.prototype.className = 'task-list';

  TasksView.prototype.initialize = function() {
    this.collection.on('add', this.addNew, this);
    this.collection.on('change', this.updateCount, this);
    this.collection.on('destroy', this.updateCount, this);
  };

  TasksView.prototype.addNew = function(task) {
    var taskView;
    taskView = new TaskView({
      model: task
    });
    this.$el.append(taskView.render().el);
    $('#title').val('').focus();
    this.updateCount();
  };

  TasksView.prototype.updateCount = function() {
    var uncompletedTasks;
    uncompletedTasks = this.collection.filter(function(task) {
      return !task.get('completed');
    });
    $('#rest-count').html(uncompletedTasks.length);
    return $('#all-count').html(this.collection.length);
  };

  TasksView.prototype.render = function() {
    this.collection.each(function(task) {
      var taskView;
      taskView = new TaskView({
        model: task
      });
      this.$el.append(taskView.render().el);
    }, this);
    this.updateCount();
    return this;
  };

  return TasksView;

})(Backbone.View);

//# sourceMappingURL=views.js.map
