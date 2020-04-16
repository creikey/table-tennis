extends StaticBody2D

func _ready():
	var width: float = ProjectSettings.get_setting("display/window/size/width")
	var height: float = ProjectSettings.get_setting("display/window/size/height")
	$LeftWall.shape.b.y = height
	$RightWall.position.x = width
	$TopWall.shape.b.x = width
	$BottomWall.position.y = height
