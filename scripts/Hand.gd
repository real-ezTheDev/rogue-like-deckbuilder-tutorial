@tool
class_name Hand extends Node2D

@export var hand_radius: int = 1000
@export var card_angle: float = -90
@export var angle_limit: float = 25
@export var max_card_spread_angle: float = 5

@onready var test_card = $TestCard
@onready var collision_shape: CollisionShape2D = $DebugShape

var hand: Array = []
var touched: Array = []
var current_selected_card_index: int = -1

func add_card(card: Node2D):
	hand.push_back(card)
	add_child(card)
	card.mouse_entered.connect(_handle_card_touched)
	card.mouse_exited.connect(_handle_card_untouched)
	reposition_cards()
	
func remove_card(index: int) -> Node2D:
	var removing_card = hand[index]
	hand.remove_at(index)
	touched.remove_at(touched.find(removing_card))
	remove_child(removing_card)
	reposition_cards()
	return removing_card
	
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

func _handle_card_touched(card):
	touched.push_back(card)

func _handle_card_untouched(card):
	touched.remove_at(touched.find(card))

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("mouse_click") && current_selected_card_index >= 0:
		var card = remove_card(current_selected_card_index)
		current_selected_card_index = -1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for card in hand:
		current_selected_card_index = -1
		card.unhighlight()

	if !touched.is_empty():
		var highest_touched_index: int = -1
		
		for touched_card in touched:
			highest_touched_index = max(highest_touched_index, hand.find(touched_card))
		
		if highest_touched_index >= 0 && highest_touched_index < hand.size():
			hand[highest_touched_index].highlight()
			current_selected_card_index = highest_touched_index
	
	#tool logic
	if (collision_shape.shape as CircleShape2D).radius != hand_radius:
		(collision_shape.shape as CircleShape2D).set_radius(hand_radius)
		
	test_card.set_position(get_card_position(card_angle))
	test_card.set_rotation(deg_to_rad(card_angle + 90))
	
