class SettingsTest


  setup:->
    Meteor.settings.services ?= {}
    _.extend(Meteor.settings.services, (test: apiKey: "api"))
    _.extend(Meteor.settings.public.services, (test: apiKey: "api"))


  tests:[

    {
      name:"getSetting()"
      func:(test)->
        test.isNotNull lv.Settings.getSetting("ROOT_URL")
        test.notEqual lv.Settings.getSetting("ROOT_URL")
    },
    {
      name:"getSetting() - get nested property"
      func:(test)->
        val = lv.Settings.getSetting("services.test.apiKey")
        expect(val).to.equal(Meteor.settings.services.test.apiKey)

    },
    {
      name:"getSetting() - return null if the setting does not exits"
      func:(test)->
        test.isNull lv.Settings.getSetting("MAGIC_SETTING")
    },
    {
      name:"getSetting() - with default value that setting var does not exits"
      func:(test)->
        test.isTrue lv.Settings.getSetting("MAGIC_SETTING",true) # defaultValue = true
    },
    {
      name:"getSetting() - with default value that setting exits"
      func:(test)->
        test.isNotNull lv.Settings.getSetting("ROOT_URL",true) # defaultValue = true
        test.notEqual lv.Settings.getSetting("ROOT_URL",true),undefined
        expect(lv.Settings.getSetting("ROOT_URL",true)).to.be.a('string')
    },
    {
      name:"isCommandLineProgram()"
      func:(test)->
        test.isFalse lv.Settings.isCommandLineProgram()
    },
    {
      name:"getRequiredSetting() - Test with an exiting setting"
      func:(test)->
        test.isNotNull lv.Settings.getRequiredSetting("ROOT_URL"), "lv.Settings.getRequiredSetting() did not returned a value."
        test.notEqual lv.Settings.getRequiredSetting("ROOT_URL"), undefined, "lv.Settings.getRequiredSetting() did not returned a value."
    },
    {
      name:"getRequiredSetting() - Test throws if setting doesn't exist"
      func:(test)->
        thrownError = null
        try
          lv.Settings.getRequiredSetting("asd")
        catch err
          thrownError = err
        finally
          test.isNotNull thrownError, "lv.Settings.getRequiredSetting() should throw an exception if a bad argument is passed."
    },
    {
        name:"getRootUrl()"
        func: (test)->
          test.isNotNull lv.Settings.getRootUrl("ROOT_URL")
          test.isNotNull lv.Settings.rootUrl
    },

    {
        name:"isWorkerApp()"
        func: (test)->
          lv.Settings.appType = null
          Meteor.settings?.public?["APP_TYPE"] = "worker"
          test.isTrue lv.Settings.isWorkerApp()
    },

    {
        name:"isWebApp()"
        func: (test)->
          lv.Settings.appType = null
          delete Meteor.settings?.public?["APP_TYPE"]
          test.isTrue lv.Settings.isWebApp()
    }

    {
        name:"getStoreDomain()"
        func: ()->
          domain = lv.Settings.getStoreDomain()
          expect(domain).to.contain("lavaina")
    }

    {
        name:"getStoreUrl() - with domain and https"
        func: ()->
          url = lv.Settings.getStoreUrl( false, "lavaina")
          expect(url).to.contain("lavaina")
          expect(url).to.contain("http://")

          url = lv.Settings.getStoreUrl( true, "lavaina")
          expect(url).to.contain("lavaina")
          expect(url).to.contain("https://")


    }

  ]

Munit.run( new SettingsTest())
