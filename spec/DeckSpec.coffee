assert = chai.assert

describe 'deck', ->
  deck = null
  playerHand = null
  dealerHand = null

  beforeEach ->
    deck = new Deck()
    playerHand = deck.dealPlayer()
    dealerHand = deck.dealDealer()

  describe "deck constructor", ->
    it "should create a card collection", ->
      collection = new Deck()
      assert.strictEqual collection.length, 52

  describe 'hit', ->
    it 'should give the last card from the deck', ->
      assert.strictEqual deck.length, 48
      takenFromDeck = deck.last()
      playerHand.hit()
      assert.strictEqual takenFromDeck, playerHand.last()
      assert.strictEqual deck.length, 47

  describe 'deal', ->
    it 'should deal two cards initially to player and dealer', ->
      assert.strictEqual playerHand.length, 2
      assert.strictEqual dealerHand.length, 2
    it 'should conceal only the dealer\'s first card', ->
      assert.strictEqual dealerHand.first().get( 'revealed' ), false
      assert.strictEqual dealerHand.at(1).get( 'revealed' ), true
      dealerHand.hit()
      assert.strictEqual dealerHand.length, 3
      assert.strictEqual dealerHand.at(2).get( 'revealed' ), true
    it 'should reveal all the player\'s cards', ->
      assert.strictEqual playerHand.first().get( 'revealed' ), true
      assert.strictEqual playerHand.at(1).get( 'revealed' ), true
