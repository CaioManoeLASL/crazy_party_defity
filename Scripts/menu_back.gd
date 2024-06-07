extends ParallaxBackground

@onready var ballons_layer = %BallonsLayer
@onready var fast_layer = %FastLayer
@onready var slow_layer = %SlowLayer

func _process(delta: float) -> void:
	ballons_layer.motion_offset.y -= 10 * delta
	fast_layer.motion_offset.y += 30 * delta
	slow_layer.motion_offset.y += 20 * delta
