@Messages = new Meteor.Collection "messages"

if Meteor.isClient


  # Load all documents in messages collection from Mongo
  Template.messages.messages = ->
    Messages.find({project_id: Session.get("projectID")}, { sort: {time: -1} })


  # Listen for the following events on the entry template
  Template.entry.events
    # All keyup events from the #messageBox element
    'keyup #messageBox': (event) ->
      event.preventDefault()
      if event.type == "keyup" && event.which == 13 # [ENTER]
        new_message = $("#messageBox")
        name = "User"

        # Save values into Mongo
        Messages.insert
          project_id: Session.get("projectID")
          name: name,
          message: new_message.val(),
          created: new Date()

        # Clear the input boxes
        new_message.val("")
        new_message.focus()

        # Make sure new chat messages are visible
        $("#chat").scrollTop 9999999;