extends Control

var papa = null
var score = 0

func _ready():
	%Score.text = "Score: " + str(score)

func _on_try_again_pressed():
	Engine.time_scale = 1
	Global.play_sound("res://click.wav")
	var x = load("res://main.tscn").instantiate()
	get_tree().root.add_child(x)
	papa.queue_free()
	self.queue_free()
