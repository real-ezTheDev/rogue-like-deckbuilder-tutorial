extends Node2D

func activate(game_state: Dictionary):
	#spend cost
	game_state.get("caster").spend_mana(1)
	#damage 1
	game_state.get("targets")[0].take_damage(1)

