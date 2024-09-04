extends Node


func play_sound(sound_file):
	var x = AudioStreamPlayer.new()
	x.stream = load(sound_file)
	x.finished.connect(func(): x.queue_free())
	x.volume_db = -15
	get_tree().root.add_child(x)
	x.play()
