extends CharacterBody2D

@export var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animasi = $AnimatedSprite2D
@onready var transition_screen = $"../TransitionScreen"
@onready var transition_animation = $"../TransitionScreen/AnimationPlayer"

const WALK_SPEED: float = 100.0
const JUMP_SPEED: float = -400.0
const START_POSITION = Vector2(163.0, 148.0)

func _ready() -> void:
	GameEvent.player_death.connect(player_death)
	self.position = START_POSITION
	
func player_death():
	print("Player Death")
	set_process(false)
	self.position = START_POSITION
	transition_screen.show()
	transition_animation.play("fade_to_normal")
	await  get_tree().create_timer(2.0).timeout
	transition_screen.hide()
	

func _physics_process(delta: float) -> void:

	if not is_on_floor():
		velocity.y += gravity * delta
	elif  Input.is_action_just_pressed("lompat"):
		velocity.y = JUMP_SPEED
	var direction = Input.get_axis("mundur", "maju")
	
	if direction:
		velocity.x = direction * WALK_SPEED
		animasi.play("walk")
		if direction > 0:
			animasi.flip_h = false
		elif direction < 0:
			animasi.flip_h = true
		
	else:
		animasi.play("idle")
		velocity.x = move_toward(velocity.x, 0, WALK_SPEED)

	move_and_slide()
