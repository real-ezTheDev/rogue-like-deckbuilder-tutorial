extends Node2D

@onready var attack_card_scene: PackedScene = preload("res://scenes/cards/AttackCard.tscn")
@onready var defend_card_scene: PackedScene = preload("res://scenes/cards/DefendCard.tscn")

@onready var hand: Hand = $CanvasLayer/Hand
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	var attack_card = attack_card_scene.instantiate()
	hand.add_card(attack_card)


func _on_button_2_pressed():
	var defend_card = defend_card_scene.instantiate()
	hand.add_card(defend_card)
