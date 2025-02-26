extends CharacterBody2D


const SPEED = 100
const GRAVITY = 500
const JUMP = -250



@onready var animated_sprite = $AnimatedSprite2D
var is_jumping = false

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	#MARCHE
	var direction = Input.get_axis("ui_left","ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x,0,SPEED)
	update_animation(direction)
	
	#SAUT
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP
		is_jumping = true
	
	
	#GRAVITE
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		is_jumping = false
	
	move_and_slide()

func update_animation(direction):
	if is_jumping:
		animated_sprite.play("Jump")
	elif direction != 0:
		animated_sprite.flip_h = (direction > 0)
		animated_sprite.play("Walk")
	else:
		animated_sprite.play("Idle")
