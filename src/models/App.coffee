# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'playerScore', @get( 'playerHand' ).scores()
    @set 'dealerScore', @get( 'dealerHand' ).scores()
    @set 'winner', null

  updateScores: ->
    @set 'playerScore', @get( 'playerHand' ).scores()
    @set 'dealerScore', @get( 'dealerHand' ).scores()

  checkForWinner: ->
    if @get( 'dealerScore' ) > 21
      @set 'winner', 'Player'
      @alertWinner()
    else if @get( 'playerScore' ) > @get('dealerScore')
      @set 'winner', 'Player'
      @alertWinner()
    else
      @set 'winner', 'Dealer'
      @alertWinner()

  checkBust: ->
    if @get( 'playerScore' ) > 21
      @set 'winner', 'Dealer'
      @alertWinner()

  onStand: ->
    @get( 'dealerHand' ).at(0).flip()
    @updateScores()
    @trigger('render', @)
    setTimeout @startDealerTurn, 1000

  startDealerTurn: =>
    if @get( 'dealerScore' ) > 17
      @checkForWinner()
    else
      @dealerHits()

  alertWinner: ->
    winner = @get 'winner'
    reDeal = window.confirm "#{winner} wins!! Would you like to play again?"
    if reDeal
      if @get('deck').length < 10
        @set 'deck', new Deck()
      @set 'playerHand', @get('deck').dealPlayer()
      @set 'dealerHand', @get('deck').dealDealer()
      @updateScores()
      @set 'winner', null
      @trigger('render', @)

  dealerHits: =>
    @get( 'dealerHand' ).hit()
    @updateScores()
    @trigger('render', @)
    if @get( 'dealerScore' ) <= 17
      setTimeout @dealerHits, 1000
    else
      @checkForWinner()
