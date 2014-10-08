TestMongoColl = new Meteor.Collection("TestMongoColl")

log = new ObjectLogger("MongoErrorTest")
data = {}
class MongoErrorTest

  suiteSetup: (test)->
    try
      log.enter("suiteSetUp")
    finally
      log.return()

  tests:[
    {
      name:"MongoErrorTest - Should be an instance of Error"
      func:(test)->
        try
          log.enter("Should be an instance of Error")
          TestMongoColl.insert({_id:"1"})
          TestMongoColl.insert({_id:"1"})
        catch err
          data.MongoError = new lv.util.MongoError(err)
        finally
          expect(data.MongoError).to.be.instanceof lv.util.MongoError
          expect(data.MongoError).to.be.instanceof lv.util.MongoError
          log.return()
    }
    
    
    {
      name:"MongoErrorTest - check properties"
      func:(test)->
        try
          log.enter "check properties"
          expect(lv.util.MongoError).to.have.property "Codes"
          expect(lv.util.MongoError.Codes).to.have.property "INSERT_DUPLICATE_KEY"
          expect(lv.util.MongoError.Codes).to.have.property "UPDATE_DUPLICATE_KEY"
        finally
          log.return()
    }
    {
      name:"MongoErrorTest - check trown error code"
      func:(test)->
        try
          log.enter "check error code"
          expect(data.MongoError.mongoError).to.have.property "code"
          expect(data.MongoError.mongoError.code).to.equal lv.util.MongoError.Codes.INSERT_DUPLICATE_KEY
        finally
          log.return()
    }
  ]

  suiteTearDown: (test)->
    try
      log.enter("suiteTearDown")
      TestMongoColl.remove({})
    finally
      log.return()

try
  Munit.run(new MongoErrorTest())
catch err
  log.error(err.stack)