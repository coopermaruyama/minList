@Projects = new Meteor.Collection("projects")

if Meteor.isClient
	Template.project.exists = ->
		Projects.findOne({id: Session.get("projectID")})?

	Template.newProject.events
		"click button": ->
			Projects.insert
				id: Session.get("projectID")
				admin: Meteor.user()._id

	Template.showProject.projectName = ->
		return Session.get("projectID")
