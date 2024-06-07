extends Control

signal start_game()

@onready var buttons_v_box = %ButtonsVBox

func _ready() -> void:
	focus_button()

func _on_story_mode_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
	
func _on_quit_button_pressed():
	get_tree().quit()

func _on_visibility_changed() -> void:
	if visible:
		focus_button()
		
func focus_button() -> void:
	if buttons_v_box:
		var button: Button = buttons_v_box.get_child(0)
		if button is Button:
			button.grab_focus()


