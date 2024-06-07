extends Node

@onready var objects_container = $game/Objects
@onready var ui = $game/Ui
@onready var timer = $game/Timer

const CANDY = preload("res://Scenes/candy.tscn")
const BALLON = preload("res://Scenes/ballon.tscn")
const BOTTLE = preload("res://Scenes/bottle.tscn")
const BRIGADIER = preload("res://Scenes/brigadier.tscn")
const FORK = preload("res://Scenes/fork.tscn")
const GIFT = preload("res://Scenes/gift.tscn")
const GLASS = preload("res://Scenes/glass.tscn")
const HAMBURGER = preload("res://Scenes/hamburger.tscn")
const HAT = preload("res://Scenes/hat.tscn")
const HOT_DOG = preload("res://Scenes/hot_dog.tscn")
const JUICE = preload("res://Scenes/juice.tscn")
const KNIFE = preload("res://Scenes/Knife.tscn")
const LIGHTER = preload("res://Scenes/lighter.tscn")
const PIZZA = preload("res://Scenes/pizza.tscn")
const PLATE = preload("res://Scenes/plate.tscn")
const SODA = preload("res://Scenes/soda.tscn")
const SPOON = preload("res://Scenes/spoon.tscn")
const SNACK = preload("res://Scenes/snack.tscn")

var objects_list = [
	CANDY,
	BALLON,
	BRIGADIER,
	FORK,
	GIFT,
	HAMBURGER,
	HAT,
	HOT_DOG,
	JUICE,
	KNIFE,
	PIZZA,
	PLATE,
	SODA,
	SPOON,
	SNACK,
	LIGHTER,
	GLASS,
	BOTTLE
]

var last_object_index = -1


func _ready():
	Global.lives = 5  # Reinicializa as vidas
	Global.points = 0  # Reinicializa os pontos
	spawn_objects()
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	ui.update_lives(Global.lives)  # Atualiza a UI para mostrar as vidas iniciais
	ui.update_score(0)  # Atualiza a UI para mostrar os pontos iniciais

func _on_timer_timeout():
	spawn_objects()

func spawn_objects():
	var index1 = get_objeto_aleatorio()
	var object1 = objects_list[index1].instantiate()
	object1.global_position = Vector2(30, 0)
	objects_container.add_child(object1)

	var index2 = get_objeto_aleatorio(index1)
	var object2 = objects_list[index2].instantiate()
	object2.global_position = Vector2(80, 0)
	objects_container.add_child(object2)

	var index3 = get_objeto_aleatorio(index1, index2)
	var object3 = objects_list[index3].instantiate()
	object3.global_position = Vector2(130, 0)
	objects_container.add_child(object3)

	var objeto_correto = randi_range(1,3)
	if objeto_correto == 1:
		Global.nome_objeto = objects_list[index1].instantiate().name
		print(Global.nome_objeto)
	elif objeto_correto == 2:
		Global.nome_objeto = objects_list[index2].instantiate().name
		print(Global.nome_objeto)
	elif objeto_correto == 3:
		Global.nome_objeto = objects_list[index3].instantiate().name
		print(Global.nome_objeto)
		
	ui.set_label(Global.nome_objeto)

func get_objeto_aleatorio(item1 = -1, item2 = -1):
	var index = randi_range(0, objects_list.size() -1)
	while index == item1 or index == item2:
		index = randi_range(0, objects_list.size() -1)
	last_object_index = index
	return index
