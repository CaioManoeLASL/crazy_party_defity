extends CharacterBody2D

class_name Player

const SPEED = 70.0
var is_frozen = false
var direction = Vector2.ZERO

@onready var player_animated_sprite := $AnimatedSprite2D
@onready var player_collision_shape := $Area2D/CollisionShape2D

func _ready():
	pass

func _physics_process(delta):
	if is_frozen:
		return
		
	var screen_size = get_viewport_rect().size
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction != 0:
		velocity.x = direction * SPEED
		player_animated_sprite.play("run")
		player_animated_sprite.scale.x = direction * 0.22
	else:
		velocity.x = 0
		player_animated_sprite.play("idle")
		
	if position.x > screen_size.x - player_collision_shape.shape.extents.x:
		position.x = screen_size.x - player_collision_shape.shape.extents.x
	elif position.x < player_collision_shape.shape.extents.x:
		position.x = player_collision_shape.shape.extents.x
	
	move_and_slide()
	
func freeze():
	is_frozen = true

func unfreeze():
	is_frozen = false
