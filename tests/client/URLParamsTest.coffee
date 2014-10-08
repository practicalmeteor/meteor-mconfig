describe 'URLParams', ->
  beforeAll ->

  afterAll ->
    spies.restoreAll()
    stubs.restoreAll()

  beforeEach ->

  it 'should set params to an empty json object if no query string is present', ->
    expect(URLParams.params).to.be.an 'object'
    expect(URLParams.params).to.be.empty

  it 'should parse params if query string is not empty', ->
    searchStub = sinon.stub()
    searchStub.returns('?p1=v1&p2=v2')
    spacejam.URLParams.getWindowLocationSearch = searchStub
    urlParams = new spacejam.URLParams()
    expect(urlParams.params).to.be.an 'object'
    expect(urlParams.params).to.have.keys ['p1', 'p2']
    expect(urlParams.params.p1).to.equal 'v1'
    expect(urlParams.params.p2).to.equal 'v2'

  it 'should support arrays for param values', ->
    searchStub = sinon.stub()
    searchStub.returns('?p1=v1&p2=v2&p2=v3')
    spacejam.URLParams.getWindowLocationSearch = searchStub
    urlParams = new spacejam.URLParams()
    expect(urlParams.params.p2).to.deep.equal ['v2', 'v3']

  it 'get - should return the value if the param exists or null if not', ->
    searchStub = sinon.stub()
    searchStub.returns('?p1=v1&p2=v2&p2=v3')
    spacejam.URLParams.getWindowLocationSearch = searchStub
    urlParams = new spacejam.URLParams()
    expect(urlParams.get('p1')).to.equal 'v1'
    expect(urlParams.get('p2')).to.deep.equal ['v2', 'v3']
    expect(urlParams.get('p3')).to.be.null
