extends Control

var back_scene = "res://Scenes/MainMenu.tscn"

onready var fly_texture = preload("res://Assets/Menu and Credits/placar_fly.png")
onready var roach_texture = preload("res://Assets/Menu and Credits/placar_roach.png")
onready var bee_texture = preload("res://Assets/Menu and Credits/placar_bee.png")
onready var ant_texture = preload("res://Assets/Menu and Credits/placar_ant.png")

func _ready():
	placar()

func placar():
	match GameControl.fist_place_name:
		"Ant":
			$First.texture = ant_texture
		"Bee":
			$First.texture =  bee_texture
		"Roach":
			$First.texture = roach_texture
		"Fly":
			$First.texture = fly_texture
	match GameControl.second_place_name:
		"Ant":
			$Second.texture = ant_texture
		"Bee":
			$Second.texture =  bee_texture
		"Roach":
			$Second.texture = roach_texture
		"Fly":
			$Second.texture = fly_texture
	match GameControl.third_place_name:
		"Ant":
			$Third.texture = ant_texture
		"Bee":
			$Third.texture =  bee_texture
		"Roach":
			$Third.texture = roach_texture
		"Fly":
			$Third.texture = fly_texture


func _on_TextureButton_pressed():
	$Anim.play("finish")
	GameControl.reset_game()
	yield($Anim,"animation_finished")
	var _mainmenu = get_tree().change_scene_to(load(back_scene))
