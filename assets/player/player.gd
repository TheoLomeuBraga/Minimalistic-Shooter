extends BasicMovement

var mouse_movement = Vector2.ZERO
func _input(event):
	if event is InputEventMouseMotion:
		mouse_movement = -event.relative * Global.mouse_sensitivity
	else:
		mouse_movement = Vector2.ZERO

func _ready() -> void:
	pass

func look_around(delta) -> void:
	rotation_degrees.y += ((mouse_movement.x * Global.mouse_sensitivity) + (Input.get_axis("look_right","look_left") * Global.joystick_sensitivity * 10)) * delta
	$Camera3D.rotation_degrees.x += ((mouse_movement.y * Global.mouse_sensitivity) + (Input.get_axis("look_down","look_up") * Global.joystick_sensitivity * 10)) * delta
	$Camera3D.rotation_degrees.x = max(-90,min(90,$Camera3D.rotation_degrees.x))


func movement_plugin(delta) -> void:
	look_around(delta)
	
	move_direction = (basis.z.normalized() * Input.get_axis("foward","back")) + (basis.x.normalized() * Input.get_axis("left","right"))
	
	if abs(move_direction.x) + abs(move_direction.y) > 1:
		move_direction = move_direction.normalized()
	
	if Input.is_action_just_pressed("jump") and in_floor:
		jump()
	
