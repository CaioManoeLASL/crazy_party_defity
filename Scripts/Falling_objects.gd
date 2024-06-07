extends Area2D

class_name Objects

var is_frozen = false
@export var horizontal_speed = 0
@export var vertical_speed = 35

func _ready():
	set_process(true)
	if not is_connected("area_entered", Callable(self, "_on_area_entered")):
		connect("area_entered", Callable(self, "_on_area_entered"))

func _process(delta):
	if is_frozen:
		return
		
	position.y += delta * vertical_speed
	
func _on_area_entered(area):
	if is_frozen:
		return
		
	if self.name == Global.nome_objeto:
		Global.points += 10
		_update_ui()
	else:
		Global.lives -= 1
		_update_ui()
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _update_ui():
	var ui = get_tree().get_root().get_node("Main/game/Ui")
	if ui != null:
		ui.update_lives(Global.lives)
		ui.update_score(Global.points)
	else:
		print("UI node not found!")
		
func freeze():
	if is_instance_valid(self):
		is_frozen = true
	else:
		print("Objects node is not valid!")
		
func unfreeze():
	is_frozen = false
