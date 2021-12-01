extends KinematicBody2D

var max_speed := 350
var acceleration := 200
var friction := 1000
var speed_var := 1.0

var hurting = false
var invencible = false
var jumping = false

var knockback = Vector2.ZERO

var target = Vector2.ZERO
var velocity = Vector2.ZERO

var route_index = 0

var race_lap := 1
var race_finished = false

var car_name :String

var check1 := false
var check2 := false
var check3 := false
var check4 := false

func _physics_process(delta):
	sprite_sinc()
	if hurting:
		knockback = knockback.move_toward(Vector2.ZERO,200*delta)
		knockback = move_and_slide(knockback)
		return
	if GameControl.race_started and not GameControl.race_finished and not race_finished:
		follow_path(delta)

func _ready():
	set_car()

func set_car():
	print ("Car 2 : ", GameControl.car_2)
	match GameControl.car_2:
		"Ant":
			$Sprite.texture = preload("res://Assets/Chars/Ant_Car.png")
		"Bee":
			$Sprite.texture = preload("res://Assets/Chars/Bee_Car.png")
		"Roach":
			$Sprite.texture = preload("res://Assets/Chars/Cocroach_Car.png")
		"Fly":
			$Sprite.texture = preload("res://Assets/Chars/Fly_Car.png")

func sprite_sinc():
	if abs(velocity.y) > abs(velocity.x):
		if velocity.y > 0:
			if velocity.x > 0:
				if abs(velocity.x) >= 0.5*abs(velocity.y):
					$Sprite.frame = 7
			elif abs(velocity.x) >= 0.5*abs(velocity.y):
					$Sprite.frame = 5
			else:
				$Sprite.frame = 6
		elif velocity.x < 0:
			if abs(velocity.x) >= 0.5*abs(velocity.y):
				$Sprite.frame = 1
		elif abs(velocity.x) >= 0.5*abs(velocity.y):
			$Sprite.frame = 3
		else:
			$Sprite.frame = 2
	elif velocity.x < 0:
		$Sprite.frame = 4
	else:
		$Sprite.frame =  0

func ground():
	jumping = false

func follow_path(delta):
	var main = get_tree().current_scene
	if route_index < main.route1.size():
		target = main.route1[route_index].position
	else:
		route_index = 0
		target = main.route1[route_index].position
	look_at(target)
	
	if jumping:
		velocity = velocity.move_toward((target - position).normalized() * max_speed * 1.5 * speed_var,acceleration * delta)
		$Anim.play("jump")
	else:
		$Anim.play("idle")
		velocity = velocity.move_toward((target - position).normalized() * max_speed * speed_var,acceleration * delta)
	velocity = move_and_slide(velocity)

func _on_DetectRoute_area_entered(_area):
	route_index += 1

func _on_Back_area_entered(_area):
	if not invencible:
		$SoundControl/Crash.play()
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
		$SoundControl/Crash.play()
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
		$SoundControl/Crash.play()
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


func _on_CheckRace_area_entered(area):
	if area.Check == 1:
		check1 = true
		print(GameControl.car_2," check 1, lap ",race_lap)
	elif area.Check == 2 and check1:
		check2 = true
		print(GameControl.car_2," check 2, lap ",race_lap)
	if area.Check == 3 and check2:
		check3 = true
		print(GameControl.car_2," check 3, lap ",race_lap)
	elif area.Check == 4 and check3:
		if race_lap <= 2:
			race_lap += 1
			check3 = false
			check2 = false
			check1 = false
		if race_lap >= 3:
			check4 = true
			print(GameControl.car_2,"fim de corrida")
			$FullStop.wait_time = 1.0
			$FullStop.start()
			if not GameControl.fist_place:
				GameControl.fist_place = true
				GameControl.fist_place_name = str(GameControl.car_2)
			elif not GameControl.second_place:
				GameControl.second_place = true
				GameControl.second_place_name = str(GameControl.car_2)
			elif not GameControl.third_place:
				GameControl.third_place = true
				GameControl.third_place_name = str(GameControl.car_2)
			else:
				GameControl.last_place = true
				GameControl.last_place_name = str(GameControl.car_2)
				GameControl.race_finished = true


func _on_FullStop_timeout():
	race_finished = true
