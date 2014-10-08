class Config

    getRootUrl:->
      if not @rootUrl
        @rootUrl = @getRequiredSetting("ROOT_URL")
      return @rootUrl
    
    
    
    getAppVersion:->
      return @appVersion




    isTesting:->
      if @testing is null
        if Meteor.settings and Meteor.settings.public.TESTING and Meteor.settings.public.TESTING is true
            @testing = true
        else
            @testing = false
      return @testing


    getAppType:()->
      if @appType is null
        @appType = @getSetting("APP_TYPE")
        @appType ?= "web"
      return @appType


    isWorkerApp:()->
      @getAppType() is "worker"


    isWebApp:()->
      @getAppType() is "web"


    #Search for a specific settings
    # Level of search
    #   - Meteor.settings
    #   - Meteor.settings.public
    #   - env vars
    # Usage
    # Meteor.settings = {
    #  test:{
    #    property: "value"
    #  }
    # }
    # lv.Settings.getSetting("test") // {property:"value"}
    # lv.Settings.getSetting("test.property") // "value"

    getSetting: (settingName, defaultValue = null)->

      setting = _.deep(Meteor.settings, settingName)
      setting ?= _.deep(Meteor.settings.public, settingName)
      setting ?= process?.env?[settingName]
      setting ?= defaultValue
      return setting


    # Search for a specific settings and throw a
    # ConfigError if the setting if not set
    getRequiredSetting: (settingName)->
      setting = @getSetting(settingName)
      if setting is null
        throw new lv.util.ConfigError settingName
      return setting


    getStoreDomain: ()->
      return @getRequiredSetting("services.shopify.storeDomain")


    # We use http
    getStoreUrl: (isHttps = false, domain = null)->
      domain  ?= @getStoreDomain()
      protocol = "http"
      if isHttps then protocol += "s"

      return protocol+'://' + domain



    setIsCreatingFixtureData:(value)->
      _isCreatingFixtureData = value

    isCreatingFixtureData:()->
      _isCreatingFixtureData

  @get: ->
    instance ?= new Settings()

lv.Settings = lv.util.SettingsSingleton.get()