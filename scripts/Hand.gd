@tool
class_name Hand extends Node2D

signal card_activated(card: UsuableCard)

@export var hand_radius: int = 1000
@export var card_angle: float = -90
@export var angle_limit: float = 25
@export var max_card_spread_angle: float = 5

@onready var test_card = $TestCard
@onready var collision_shape: CollisionShape2D = $DebugShape

var hand: Array = []

func empty_hand():
	for card in hand:
		card.queue_free()
	hand = []

func add_card(card):
	hand.push_back(card)
	add_child(card)
	card.card_activated.connect(_on_card_activated)
	reposition_cards()
	
func remove_card(index: int) -> Node2D:
	var removing_card = hand[index]
	hand.remove_at(index)
	remove_child(removing_card)
	reposition_cards()
	return removing_card
	
func remove_card_by_entity(card: Node2D):
	var remove_index = hand.find(card)
	remove_card(remove_index)
	
func reposition_cards():
	var card_spread = min(angle_limit / hand.size(), max_card_spread_angle)
	var current_angle = -(card_spread * (hand.size() - 1))/2 - 90
	for card in hand :
		_update_card_transform(card, current_angle)
		current_angle += card_spread

func get_card_position(angle_in_deg: float) -> Vector2:
	var x: float = hand_radius * cos(deg_to_rad(angle_in_deg))
	var y: float = hand_radius * sin(deg_to_rad(angle_in_deg))
	
	return Vector2(int(x), int(y))
	
func _update_card_transform(card: Node2D, angle_in_drag: float):
	card.set_position(get_card_position(angle_in_drag))
	card.set_rotation(deg_to_rad(angle_in_drag + 90))


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_card_activated(card):
	card_activated.emit(card)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#tool logic
	if (collision_shape.shape as CircleShape2D).radius != hand_radius:
		(collision_shape.shape as CircleShape2D).set_radius(hand_radius)
		
	test_card.set_position(get_card_position(card_angle))
	test_card.set_rotation(deg_to_rad(card_angle + 90))
	
