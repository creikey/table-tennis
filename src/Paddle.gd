tool
extends KinematicBody2D

export var size := Vector2(50, 100) setget set_size
export var color := Color() setget set_color
export var on_left := false

var last_target_position := Vector2()
var target_position := Vector2()

func get_vel():
	return (last_target_position - target_position)

func set_color(new_color):
	color = new_color
	if has_node("ColorRect"):
		$ColorRect.color = color

func set_size(new_size):
	size = new_size
	if has_node("ColorRect") and has_node("CollisionShape2D"):
		$ColorRect.rect_size = size
		$ColorRect.rect_position = -size/2.0
		$CollisionShape2D.shape.extents = size/2.0

func _ready():
	var width: float = ProjectSettings.get_setting("display/window/size/width")
	var height: float = ProjectSettings.get_setting("display/window/size/height")
	if on_left:
		rotation_degrees = -45
		target_position = Vector2(width*0.1, height/2.0)
	else:
		rotation_degrees = 45
		target_position = Vector2(width*0.9, height/2.0)

func _physics_process(delta):
	if Engine.editor_hint:
		return
	var collision: KinematicCollision2D = move_and_collide(target_position - global_position)
	if collision != null:
		if collision.collider.is_in_group("balls"):
			var ball = collision.collider
#			ball.vel = Vector2(500.0, 0.0)
			print("Setting velocity")
			ball.vel = (last_target_position - target_position).normalized()*(global_position - target_position).length()*5.0
#	var _vel := move_and_slide((target_position - global_position)/delta)

func _input(event):
	if Engine.editor_hint:
		return
	if event is InputEventScreenDrag or event is InputEventMouseMotion:
		var width: float = ProjectSettings.get_setting("display/window/size/width")
		
		var new_position: Vector2 = event.position
#		if event is InputEventScreenDrag:
#			new_position = event.position
#		elif event is InputEventMouseMotion:
#			new_position = event.position
		
		if on_left and new_position.x < width/2.0 - GameState.central_margin/2.0 or \
		not on_left and new_position.x >= width/2.0 + GameState.central_margin/2.0:
			last_target_position = target_position
			target_position = new_position
			
