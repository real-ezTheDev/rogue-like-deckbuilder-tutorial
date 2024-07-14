class_name GameController extends Node2D

var is_running: bool = true

enum GameState {
	PLAYER_TURN,
	ENEMY_TURN,
	GAMEOVER,
	VICTORY,
}

@onready var current_state: GameState = GameState.PLAYER_TURN

func pause():
	is_running = false

func resume():
	is_running = true

func transition(next_state: GameState):
	match current_state:
		GameState.PLAYER_TURN:
			pass
		GameState.ENEMY_TURN:
			pass
		GameState.GAMEOVER:
			pass
		GameState.VICTORY:
			pass
	
	current_state = next_state
	
	match current_state:
		GameState.PLAYER_TURN:
			pass
		GameState.ENEMY_TURN:
			pass
		GameState.GAMEOVER:
			pass
		GameState.VICTORY:
			pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
