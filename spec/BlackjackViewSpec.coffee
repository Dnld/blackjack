assert = chai.assert

describe 'AppView', ->
  app = null
  view = null

  beforeEach ->
    window.alert = ->
      return
    app = new App()
    view = new AppView( model: app ) #.$el.appendTo 'body'

  describe 'AppView initialized properly', ->
    it 'has correct children elements', ->
      childrenArray = view.$el.children()
      assert.strictEqual childrenArray.length, 4
      assert.strictEqual $(childrenArray[0]).hasClass('hit-button'), true
      assert.strictEqual $(childrenArray[1]).hasClass('stand-button'), true
      assert.strictEqual $(childrenArray[2]).hasClass('player-hand-container'), true
      assert.strictEqual $(childrenArray[3]).hasClass('dealer-hand-container'), true

    it 'correctly registers button clicks', ->
      clickRegisters = false
      $(view.$el.children()[0]).on('click', -> clickRegisters = true)
      $(view.$el.children()[0]).trigger('click')
      