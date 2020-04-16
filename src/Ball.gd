tool
extends KinematicBody2D

export var screen_percentage_down := 0.25 setget set_screen_percentage_down
export var color := Color() setget set_color
export var radius := 50.0 setget set_radius
export var gravity := 450.0

var accel := Vector2()
var vel := Vector2()

func set_radius(new_radius):
	radius = new_radius
	update()
	if has_node("CollisionShape2D"):
		$CollisionShape2D.shape.radius = radius

func set_color(new_color):
	color = new_color
	update()

func set_screen_percentage_down(new_screen_percentage_down):
	screen_percentage_down = new_screen_percentage_down
	update_position()

func _ready():
	randomize()
	update_position()
	self.radius = radius
	_random_velocity()

func _random_velocity():
	vel.x = float((randi()%2)*2 - 1)*1200.0

func _physics_process(delta):
	if Engine.editor_hint:
		return
	accel.y = gravity
	vel += accel*delta
	var collision: KinematicCollision2D = move_and_collide(vel*delta)
	if collision != null:
		if collision.collider.is_in_group("net"):
			vel = Vector2()
			update_position()
			_random_velocity()
			return
		vel *= -1.0
#		vel = vel.reflect(collision.normal)
#		vel.x = min(sign(vel.x)*500.0, )
		
#		if collision.collider.is_in_group("paddles"):
#			var added_vel: Vector2 = collision.collider.get_vel()
#			added_vel *= 10.0
#			vel += added_vel
#	vel = move_and_slide(vel, Vector2(0, 1))

func _draw():
	draw_circle(Vector2(), radius, color)

func update_position():
	var width: float = ProjectSettings.get_setting("display/window/size/width")
	var height: float = ProjectSettings.get_setting("display/window/size/height")
	
	position = Vector2(width/2.0, height*screen_percentage_down)
