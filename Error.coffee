ErrorCtor = (@message, @alert = "Ha ocurrido un error. Por favor intenta mas tarde") ->
  expect(@message).to.be.a "string"
  expect(@alert).to.be.a "string"
  @message = "lv.util.Error: #{@message}"
  @sanitizedError = new Meteor.Error 500,@message

lv.util.Error = Meteor.makeErrorType "lv.util.Error", ErrorCtor