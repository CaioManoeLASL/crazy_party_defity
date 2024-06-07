extends CanvasLayer

class_name UI

@onready var player = $"../Player"
@onready var game_over_center = $Control/MarginContainer/CenterContainer
@onready var objeto_correto_label = %objetoCorreto
@onready var score_label = %ScoreLabel
@onready var buttons_v_box = %ButtonsVBox

var objects_instance = null
var heart_textures: Array = []  # Array para armazenar as texturas dos corações
var hearts: Array = []  # Array para armazenar os TextureRect dos corações

func _ready():
	objects_instance = Objects.new()
	game_over_center.visible = false
	# Carrega as texturas dos corações
	for i in range(5):  # Supondo que você tem 5 vidas
		var texture = load("res://Assets/Sprites/SpritesSheet.sprites/corazao.png")  # Caminho para a textura do coração
		heart_textures.append(texture)
		# Cria um TextureRect para cada coração e define a textura
		var heart = TextureRect.new()
		heart.texture = texture
		# Define a escala do TextureRect para corresponder ao tamanho da textura
		heart.scale = Vector2.ONE * 0.5  # Ajuste a escala conforme necessário para o tamanho desejado
		hearts.append(heart)
		$Control/MarginContainer/HBoxContainer.add_child(heart)  # Adiciona o TextureRect ao HBoxContainer

func set_label(nome_objeto: String):
	objeto_correto_label.text = nome_objeto

func update_score(points: int):
	Global.points = points
	score_label.text = "score: " + str(Global.points)

func update_lives(vidas: int):
	Global.lives = vidas
	# Atualiza a visibilidade dos corações para refletir o número de vidas restantes
	for i in range(5):  # Supondo que você tem 5 vidas
		hearts[i].visible = true
		if i < Global.lives:
			hearts[i].visible = true
		else:
			hearts[i].visible = false
		
	if Global.lives <= 0:
		game_over_center.visible = true
		player.freeze()
		if objects_instance != null:
			objects_instance.freeze()
func _on_restart_pressed():
	objects_instance.unfreeze()
	player.unfreeze()
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_quit_pressed():
	get_tree().change_scene_to_file("res://Scenes/mainMenu.tscn")

func _on_visibility_changed() -> void:
	if visible:
		focus_button()
		

func focus_button() -> void:
	if buttons_v_box:
		var button: Button = buttons_v_box.get_child(1)
		if button is Button:
			button.grab_focus()
