class_name PlayableDeckUI extends TextureButton

var deck: PlayableDeck

func draw() -> CardWithID:
	return deck.draw_card()
