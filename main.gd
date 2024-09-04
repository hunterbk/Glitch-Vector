extends Node2D

var score = 0

func _ready():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	ProjectSettings.set_setting("physics/common/physics_ticks_per_second", DisplayServer.screen_get_refresh_rate())

func _on_ball_spawn_timer_timeout():
	var x = load("res://ball.tscn").instantiate()
	x.global_position.x = randi_range(%Spawner1.global_position.x, %Spawner2.global_position.x)
	x.global_position.y = randi_range(%Spawner1.global_position.y, %Spawner2.global_position.y)
	var count = 0
	for ball in %Balls.get_children():
		if ball.set_to_freeze:
			count += 1
	if randi_range(0, 100) >= (50 + (count * 10)):
		x.set_to_freeze = true
	%Balls.add_child(x)
	Global.play_sound("res://drop.wav")

func _process(_delta):
	if score < 0:
		score = 0
	%HUD.score = score

func die():
	Engine.time_scale = 0.25
	%HUD.visible = false
	%Goal.visible = false
	var x = load("res://you_lose.tscn").instantiate()
	x.papa = self
	x.score = score
	get_tree().root.add_child(x)


func _on_ball_spawn_timer_upside_down_timeout():
	var x = load("res://ball.tscn").instantiate()
	x.global_position.x = randi_range(%Spawner3.global_position.x, %Spawner4.global_position.x)
	x.global_position.y = randi_range(%Spawner3.global_position.y, %Spawner4.global_position.y)
	var count = 0
	for ball in %Balls.get_children():
		if ball.set_to_freeze:
			count += 1
	if randi_range(0, 100) >= (50 + (count * 10)):
		x.set_to_freeze = true
	x.upside_down = true
	%Balls.add_child(x)
	Global.play_sound("res://drop.wav")
