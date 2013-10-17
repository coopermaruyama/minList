Tasks = new Meteor.Collection("tasks")


if Meteor.isClient
	Template.project.projectName = ->
		return Session.get("projectID")

	Template.listTasks.tasks = ->
		Tasks.find()

	Template.addTasks.events
		'click button': ->
			Tasks.insert
				task: $("#input-task").val()
			console.log "SD"
			$("#input-task").val("")