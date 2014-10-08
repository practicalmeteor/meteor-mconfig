class LogTest

  infoSpy = {}
  fineSpy = {}
  fatalSpy = {}
  debugSpy = {}

  setup:(test)->
    infoSpy = sinon.spy(console,"info")
    fineSpy = sinon.spy(console,"debug")
    fatalSpy = sinon.spy(console,"error")


  testInfo:(test)->
    log.setLevel("INFO")
    msg = "Hey, I'm global"
    log.info msg
    expect(infoSpy.calledWith(msg)).to.be.ok
    expect(infoSpy.calledOnce).to.be.ok
    log.setLevel("SILENT")


  testFineWorks:(test)->
    log.setLevel("DEBUG")
    msg = "Hey, I'm fine"
    log.fine msg
    expect(fineSpy.calledWith(msg)).to.be.ok
    expect(fineSpy.calledOnce).to.be.ok
    fineSpy.restore()
    log.setLevel("SILENT")


  testFatalWorks:(test)->
    log.setLevel("DEBUG")
    msg = "Hey, I'm fatal"
    log.fatal msg
    expect(fatalSpy.calledWith(msg)).to.be.ok
    expect(fatalSpy.calledOnce).to.be.ok
    log.setLevel("SILENT")


  testFineEnterWorks:(test)->
    log.setLevel("TRACE")
    msg = "Hey, I'm fineEnter"
    log.fineEnter msg
    expect(fineSpy.calledWith(msg)).to.be.ok
    expect(fineSpy.calledOnce).to.be.ok
    log.setLevel("SILENT")


  tearDown:()->
    infoSpy.restore()
    fineSpy.restore()
    fatalSpy.restore()
#    debugSpy.restore()

Munit.run( new LogTest())