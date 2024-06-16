@tool
class_name Character extends Node2D

@export var max_health: int = 10
@export var starting_mana: int = 3
@export var base_armor: int = 0
@export var current_mana_cap: int = 3

var health: int = 10
var mana: int = 3
var armor: int = 0

func set_health_values(_health: int, _max_health: int):
	max_health = _max_health
	health = _health

func update_health_bar():
	if ($HealthBar as ProgressBar).max_value != max_health:
		($HealthBar as ProgressBar).max_value = max_health
	if ($HealthBar as ProgressBar).value != health:
		($HealthBar as ProgressBar).value = health
		
func update_armor_icon():
	$"Armor".visible = armor > 0
	$"Armor/Label".set_text(str(armor))

func spend_mana(amount: int):
	mana -= amount
	
func take_damage(amount: int):
	var damage = max(amount - armor, 0)
	health -= damage
	
func add_armor(amount: int):
	armor += amount

func start_turn():
	armor = 0
	mana = current_mana_cap
	
func reset():
	health = max_health
	mana = starting_mana
	armor = base_armor

# Called when the node enters the scene tree for the first time.
func _ready():
	reset()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_health_bar()
	update_armor_icon()
