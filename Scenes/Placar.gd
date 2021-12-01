extends Control

var first_place_done:= false
var second_place_done:= false
var third_place_done:= false

func _ready():
	$FirstPlace.visible = false
	$SecondPlace.visible = false
	$ThirdPlace.visible = false

func _process(_delta):
	if GameControl.fist_place:
		first_place()
	if GameControl.second_place:
		second_place()
	if GameControl.third_place:
		third_place()

func first_place():
	$FirstPlace.visible = true
	if GameControl.fist_place_name == "Ant":
		$FirstPlace/FirstSprite.texture = preload("res://Assets/Menu and Credits/ant_normal.png")
	elif GameControl.fist_place_name == "Bee":
		$FirstPlace/FirstSprite.texture = preload("res://Assets/Menu and Credits/bee_normal.png")
	elif GameControl.fist_place_name == "Roach":
		$FirstPlace/FirstSprite.texture = preload("res://Assets/Menu and Credits/cockroach_normal.png")
	elif GameControl.fist_place_name == "Fly":
		$FirstPlace/FirstSprite.texture = preload("res://Assets/Menu and Credits/fly_normal.png")
	if not first_place_done:
		first_place_done = true
		$PlacarPosition.play()

func second_place():
	$SecondPlace.visible = true
	if GameControl.second_place_name == "Ant": $SecondPlace/FirstSprite.texture = preload("res://Assets/Menu and Credits/ant_normal.png")
	elif GameControl.second_place_name == "Bee": $SecondPlace/FirstSprite.texture = preload("res://Assets/Menu and Credits/bee_normal.png")
	elif GameControl.second_place_name == "Roach": $SecondPlace/FirstSprite.texture = preload("res://Assets/Menu and Credits/cockroach_normal.png")
	elif GameControl.second_place_name == "Fly": $SecondPlace/FirstSprite.texture = preload("res://Assets/Menu and Credits/fly_normal.png")
	if not second_place_done:
		second_place_done = true
		$PlacarPosition.play()

func third_place():
	$ThirdPlace.visible = true
	if  GameControl.third_place_name == "Ant": $ThirdPlace/FirstSprite.texture = preload("res://Assets/Menu and Credits/ant_normal.png")
	elif GameControl.third_place_name == "Bee": $ThirdPlace/FirstSprite.texture = preload("res://Assets/Menu and Credits/bee_normal.png")
	elif  GameControl.third_place_name == "Roach": $ThirdPlace/FirstSprite.texture = preload("res://Assets/Menu and Credits/cockroach_normal.png")
	elif GameControl.third_place_name ==  "Fly": $ThirdPlace/FirstSprite.texture = preload("res://Assets/Menu and Credits/fly_normal.png")
	if not third_place_done:
		third_place_done = true
		$PlacarPosition.play()
