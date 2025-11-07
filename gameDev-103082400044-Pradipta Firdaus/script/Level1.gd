extends Node2D

@onready var player = $Player
@onready var transition_screen = $TransitionScreen
@onready var transition_animation = $TransitionScreen/AnimationPlayer

func _ready() -> void:
	transition_screen.show()
	transition_animation.play("fade_to_normal")
	await  get_tree().create_timer(2.0).timeout
	transition_screen.hide()

func _process(delta: float) -> void:
	#print(player.position.y >= 110)
	#print("PLAYER POSITION: " , player.position)
	if player.position.y >= 465:
		GameEvent.player_death.emit()
		
	if player.position.x >=370:
		set_process(false)
		transition_screen.show()
		transition_animation.play("fade_to_black")
		await  get_tree().create_timer(2.0).timeout
		transition_screen.hide()
		$WinScreen.show()
		await  get_tree().create_timer(2.0).timeout
		get_tree().reload_current_scene()
		
		
