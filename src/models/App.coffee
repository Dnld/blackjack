# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'playerScore', @get( 'playerHand' ).scores()
    @set 'dealerScore', @get( 'dealerHand' ).scores()
    # @set 'dealerTurn', false
    @set 'gameOver', false
    @set 'revealed', true

  updateScores: ->
    @set 'playerScore', @get( 'playerHand' ).scores()
    @set 'dealerScore', @get( 'dealerHand' ).scores()

  checkForWinner: ->
    if @get( 'gameOver' )
      if @get( 'playerScore' ) > @get('dealerScore')
        window.alert('player wins')
      else
        window.alert('dealer wins')

    if @get( 'playerScore' ) > 21
      window.alert 'dealer wins'
    else if @get( 'dealerScore' ) > 21
      window.alert 'player wins'
      @set 'gameOver', true

  dealerHits: ->
    @get( 'dealerHand' ).at(0).flip()
    @updateScores()
    @trigger('render', @)

    while( not @get( 'gameOver' ) )
      if @get( 'dealerScore' ) < 17
        @get( 'dealerHand' ).hit();
      else
        @set 'gameOver', true

      @updateScores()
      @trigger('render', @)
      @checkForWinner()
