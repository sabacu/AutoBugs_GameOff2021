extends Control

var next_scene = preload("res://Scenes/World.tscn")

func play_hoover():
	$Hover.play()

func play_click():
	$Click.play()

func _on_Ant_mouse_entered():
	play_hoover()

func _on_Cocroach_mouse_entered():
	play_hoover()

func _on_Fly_mouse_entered():
	play_hoover()

func _on_Bee_mouse_entered():
	play_hoover()

func _on_Ant_pressed():
	play_click()
	GameControl.player_choice = "Ant"
	GameControl.emit_signal("player_selected")
	yield($Click,"finished")
	var _next = get_tree().change_scene_to(next_scene)

func _on_Cocroach_pressed():
	play_click()
	GameControl.player_choice = "Roach"
	GameControl.emit_signal("player_selected")
	yield($Click,"finished")
	var _next = get_tree().change_scene_to(next_scene)

func _on_Fly_pressed():
	play_click()
	GameControl.player_choice = "Fly"
	GameControl.emit_signal("player_selected")
	yield($Click,"finished")
	var _next = get_tree().change_scene_to(next_scene)

func _on_Bee_pressed():
	play_click()
	GameControl.player_choice = "Bee"
	GameControl.emit_signal("player_selected")
	yield($Click,"finished")
	var _next = get_tree().change_scene_to(next_scene)
