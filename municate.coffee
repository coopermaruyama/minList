if Meteor.isClient
  console.log "is client"

if Meteor.isServer
  Meteor.startup ->
    console.log "is Server"