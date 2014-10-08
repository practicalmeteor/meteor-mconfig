Tinytest.add "Meteor.settings - public object exists on server side",(test)->
  test.isNotNull Meteor.settings, "there are not settings for Meteor"
  test.isNotNull Meteor.settings.public, "public is not visible on server side"
