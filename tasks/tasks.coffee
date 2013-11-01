@Tasks = new Meteor.Collection("tasks")


if Meteor.isClient
	Session.set("listTasks.viewMode","incomplete") unless Session.get("listTasks.viewMode")?
	Template.listTasks.tasks = ->
		state = Session.get("listTasks.viewMode") ? "incomplete"
		if state is "incomplete"
			tasks = Tasks.find
				project: Session.get("projectID")
				status: "incomplete"
		if state is "complete"
			tasks = Tasks.find
				project: Session.get("projectID")
				status: "complete"
		return tasks

	Template.listTasks.isViewMode = (viewMode) ->
		Session.get("listTasks.viewMode") is viewMode


	Template.listTasks.created = ->
		@created

	Template.listTasks.completed = ->
		@completed

	Template.task.isComplete = ->
		@status is "complete"

	Template.task.viewMode = (viewMode) ->
		Session.get("listTasks.viewMode") is viewMode

	Template.listTasks.events
		'click .task-checkbox': (e) ->
			if Tasks.findOne(@_id).status is "incomplete"
				d = new Date()
				Tasks.update @_id,
					$set: 
						status: "complete"
						completed: d.getMonth()+"/"+d.getDate()+"/"+d.getYear()
			else 
				Tasks.update(@_id,{$set: {status: "incomplete"}})

		'click .toggle-view-mode': (e) ->
			$("ul.list-tasks").fadeOut 250, ->
				Session.set "listTasks.viewMode", if Session.equals("listTasks.viewMode", "incomplete") then "complete" else "incomplete"
				$(this).fadeIn()
			$(".toggle-view-mode").removeClass("active")
			$(e.currentTarget).addClass("active")
			
			
	Template.addTasks.events
		'keyup input': (e) ->
			e.preventDefault()
			if event.type == "keyup" && event.which == 13 # [ENTER]
				d = new Date()
				Tasks.insert
					task: $("#input-task").val()
					status: "incomplete"
					project: Session.get("projectID")
					created: d.getMonth()+"/"+d.getDate()+"/"+d.getYear()
					creator: Meteor.user()._id
				$("#input-task").val("")
			