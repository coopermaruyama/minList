@Tasks = new Meteor.Collection("tasks")


if Meteor.isClient
	Template.listTasks.todos = ->
		Tasks.find
			project: Session.get("projectID")
			status: "incomplete"

	Template.listTasks.completedTasks = ->
		Tasks.find
			project: Session.get("projectID")
			status: "complete"

	Template.listTasks.checked = (complete) ->
		@status is complete

	Template.listTasks.events
		'click .task-checkbox': (e) ->
			if Tasks.findOne(@_id).status is "incomplete" then Tasks.update(@_id,{$set: {status: "complete"}}) else Tasks.update(@_id,{$set: {status: "incomplete"}})
		'click #toggle-completed': (e) ->
			$("#tasks-incomplete").slideUp()
			$("#tasks-complete").slideDown();
			$(e.currentTarget).addClass("active")
			$("#toggle-to-do").removeClass("active")
		'click #toggle-to-do': (e) ->
			$("#tasks-complete").slideUp()
			$("#tasks-incomplete").slideDown();
			$(e.currentTarget).addClass("active")
			$("#toggle-completed").removeClass("active")

	Template.addTasks.events
		'keyup input': (e) ->
			e.preventDefault()
			if event.type == "keyup" && event.which == 13 # [ENTER]
				Tasks.insert
					task: $("#input-task").val()
					status: "incomplete"
					project: Session.get("projectID")
				$("#input-task").val("")
			