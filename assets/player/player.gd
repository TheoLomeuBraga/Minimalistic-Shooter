extends BasicMovement

var mouse_movement = Vector2.ZERO
func _input(event):
	if event is InputEventMouseMotion:
		mouse_movement = -event.relative * Global.mouse_sensitivity
	else:
		mouse_movement = Vector2.ZERO

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass
