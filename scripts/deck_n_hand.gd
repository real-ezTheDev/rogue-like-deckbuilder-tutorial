extends Node2D

signal card_activated(card: UsuableCard)

@export var deck: Deck
@export var debug_mode: bool =  true:
	set(value):
		if !is_node_ready():
			await ready

		debug_mode = value
		$Button.visible = debug_mode
		$Button2.visible = debug_mode
		$Button3.visible = debug_mode

@onready var attack_card_data: CardData = preload("res://card_data/attack_card.tres")
@onready var defend_card_data: CardData = preload("res://card_data/defend_card.tres")

@onready var hand: Hand = $Hand
# Called when the node enters the scene tree for the first time.

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func reset():
	$Hand.empty_hand()

func add_card(card_with_id: CardWithID):
	$Hand.add_card(card_with_id.card)

func remove_card(card: Node2D):
	$Hand.remove_card_by_entity(card)

func _on_button_pressed():
	deck.add_card(attack_card_data.duplicate())

func _on_button_2_pressed():
	deck.add_card(defend_card_data.duplicate())

func _on_hand_card_activated(card):
	card_activated.emit(card)

func _on_button_3_pressed():
	if deck.get_cards().is_empty():
		return
	
	var random_card: CardWithID = deck.get_cards().pick_random()
	deck.remove_card(random_card.id)
