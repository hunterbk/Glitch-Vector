extends RigidBody2D

@export var set_to_freeze = false
@export var death_ball = false
@export var upside_down = false
var big_ball = false
var hit_by_mouse = false

func _on_visible_on_screen_notifier_2d_screen_exited():
	if not death_ball and not upside_down:
		get_tree().get_first_node_in_group("Main").score -= 0.25
	self.queue_free()

func _ready():
	if randi_range(0, 100) >= 90:
		death_ball = true
	%FreezeTimer.wait_time = randf_range(0.5, 2.5)
	%FreezeTimer.start()
	if randi_range(0, 100) >= 75:
		%Sprite.scale.x = 6
		%Sprite.scale.y = 6
		var shape = CircleShape2D.new()
		shape.radius = 48 * 2
		%CollisionShape2D.shape = shape
		self.mass = 10
		big_ball = true
	if death_ball:
		%Sprite.texture = load("res://skull_block.png")
		%Sprite.modulate = Color.WHITE
		self.scale = Vector2(1.5, 1.5)
	if upside_down:
		self.gravity_scale = -2
		self.mass = 15


func _on_freeze_timer_timeout():
	if set_to_freeze == true:
		self.freeze = true
		%Sprite.modulate = Color.CRIMSON
		%ExplodeTimer.wait_time = randf_range(0.5, 7.5)
		%ExplodeTimer.start()

func explode():
	self.freeze = false

func _physics_process(_delta):
	linear_velocity.x = clamp(linear_velocity.x, -500, 500)
	linear_velocity.y = clamp(linear_velocity.y, -500, 500)
	#angular_velocity = clamp(angular_velocity, -500, 500)
	
