if Meteor.isServer
  Fiber = Npm.require('fibers')

  Tinytest.addAsync "helpers - waitFor - Test with addAsync - test waitFor when function never returns true", (test, done) ->
    testVariable = false

    lv.helpers.waitFor(
      ->
        return testVariable
      "testVariable is false"
      300
      (err, res)=>
        Fiber(->
          test.isFalse res
          done()
        ).run()
     )



  Tinytest.addAsync "helpers - waitFor - Test with addAsync - test waitFor when function returns true the first time it is called", (test, done) ->
    testVariable = true

    lv.helpers.waitFor(
      ->
        return testVariable
      "testVariable is false"
      300
      (err, res)=>
        Fiber(->
          test.isTrue res
          done()
        ).run()
      )


  Tinytest.addAsync "helpers - waitFor - Test with addAsync - test waitFor when function returns true", (test, done) ->
    testVariable = false
    setTimeout  (->
      testVariable = true
    ), 100

    lv.helpers.waitFor(
      ->
        return testVariable
      "testVariable is false"
      300
      (err, res)=>
        Fiber(->
          test.isTrue res
          done()
        ).run()
      )


#TODO: Test waitFor with testAsyncMulti in server

  # testAsyncMulti "helpers - waitFor - Test with testAsyncMulti - test testAsyncMulti when function never returns true", [
  #   (test, expect)->
  #     testVariable = false
  #     lv.helpers.waitFor(
  #       ->
  #         return testVariable
  #       "testVariable is false"
  #       300
  #       expect (err, res)=>
  #         test.isFalse res
  #       )
  # ]


  # testAsyncMulti "helpers - waitFor - Test with testAsyncMulti - test waitFor when function returns true the first time it is called", [
  #   (test, expect)->
  #     testVariable = true
  #     lv.helpers.waitFor(
  #       ->
  #         return testVariable
  #       "testVariable is false"
  #       300
  #       Fiber(-> expect (err, res)=>
  #           test.isTrue res
  #         ).run()
  #       )
  # ]


  # testAsyncMulti "helpers - waitFor - Test with testAsyncMulti - test waitFor when function returns true", [
  #   (test, expect)->
  #     testVariable = false
  #     setTimeout  (->
  #       testVariable = true
  #     ), 100

  #     lv.helpers.waitFor(
  #       ->
  #         return testVariable
  #       "testVariable is false"
  #       300
  #       expect (err, res)=>
  #         test.isTrue res
  #       )
  # ]




if Meteor.isClient
  Tinytest.addAsync "helpers - waitFor - Test with addAsync - test waitFor when function never returns true", (test, done) ->
    testVariable = false

    lv.helpers.waitFor(
      ->
        return testVariable
      "testVariable is false"
      300
      (err, res)=>
        test.isFalse res
        done()
      )



  # Tinytest.addAsync "helpers - waitFor - Test with addAsync - test waitFor when function returns true the first time it is called", (test, done) ->
  #   testVariable = true

  #   lv.helpers.waitFor(
  #     ->
  #       return testVariable
  #     "testVariable is false"
  #     300
  #     (err, res)=>
  #       test.isTrue res
  #       done()
  #     )


  Tinytest.addAsync "helpers - waitFor - Test with addAsync - test waitFor when function returns true", (test, done) ->
    testVariable = false
    setTimeout  (->
      testVariable = true
    ), 100

    lv.helpers.waitFor(
      ->
        return testVariable
      "testVariable is false"
      300
      (err, res)=>
        test.isTrue res
        done()
      )

  testAsyncMulti "helpers - waitFor - Test with testAsyncMulti - test testAsyncMulti when function never returns true", [
    (test, expect)->
      testVariable = false
      lv.helpers.waitFor(
        ->
          return testVariable
        "testVariable is false"
        300
        expect (err, res)=>
          test.isFalse res
        )
  ]


  # testAsyncMulti "helpers - waitFor - Test with testAsyncMulti - test waitFor when function returns true the first time it is called", [
  #   (test, expect)->
  #     testVariable = true
  #     lv.helpers.waitFor(
  #       ->
  #         return testVariable
  #       "testVariable is false"
  #       300
  #       expect (err, res)=>
  #         test.isTrue res
  #       )
  # ]


  testAsyncMulti "helpers - waitFor - Test with testAsyncMulti - test waitFor when function returns true", [
    (test, expect)->
      testVariable = false
      setTimeout  (->
        testVariable = true
      ), 100

      lv.helpers.waitFor(
        ->
          return testVariable
        "testVariable is false"
        300
        expect (err, res)=>
          test.isTrue res
        )
  ]

# helpers - simulateAppLogin

#if Meteor.isClient
  #Tinytest.addAsync "helpers - simulateAppLogin",(test,done)->
    #user = lv.helpers.user
    #lv.helpers.simulateAppLogin user,(err,res)->
      #test.isUndefined err, "there was an error while login"
      #test.isNotNull Meteor.user(), "can't login to application"
      #done()