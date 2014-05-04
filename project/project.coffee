@Projects = new Meteor.Collection("projects")

if Meteor.isClient
	Template.project.exists = ->
		Projects.findOne({id: Session.get("projectID")})?

	Template.newProject.events
		"click button": ->
			Projects.insert
				id: Session.get("projectID")
				admin: Meteor.user()._id
		"submit form.create-project": (event) ->
			event.preventDefault()
			Projects.insert
				id: Session.get("projectID")
					admin: Meteor.user()._id

	Template.showProject.projectName = ->
		return Session.get("projectID")




# Home

if Meteor.isClient
	Template.home.events
		"click button.create-project": (event) ->
			console.log "clicked"
			event.preventDefault()
			createdProjectId = $("#new-project-name").val()
			if Projects.findOne({id: createdProjectId}) is undefined
				unless Meteor.user() is null
					Projects.insert
						id: createdProjectId
						admin: Meteor.user()._id
					, ->
						Router.go("project", {_id: createdProjectId})
				else
					Meteor.loginWithGoogle undefined, ->
						Projects.insert
							id: $("#new-project-name").val()
							admin: Meteor.user()._id
						, ->
							Router.go("project", {_id: createdProjectId})

		"keyup #new-project-name": (event) ->
			createdProjectId = $("#new-project-name").val()
			available = if Projects.findOne({id: createdProjectId}) is undefined then true else false
			removeClass = if available then "error" else "success"
			addClass = if available then "success" else "error"
			iconName = if available then "ok-sign" else "ban-circle"
			html = if available then "available!" else "taken."
			$("#new-project-name,#new-project-help-block")
				.removeClass(removeClass)
				.addClass(addClass)
			$("#new-project-help-block").html("<span class=\"glyphicon glyphicon-#{iconName}\"></span> Name is #{html}")
			if createdProjectId is ""
				$("#new-project-name,#new-project-help-block").removeClass("success").removeClass("error")
				$("#new-project-help-block").html("")