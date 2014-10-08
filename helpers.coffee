class lv.helpers

  @CHECK_INTERVAL: 100


  @user :
    services:
      facebook:
          id: "100006190087145"
          email: "vainero_qsarrvc_one@tfbnw.net"
          name: "Vainero One"
          first_name: "Vainero"
          last_name: "One"
          link: "http://www.facebook.com/profile.php?id=100006190087145"
          gender: "female"
          locale: "en_US"



  @waitFor: (func, msg, timeout, cb)->
    initTime = new Date().getTime()
    if func() is true
      cb(null, true)
      return

    timeOutHandler = setInterval (->
      if func() is true
        clearTimeout( timeOutHandler )
        cb(null, true)
      currentTime = new Date().getTime()
      if ( currentTime - initTime >= timeout)
        clearTimeout( timeOutHandler )
        cb( msg, false)
    ), @CHECK_INTERVAL



  #TODO test
  #see http://meteorhacks.com/extending-meteor-accounts.html
  @simulateAppLogin:(user = @.user,callback)->
    Accounts.callLoginMethod
      methodArguments: [user]
      userCallback: callback



# if Meteor.isServer
#   Accounts.registerLoginHandler (user) ->
#     userId = null
#     usr = Meteor.users.findOne('services.facebook.id': user.services.facebook.id)
#     unless usr
#       userId = Meteor.users.insert(user)
#     else
#       userId = usr._id
#     stampedToken = Accounts._generateStampedLoginToken();
#     Meteor.users.update userId,
#       $push:
#         "services.resume.loginTokens": stampedToken

#     #send loggedin user's user id
#     id: userId
#     token:stampedToken
