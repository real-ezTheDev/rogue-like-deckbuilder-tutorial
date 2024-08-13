class_name PlayableDeck extends Resource

var cards: Array[CardWithID] = []

# Draw a top one card from the deck
func draw_card() -> CardWithID:
	return cards.pop_back()

# Shuffle the order of cards in the deck
func shuffle():
	cards.shuffle()
	
func peek_top() -> CardWithID:
	return cards.back()
	
func put_card_on_top(card: CardWithID):
	cards.push_back(card)
