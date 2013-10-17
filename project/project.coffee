@Tasks = new Meteor.Collection("tasks")


if Meteor.isClient
	Template.project.projectName = ->
		return Session.get("projectID")

	Template.listTasks.tasks = ->
		Tasks.find({})
	Template.listTasks.checked = (complete) ->
		@status is complete

	Template.listTasks.events
		'click .task-checkbox': (e) ->
			Tasks.update(@_id,{$set: {status: "complete"}}) if $(e.target).is(':checked')

	Template.addTasks.events
		'click button': ->
			Tasks.insert
				task: $("#input-task").val()
				status: "incomplete"
			$("#input-task").val("")