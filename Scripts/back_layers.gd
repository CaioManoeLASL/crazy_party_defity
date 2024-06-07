extends ParallaxLayer

var rotation_speed = 45  # Graus por segundo

func _process(delta: float) -> void:
	for sprite in get_children():
		if sprite is TextureRect:
			sprite.rotation_degrees += rotation_speed * delta
