tool
extends StaticBody2D

export var size := Vector2(50, 200) setget set_size
export var color := Color() setget set_color

func _ready():
	self.size = size

func set_color(new_color):
	color = new_color
	if has_node("ColorRect"):
		$ColorRect.color = color

func set_size(new_size):
	size = new_size
	if has_node("ColorRect") and has_node("CollisionShape2D"):
		var width: float = ProjectSettings.get_setting("display/window/size/width")
		var height: float = ProjectSettings.get_setting("display/window/size/height")
		$ColorRect.rect_size = size
		$ColorRect.rect_position = -size/2.0
		$CollisionShape2D.shape.extents = size/2.0
		position = Vector2(width/2.0, height - size.y/2.0)
