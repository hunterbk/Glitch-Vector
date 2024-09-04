extends AnimatableBody2D

var going_left = false
var speed = 10

func _process(_delta):
	if going_left:
		position.x -= speed
	else:
		position.x += speed


func _on_area_2d_body_entered(body):
	if body.is_in_group("Ball"):
		if body.death_ball:
			get_parent().die()
			get_parent().score -= 100
			body.queue_free()
			return
		if body.hit_by_mouse:
			if body.set_to_freeze:
				get_parent().score += 2.5
				Global.play_sound("res://coin1.wav")
			else:
				get_parent().score += 1
				Global.play_sound("res://coin2.wav")
			if body.big_ball:
				get_parent().score += 2.5
				Global.play_sound("res://coin1.wav")
		body.queue_free()


func change_direction():
	if randi_range(0, 100) >= 75:
		going_left = !going_left
	if randi_range(0, 1) == 0:
		speed -= 2
	else:
		speed += 2
	speed = clamp(speed, 5, 15)
	%DirTimer.wait_time = randf_range(0.5, 2)
	%DirTimer.start()


func _on_visible_on_screen_notifier_2d_screen_exited():
	going_left = !going_left
	%DirTimer.wait_time = randf_range(0.5, 2)
	%DirTimer.start()


func completely_off_screen():
	self.global_position.x = 0
