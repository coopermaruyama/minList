if Meteor.isClient
	console.log "app started as client"
	Template.layout.rendered = ->
		document.title = if Router._current.route.name is "project" then Session.get("projectID") else "minList"
  # Dropbox = require "dropbox"
if Meteor.isServer
  Meteor.startup ->
    console.log "is Server"
    Dropbox = Meteor.require "dropbox"
