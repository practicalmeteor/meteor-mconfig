ConfigErrorCtor = (@varName) ->
  expect(@varName).to.be.a "string"
  @message = "lv.util.ConfigError: Missing #{@varName} setting or enviroment variable."
  @sanitizedError = new Meteor.Error 500,@message

lv.util.ConfigError = Meteor.makeErrorType "lv.util.ConfigError", ConfigErrorCtor