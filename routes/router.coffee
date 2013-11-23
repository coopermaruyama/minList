if Meteor.isClient
	Router.map ->
		@route "project", 
			path: "/p/:_id"
			data: -> 
				Session.set("projectID",@params._id)
			"project"
		@route "home", path: "/"
	Router.configure
		layout: "layout"