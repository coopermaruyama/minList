
if Meteor.isClient
	Template.home.events
		"click button.create-project": (event) ->
			event.preventDefault()
			unless Projects.findOne({id: $("#new-project-name").val()})?
				unless Meteor.user() is null
					Projects.insert
						id: $("#new-project-name").val()
						admin: Meteor.user()._id
				else
					Meteor.loginWithGoogle undefined, ->
						Projects.insert
							id: $("#new-project-name").val()
							admin: Meteor.user()._id

		"keyup #new-project-name": (event) ->
			unless Projects.findOne({id: $("#new-project-name").val()})?
				$("new-project-name")
					.addClass("success")
					.removeClass("success")
				$("#new-project-help-block")
					.html('<span class="glyphicon glyphicon-ok-sign"></span> Name is available!')
					.addClass("success")
					.fadeIn()
					.fadeOut()
			else
				$("new-project-name").addClass("error")
					.removeClass("error")
				$("#new-project-help-block")
					.html('<span class="glyphicon glyphicon-ban-circle"></span> Name is taken.')
					.addClass("error")
					.fadeIn()
					.fadeOut()