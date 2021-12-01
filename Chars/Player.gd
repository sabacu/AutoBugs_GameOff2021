extends KinematicBody2D

var max_speed := 350
var acceleration := 200
var friction := 200
var speed_var := 1.0
var hurting = false
var invencible = false
var jumping = false
var knockback = Vector2.ZERO

var input_direction = Vector2.RIGHT
var motion = Vector2.ZERO

var check1 := false
var check2 := false
var check3 := false
var check4 := false

var race_lap := 1
var race_finished = false

func _process(_delta):
	if GameControl.race_started and not GameControl.race_finished:
		get_input_direction()

func _physics_process(delta):
	if hurting:
		knockback = knockback.move_toward(Vector2.ZERO,200*delta)
		knockback = move_and_slide(knockback)
		return
	if GameControl.race_started and not GameControl.race_finished:
		if not race_finished:
			move(delta)
		$Camera2D.current = true

func _ready():
	set_car()

func set_car():
	match GameControl.player_choice:
		"Ant": $Sprite.texture = preload("res://Assets/Chars/Ant_Car.png")
		"Bee": $Sprite.texture = preload("res://Assets/Chars/Bee_Car.png")
		"Roach": $Sprite.texture = preload("res://Assets/Chars/Cocroach_Car.png")
		"Fly": $Sprite.texture = preload("res://Assets/Chars/Fly_Car.png")

func get_input_direction():
	if Input.is_action_pressed("move_left"):
		rotation -= 0.05
		$Sprite.frame = 5
	if Input.is_action_pressed("move_right"):
		rotation += 0.05
		$Sprite.frame = 7
	elif Input.is_action_just_released("move_left") or Input.is_action_just_released("move_right"):
		$Sprite.frame = 6

func ground():
	jumping = false

func move(delta):
	if jumping:
		motion = motion.move_toward(input_direction.rotated(rotation) * max_speed * 1.5 * speed_var, acceleration * delta)
		$Anim.play("jump")
	else:
		$Anim.play("idle")
		if Input.is_action_pressed("move_up"):
			motion = motion.move_toward(input_direction.rotated(rotation) * max_speed * speed_var, acceleration * delta)
		elif Input.is_action_pressed("move_down"):
			motion = motion.move_toward(-input_direction.rotated(rotation) * max_speed/2 * speed_var, acceleration * delta)
		else:
			motion = motion.move_toward(Vector2.ZERO,friction*delta)
	motion = move_and_slide(motion)

func _on_Back_area_entered(_area):
	if not invencible:
		hurting = true
		$Anim.play("hurt")
		knockback = Vector2.RIGHT.rotated(rotation) * 100
		speed_var = 0.5
		invencible = true
		print("crash back")
		var rotation_bump = rand_range(-0.5,0.5)
		rotation += rotation_bump
		yield($Anim,"animation_finished")
		speed_var = 1
		hurting = false
		invencible = false

func _on_Left_area_entered(_area):
	if not invencible:
		hurting = true
		$Anim.play("hurt")
		knockback = Vector2.RIGHT.rotated(rotation) * 100
		speed_var = 0.5
		invencible = true
		print("crash left")
		rotation -= 0.5
		yield($Anim,"animation_finished")
		speed_var = 1
		hurting = false
		invencible = false

func _on_Right_area_entered(_area):
	if not invencible:
		hurting = true
		$Anim.play("hurt")
		knockback = Vector2.RIGHT.rotated(rotation) * 100
		speed_var = 0.5
		invencible = true
		print("crash right")
		rotation += 0.5
		yield($Anim,"animation_finished")
		speed_var = 1
		hurting = false
		invencible = false

func _on_DetectJump_area_entered(_area):
	jumping = true

func _on_FullStop_timeout():
	race_finished = true
	GameControl.emit_signal("race_finished")

func _on_CheckRace_area_entered(area):
	if area.Check == 1:
		check1 = true
		print(GameControl.player_choice," - player - check 1, lap ",race_lap)
	elif area.Check == 2 and check1:
		check2 = true
		print(GameControl.player_choice," - player - check 2, lap ",race_lap)
	if area.Check == 3 and check2:
		check3 = true
		print(GameControl.player_choice," - player - check 3, lap ",race_lap)
	elif area.Check == 4 and check3:
		if race_lap <= 2:
			race_lap += 1
			check3 = false
			check2 = false
			check1 = false
		if race_lap >= 3:
			check4 = true
			print(GameControl.player_choice," - player - fim de corrida")
			$FullStop.wait_time = 2.0
			$FullStop.start()
			if not GameControl.fist_place:
				GameControl.fist_place = true
				GameControl.fist_place_name = str(GameControl.player_choice)
			elif not GameControl.second_place:
				GameControl.second_place = true
				GameControl.second_place_name = str(GameControl.player_choice)
			elif not GameControl.third_place:
				GameControl.third_place = true
				GameControl.third_place_name = str(GameControl.player_choice)
			else:
				GameControl.last_place = true
				GameControl.last_place_name = str(GameControl.player_choice)
				GameControl.race_finished = true
