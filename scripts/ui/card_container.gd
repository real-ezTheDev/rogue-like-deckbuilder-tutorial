class_name CardContainer extends Container

const CARD_COMPONENT_POSITION: Vector2 = Vector2(43,64)
@onready var usuable_card_scn = preload("res://scenes/cards/UsuableCard.tscn")

var usuable_card: UsuableCard

var card: CardData:
	set(_card):
		if !is_node_ready():
			await ready
		card = _card
		usuable_card = usuable_card_scn.instantiate()
		add_child(usuable_card)
		usuable_card.set_position(CARD_COMPONENT_POSITION)
		usuable_card.load_card_data(card)
