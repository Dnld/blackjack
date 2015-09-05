class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': ->
      @model.get('playerHand').hit()
      @model.updateScores()
      @render()
      @model.checkForWinner()
    'click .stand-button': ->
      # @model.set('dealerTurn', true)
      # @model.get('playerHand').stand()
      @model.checkForWinner()
      @model.dealerHits()

  initialize: ->
    @render()
    @model.on 'render', => @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get( 'playerHand' ), model: @model).el
    @$('.dealer-hand-container').html new HandView(collection: @model.get( 'dealerHand' ), model: @model).el
    return
