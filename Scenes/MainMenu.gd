extends CanvasLayer

var next_scene = preload("res://Scenes/PlayerChoice.tscn")
var about_scene = preload("res://Scenes/About.tscn")

func _ready():
	AudioControl.play_menu()


func _on_Play_mouse_entered():
	$Buttons/Hover.play()


func _on_Play_pressed():
	var _next_scene = get_tree().change_scene_to(next_scene)


func _on_About_pressed():
	var _about_scene = get_tree().change_scene_to(about_scene)
