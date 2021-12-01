extends Node

var player_choice : String

var car_1: String
var car_2: String
var car_3: String

var fist_place:= false
var second_place:= false
var third_place:= false
var last_place:= false

var fist_place_name: String
var second_place_name: String
var third_place_name: String
var last_place_name: String

var race_started := false
var current_lap:= 0
var race_finished: = false

signal player_selected
signal race_finished

func _ready():
	var _player_selected = connect("player_selected",self,"_on_player_selected")

func reset_game():
	race_finished = false
	current_lap = 0
	race_started = false
	var player_choice : String
	fist_place= false
	second_place= false
	third_place= false
	last_place= false

func _on_player_selected():
	match player_choice:
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
