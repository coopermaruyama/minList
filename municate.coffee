if Meteor.isClient
	console.log "app started as client"
  # Dropbox = require "dropbox"
if Meteor.isServer
  Meteor.startup ->
    console.log "is Server"
    Dropbox = Meteor.require "dropbox"