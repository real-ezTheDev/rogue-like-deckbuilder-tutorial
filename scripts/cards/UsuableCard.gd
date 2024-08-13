class_name UsuableCard extends Node2D

signal mouse_entered(card: Card)
signal mouse_exited(card: Card)

var actions: Array[RefCounted]

@onready var card: Card = $Card
@onready var card_image: Sprite2D = $CardImage

func load_card_data(card_data: CardData):
	card.set_card_values(card_data.cost, card_data.name, card_data.description)
	card_image.set_texture(card_data.texture)
	for script in card_data.actions:
		var action_script = RefCounted.new()
		action_script.set_script(script)
		actions.push_back(action_script)

func highlight():
	$Card.highlight()

func unhighlight():
	$Card.unhighlight()

func get_cost() -> int:
	return $Card.card_cost

func _on_card_mouse_entered(card: Card):
	mouse_entered.emit(self)

func _on_card_mouse_exited(card: Card):
	mouse_exited.emit(self)
	
func activate(game_state: Dictionary):
	for action in actions:
		action.activate(game_state)
		
	
