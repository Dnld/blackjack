assert = chai.assert

describe 'the main app model', ->
  app = null
  playerHand = null
  dealerHand = null
  window.alert = ->
    return

  beforeEach ->
    app = new App()
    playerHand = app.get 'playerHand'
    dealerHand = app.get 'dealerHand'

  it 'When player goes over 21, dealer wins', ->
    app.set( 'playerScore', 22 )
    app.checkForWinner()
    assert.strictEqual app.get('winner'), 'Dealer'

  it 'When dealer score is less than player score, player wins', ->
    app.set( 'dealerScore', 15 )
    app.set( 'playerScore', 18 )
    app.set( 'gameOver', true )
    app.checkForWinner()
    assert.strictEqual app.get('winner'), 'Player'

  it 'When dealer score is greater than player score, dealer wins', ->
    app.set( 'dealerScore', 18 )
    app.set( 'playerScore', 15 )
    app.set( 'gameOver', true )
    app.checkForWinner()
    assert.strictEqual app.get('winner'), 'Dealer'
