if Meteor.isClient
  console.log "is client"
  # Dropbox = require "dropbox"
if Meteor.isServer
  Meteor.startup ->
    console.log "is Server"
    Dropbox = Meteor.require "dropbox"