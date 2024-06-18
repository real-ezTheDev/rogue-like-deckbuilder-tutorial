@tool
class_name Card extends Node2D

signal mouse_entered(card: Card)
signal mouse_exited(card: Card)
signal card_activated(card : Card)

@export var card_name: String = "Card Name"
@export var card_description: String = "Card Description"
@export var card_cost: int = 1
@export var card_image: Sprite2D

@onready var cost_lbl: Label = $CostDisplay/CostLbl
@onready var name_lbl: Label = $CardName/NameLbl
@onready var description_lbl: Label = $CardDescription 
@onready var base_sprite: Sprite2D = $BaseCardSprite
func _ready():
	set_card_values(card_cost, card_name, card_description)
	
func set_card_values(_cost: int, _name: String, _description: String):
	card_name = _name
	card_description = _description
	card_cost = _cost

	_update_graphics()
	
# graphics components update to match the data
func _update_graphics():
	if cost_lbl.get_text() != str(card_cost):
		cost_lbl.set_text(str(card_cost))
	if name_lbl.get_text() != card_name:
		name_lbl.set_text(card_name)
	if description_lbl.get_text() != card_description:
		description_lbl.set_text(card_description)
		
func highlight():
	base_sprite.set_modulate(Color(1, 0.5, 0.1, 1))

func unhighlight():
	base_sprite.set_modulate(Color(1,1,1,1))

func activate():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_update_graphics()


func _on_mouse_entered():
	highlight()
	mouse_entered.emit(self)


func _on_mouse_exited():
	unhighlight()
	mouse_exited.emit(self)


func _on_card_interacted_with():
	card_activated.emit(self)
