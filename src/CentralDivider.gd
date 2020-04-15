tool
extends Control

export var color := Color() setget set_color

func set_color(new_color):
	color = new_color
	update()

func _draw():
	var height: float = ProjectSettings.get_setting("display/window/size/height")
	rect_size = Vector2(GameState.central_margin, height)
	draw_rect(Rect2(Vector2(-rect_size.x/2.0, -100), rect_size + Vector2(0, 200)), color, false, 20.0)
