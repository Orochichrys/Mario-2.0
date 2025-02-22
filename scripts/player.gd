extends CharacterBody2D


const SPEED = 100
const GRAVITY = 500
const JUMP = 500


@onready var animated_sprite = $AnimatedSprite2D
var is_jumping = false

func _ready() -> void:
	animated_sprite.flip_h = true

func _physics_process(delta: float) -> void:
	#MARCHE
	if Input.is_action_pressed("ui_right"):
		velocity.x += SPEED
		animated_sprite.flip_h = true
	elif Input.is_action_pressed("ui_left"):
		velocity.x -= SPEED
		animated_sprite.flip_h = false
	else:
		velocity.x = 0
	
	
	#SAUT
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y -= JUMP
	
	
	#GRAVITE
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	
	#ANIMATION LOGIC
	if not is_on_floor():
		animated_sprite.animation = "Jump"
	elif velocity.x != 0:
		animated_sprite.animation = "Walk"
	else:
		animated_sprite.animation = "Idle"
	
	
	move_and_slide()
#ceci est un test de modification
