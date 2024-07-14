extends Node2D

@export var player_character: Character 

@onready var game_control: GameController = $GameController
@onready var deck_view_overlay: DeckViewWindow = $CanvasLayer/DeckViewWindow as DeckViewWindow

var enemy_character_state: int = 0

@onready var deck: Deck = Deck.new()

func restart_game():
	game_control.current_state = GameController.GameState.PLAYER_TURN
	$GameScreen/PlayerCharacter.reset()
	$GameScreen/EnemyCharacter.reset()
	$DeckNHand.reset()

# Called when the node enters the scene tree for the first time.
func _ready():
	$DeckNHand.deck = deck

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !game_control.is_running:
		return

	$ManaAmount.set_text(str($GameScreen/PlayerCharacter.mana))
	
	if $GameScreen/PlayerCharacter.health <= 0:
		game_control.transition(GameController.GameState.GAMEOVER)
	elif $GameScreen/EnemyCharacter.health <= 0:
		game_control.transition(GameController.GameState.VICTORY)
	
	if game_control.current_state == GameController.GameState.ENEMY_TURN:
		#ai logic
		if enemy_character_state == 0:
			$GameScreen/EnemyCharacter.add_armor(0)
			$GameScreen/PlayerCharacter.take_damage(3)
		elif enemy_character_state == 1:
			$GameScreen/EnemyCharacter.add_armor(1)
			$GameScreen/PlayerCharacter.take_damage(2)
		elif enemy_character_state == 2:
			$GameScreen/EnemyCharacter.add_armor(2)
			$GameScreen/PlayerCharacter.take_damage(1)
		
		enemy_character_state = posmod(enemy_character_state + 1, 3)
		game_control.transition(GameController.GameState.PLAYER_TURN)
		$GameScreen/PlayerCharacter.start_turn()
		
	if game_control.current_state == GameController.GameState.VICTORY:
		$CanvasLayer/VictoryOverlay.visible = true
	else:
		$CanvasLayer/VictoryOverlay.visible = false
		
	if game_control.current_state == GameController.GameState.GAMEOVER:
		$CanvasLayer/GameOverOverlay.visible = true
	else:
		$CanvasLayer/GameOverOverlay.visible = false

func _input(event):
	if event.is_action("restart"):
		restart_game()

func _on_deck_n_hand_card_activated(card: UsuableCard):
	
	var card_cost: int = card.get_cost()
	
	if card_cost <= $GameScreen/PlayerCharacter.mana:
		card.activate({
			"caster": $GameScreen/PlayerCharacter,
			"targets": [$GameScreen/EnemyCharacter]
		})
		$DeckNHand.remove_card(card)
		card.queue_free()
	else:
		pass

func _on_inflict_one_button_pressed():
	player_character.take_damage(1)
	pass # Replace with function body.

func _on_inflict_three_button_pressed():
	player_character.take_damage(3)
	pass # Replace with function body.

func _on_end_turn_pressed():
	if game_control.current_state == GameController.GameState.PLAYER_TURN:
		game_control.transition(GameController.GameState.ENEMY_TURN)
		$GameScreen/EnemyCharacter.start_turn()

func _on_deck_button_pressed():
	game_control.pause()
	deck_view_overlay.visible = true
	deck_view_overlay.display_card_list(deck.get_cards())
