class_name Deck extends Resource

var card_collection: Dictionary = {}
var id_counter: int = 0

func add_card(card: CardData):
	var card_id = _generate_card_id(card)
	card_collection[card_id] = CardWithID.new(card_id, card)
	id_counter += 1

func remove_card(card_id: int):
	card_collection.erase(card_id)

func update_card(card_id: String, card: CardData):
	card_collection[card_id] = card

func get_cards() -> Array[CardWithID]:
	var cards: Array[CardWithID] = []
	if !card_collection.is_empty():
		for card in card_collection.values():
			var duplicate_card_with_id: CardWithID = CardWithID.new(card.id, card.card.duplicate())
			cards.push_back(duplicate_card_with_id)
	
	return cards

func get_playable_deck() -> PlayableDeck:
	var playable_deck = PlayableDeck.new()
	playable_deck.cards = get_cards()
	return playable_deck

func _generate_card_id(card: CardData):
	return id_counter
