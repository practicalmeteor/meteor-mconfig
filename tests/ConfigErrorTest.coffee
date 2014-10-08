throwError = (msg)->
  log.debug "ConfigError:throwError()"
  throw new lv.util.ConfigError(msg)


if Meteor.isServer
  Meteor.methods
    throwConfigErrorFromMethod: ->
      log.debug "ErrorTest.throwConfigErrorFromMethod()"
      throwError("EnvVar")


class ConfigErrorTest
  self = @

  constructor: ->
    log.debug "ConfigErrorTest.constructor()"
    self = @

  tests:[
    {
      name:"ConfigErrorTest - Should be an instance of Error"
      func:(test)->
        log.debug "ErrorTest - Should be an instance of Error"
        configError = new lv.util.ConfigError("EnvVar")
        expect(configError).to.be.instanceof lv.util.ConfigError
    },
    {
      name:"ConfigErrorTest - check properties"
      func:(test)->
        log.debug "ErrorTest - check properties"
        configError = new lv.util.ConfigError("EnvVar")
        expect(configError).to.have.property "message"
        expect(configError.message).to.equal "lv.util.ConfigError: Missing EnvVar setting or enviroment variable."
    },
    {
      name:"ConfigErrorTest - throw"
      func:(test)=>
        log.debug "ErrorTest - throw"
        thrownError = null
        try
          throwError("EnvVar")
        catch err
          thrownError = err
          expect(thrownError).to.be.instanceof lv.util.ConfigError
        finally
          expect(thrownError).not.to.be.null
    },
    {
      name:"ConfigErrorTest - sanitizedError - throw in meteor method"
      type:"client",
      skip:true,
      func:(test,onComplete)->
        log.debug "ErrorTest - throw in meteor method"
        Meteor.call "throwConfigErrorFromMethod", onComplete (err,res)->
          expect(err).to.have.property "message"
          expect(err.message).to.equal "lv.util.ConfigError: Missing EnvVar setting or enviroment variable. [500]"
    }
  ]


try
  Munit.run(new ConfigErrorTest())
catch err
  log.error(err.stack)