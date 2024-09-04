extends CanvasLayer

var score = 0
var seconds = 0
var minutes = 0

func _process(delta):
	update_timer(delta)
	%Score.text = "Score: " + str(score)
	%FPS.text = str(Engine.get_frames_per_second())


func update_timer(delta):
	seconds += delta
	if ceil(seconds) >= 60:
		minutes += 1
		seconds = -1
	if seconds >= 60:
		%Time.text = "Time: %d:%d" % [ceil(minutes), ceil(seconds)]
	else:
		%Time.text = "Time: %d:%02d" % [ceil(minutes), ceil(seconds)]
