# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'playerScore', @get( 'playerHand' ).scores()
    @set 'dealerScore', @get( 'dealerHand' ).scores()

  updateScores: ->
    @set 'playerScore', @get( 'playerHand' ).scores()
    @set 'dealerScore', @get( 'dealerHand' ).scores()

