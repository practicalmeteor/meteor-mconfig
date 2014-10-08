mongoErrorCtor = (@mongoError,@message="") ->
  expect(@mongoError).to.be.an "object"
  expect(@mongoError).to.have.property "message"

  @message = "lv.util.MongoError:#{@message} #{JSON.stringify(@mongoError)}"
  @sanitizedError = new Meteor.Error 500,@message

lv.util.MongoError = Meteor.makeErrorType "lv.util.MongoError", mongoErrorCtor

###
# @see:http://www.mongodb.org/about/contributors/error-codes/
###
lv.util.MongoError.Codes =
  INSERT_DUPLICATE_KEY: 11000
  UPDATE_DUPLICATE_KEY: 11001
###
10003	objects in a capped ns cannot grow
12000	idxNo fails	an internal error
12001	can’t sort with $snapshot	the $snapshot feature does not support sorting yet
12010, 12011, 12012	can’t $inc or $set an indexed field
13312	replSet error : logOp() but not primary?	Fixed in v2.0. Report if seen v2.0+
13440	bad offset accessing a datafile	Run a database –repair. If journaling is on this shouldn’t happen.
###