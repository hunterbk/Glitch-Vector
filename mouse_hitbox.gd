extends AnimatableBody2D



func _process(_delta):
	self.global_position = get_global_mouse_position()


func _on_area_2d_body_entered(body):
	if body.is_in_group("Ball"):
		body.hit_by_mouse = true
