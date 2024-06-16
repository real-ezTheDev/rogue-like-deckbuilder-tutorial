extends Node2D

func activate(game_state: Dictionary):
	var caster: Character = game_state.get("caster")
	caster.add_armor(1)
	caster.spend_mana(1)

