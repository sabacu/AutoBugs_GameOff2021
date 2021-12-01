extends Control

var back_scene = "res://Scenes/MainMenu.tscn"


func _on_TextureButton_pressed():
	$Anim.play("finish")
	yield($Anim,"animation_finished")
	var _mainmenu = get_tree().change_scene_to(load(back_scene))
