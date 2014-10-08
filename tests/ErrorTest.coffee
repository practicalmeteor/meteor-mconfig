throwError = (msg,alert)->
  log.debug "ErrorTest:throwError()"
  if alert
    throw new lv.util.Error(msg,alert)
  else
    throw new lv.util.Error(msg)


if Meteor.isServer
  Meteor.methods
    throwErrorFromMethod: ->
      log.debug "ErrorTest.throwErrorFromMethod()"
      throwError("This is an error")


class ErrorTest
  self = @

  constructor: ->
    log.debug "ErrorTest.constructor()"
    self = @

  tests:[
    {
      name:"ErrorTest - Should be an instance of Error"
      func:(test)->
        log.debug "ErrorTest - Should be an instance of Error"
        lvError = new lv.util.Error("This is an error", "Ocurrio un error")
        expect(lvError).to.be.instanceof Error
    },
    {
      name:"ErrorTest - check properties"
      func:(test)->
        log.debug "ErrorTest - check properties"
        lvError = new lv.util.Error("This is an error", "Ocurrio un error")
        expect(lvError).to.have.property "message"
        expect(lvError.message).to.equal "lv.util.Error: This is an error"
        expect(lvError).to.have.property "alert"
        expect(lvError.alert).to.equal "Ocurrio un error"
        log.error lvError
    },
    {
      name:"ErrorTest - check default alert message"
      func:(test)->
        log.debug "ErrorTest - check default alert message"
        lvError = new lv.util.Error("This is an error")
        expect(lvError).to.have.property "alert"
        expect(lvError.alert).to.equal "Ha ocurrido un error. Por favor intenta mas tarde"
    },
    {
      name:"ErrorTest - throw"
      func:(test)=>
        log.debug "ErrorTest - throw"
        thrownError = null
        try
          throwError("This is an error")
        catch err
          expect(err).to.have.property 'stack'
          expect(err.stack).to.be.a 'string'
          expect(err).to.be.instanceof lv.util.Error
          thrownError = err
        finally
          expect(thrownError).not.to.be.null
    },
    {
      name:"ErrorTest - sanitizedError - throw in meteor method"
      type:"client"
      timeout:2000,
      skip:true,
      func:(test,onComplete)->
        log.debug "ErrorTest - throw in meteor method"
        Meteor.call "throwErrorFromMethod", onComplete (err,res)->
          expect(err).to.have.property "message"
          expect(err.message).to.equal "lv.util.Error: This is an error [500]"
    }
  ]


try
  Munit.run(new ErrorTest())
catch err
  log.error(err.stack)