spacejam = {}

class spacejam.URLParams

  instance = null

  @get: ->
    instance ?= new URLParams()

  params: {}

  constructor: ()->
    @params = queryString.parse spacejam.URLParams.getWindowLocationSearch()

  # Design for testability. We cannot stub window.location, since it goes into an infinite
  # reload loop, so we create a function that we can stub. That is also why this method is static.

  @getWindowLocationSearch: ()->
    if window.location.search then window.location.search else ''

  get: (paramName)->
    if @params[paramName] then @params[paramName] else null


URLParams = spacejam.URLParams.get()
