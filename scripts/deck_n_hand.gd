extends Node2D

signal card_activated(card: UsuableCard)

@export var deck: Deck

@onready var attack_card_scene: PackedScene = preload("res://scenes/cards/AttackCard.tscn")
@onready var defend_card_scene: PackedScene = preload("res://scenes/cards/DefendCard.tscn")

@onready var hand: Hand = $Hand
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func reset():
	$Hand.empty_hand()
	
func remove_card(card: Node2D):
	$Hand.remove_card_by_entity(card)

func _on_button_pressed():
	var attack_card = attack_card_scene.instantiate()
	deck.add_card(attack_card)

func _on_button_2_pressed():
	var defend_card = defend_card_scene.instantiate()
	deck.add_card(defend_card)

func _on_hand_card_activated(card):
	card_activated.emit(card)

func _on_button_3_pressed():
	if deck.get_cards().is_empty():
		return
	
	var random_card: CardWithID = deck.get_cards().pick_random()
	deck.remove_card(random_card.id)
