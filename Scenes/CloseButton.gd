extends TextureButton

func _on_CloseButton_pressed():
	$Anim.play("click")
	yield($Anim,"animation_finished")
	$Anim.play("fadeout")
	yield($Anim,"animation_finished")
	var main = get_tree().current_scene
	var back_scene = main.back_scene
	var _prev_scene = get_tree().change_scene_to(load(back_scene))
	


func _on_CloseButton_mouse_entered():
	$Anim.play("hover")
