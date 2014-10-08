
if Meteor.isServer
  Meteor.methods
    'util/getServerDate': ->
      return new Date()

lv.util.isNumber = (obj) ->
  if obj is 0 or obj is '0'
    return true
  Number(obj) # if not a number return NaN

lv.util.isTrue = (obj)->
  obj is true

lv.util.isFalse = (obj)->
  obj is false

lv.util.trim = (str)->
  str.replace(/^\s+|\s+$/g, "")

###
  @param num
  @param padSize
  @example
    num = 5
    padSize = 3
    lv.util.padZeros(num,padSize) -> '005'
###
lv.util.padZeros = (num, padSize)->
  # check num, Match.Where(lv.util.isNumber)
  check padSize, Number

  numOfZeros = padSize - num.toString().length + 1
  Array(+(numOfZeros > 0 && numOfZeros)).join("0") + num

lv.util.capitalize = (s)->
  s.charAt(0).toUpperCase() + s.slice(1)

# TODO: Use server date
lv.util.daysDiff = (date1,date2)->
  _date1 = moment(date1)
  _date2 = moment(date2)
  daysBetweenFirstAndSecondDate = _date2.diff(_date1,"days")
  return Math.abs daysBetweenFirstAndSecondDate


if Meteor.isServer

  # Handle async functions in server
  # https://gist.github.com/possibilities/3443021
  # https://www.eventedmind.com/feed/49CkbYeyKoa7MyH5R
  lv.util.bindEnvironment = (func)->
    Meteor.bindEnvironment func, -> # On bindEnvironment Error
      log.error "Failed to bind environment", arguments
      throw new lv.util.Error("Failed to bind environment")


  # To get an asset from the meteor app use Assets.getText( <path> ) instead.
  lv.util.getDataFromFile = (filePath)->
    try
      log.enter("getDataFromFile", arguments)
      expect(filePath).to.be.a("string")
      fs = Npm.require('fs')
      returnedData = JSON.parse fs.readFileSync(filePath,'utf8')
      return returnedData
    finally
      log.return()


if Meteor.isClient
  lv.util.isMobile =
    isAndroid: ->
      navigator.userAgent.match /Android/i

    isBlackBerry: ->
      navigator.userAgent.match /BlackBerry/i

    isiOS: ->
      navigator.userAgent.match /iPhone|iPad|iPod/i

    isOpera: ->
      navigator.userAgent.match /Opera Mini/i

    isWindowsPhone: ->
      navigator.userAgent.match /IEMobile/i

    any: ->
      if lv.util.isMobile.isAndroid() or lv.util.isMobile.isBlackBerry() or lv.util.isMobile.isiOS() or lv.util.isMobile.isOpera() or lv.util.isMobile.isWindowsPhone()
        return true
      else
        return false


  lv.util.getServerDate = (cb)->
    Meteor.call "util/getServerDate",cb


  lv.util.createModalMsg = (title,message)->
    expect(title).to.be.a("string")
    expect(message).to.be.a("string")
    id = Random.id()
    modal ="<div id=\"#{id}\"class='modal fade lvModalDialog'>
        <div class='modal-dialog'>
            <div class='modal-content'>
                <div class='modal-header'>
                    <button type='button' class='close' data-dismiss='modal' aria-hidden='true'>&times;</button>
                    <h3 class='modal-title'>#{title}</h3>
                </div>
                <div class='modal-body'>
                    #{message}
                </div>
                <div class='modal-footer'>
                    <button type='button' class='btn btn-danger' data-dismiss='modal'>Cerrar</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>"
    div = document.createElement("div")
    div.innerHTML = modal
    document.body.appendChild div
    $("##{id}").modal "show"
    $("##{id}").on "hidden.bs.modal", (e) ->
      $("##{id}").remove()




  lv.util.getQueryStrings = ->
    assoc = {}
    decode = (s) ->
      decodeURIComponent s.replace(/\+/g, " ")

    queryString = location.search.substring(1)
    keyValues = queryString.split("&")
    for i of keyValues
      key = keyValues[i].split("=")
      assoc[decode(key[0])] = decode(key[1])  if key.length > 1
    return assoc

  lv.util.getQueryString = (key)->
    expect(key).to.be.a("string")
    return (lv.util.getQueryStrings())[key]


