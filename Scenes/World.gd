extends Node2D

onready var route1 = [
	$Route1/Point1,
	$Route1/Point2,
	$Route1/Point3,
	$Route1/Point4,
	$Route1/Point5,
	$Route1/Point6,
	$Route1/Point7,
	$Route1/Point8,
	$Route1/Point9,
	$Route1/Point10,
	$Route1/Point11,
	$Route1/Point12,
	$Route1/Point13,
	$Route1/Point14,
	$Route1/Point15,
	$Route1/Point16,
	$Route1/Point17,
	]

onready var car_1 : String
onready var car_2 : String
onready var car_3 : String

func start_race():
	GameControl.race_started = true

func _ready():
	GameControl.connect("race_finished",self,"_on_race_finished")
	
	match GameControl.player_choice:
		"Ant":
			car_1 = "Roach"
			car_2 = "Fly"
			car_3 = "Bee"
		"Roach":
			car_1 = "Fly"
			car_2 = "Bee"
			car_3 = "Ant"
		"Fly":
			car_1 = "Bee"
			car_2 = "Ant"
			car_3 = "Roach"
		"Bee":
			car_1 = "Ant"
			car_2 = "Roach"
			car_3 = "Fly"


func _on_race_finished():
	$CountDown/AnimStart.play("finish")
	yield($CountDown/AnimStart,"animation_finished")
	var _next_scene = get_tree().change_scene_to(load("res://Scenes/Placar.tscn"))

func stop_music():
	AudioControl.stop_musics()

func play_race_music():
	AudioControl.play_race()
