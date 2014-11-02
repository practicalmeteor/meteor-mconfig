@practical ?= {}

class practical.Config
  envVarPrefix: ''

  constructor: (@settingsPath = '')->
    expect(@settingsPath).to.be.a 'string'
    if @settingsPath.length > 0
      @envVarPrefix = Config.environmentalize(@settingsPath);


  @environmentalize: (str)->
    return _s.environmentalize(str).replace('.', '_');


  get: (settingName, defaultValue = null)->
    if Meteor.isServer
      value = process.env[_getEnvVarName(settingName)]
    else
      value = URLParams.get(settingName)

    value ?= _.deep(Meteor.settings, settingName) if Meteor.isServer

    value ?= _.deep(Meteor.settings.public, settingName)
    value ?= defaultValue
    return value


  # Search for a specific settings and throw a
  # ConfigError if the setting is not set
  getRequired: (settingName)->
    value = @get(settingName)
    throw new ConfigError settingName if not value
    return value


  _getEnvVarName: (settingName)->
    envVarName = spacejam.Config.environmentalize()
    if envVarPrefix then envVarPrefix + '_' + envVarName else envVarName
