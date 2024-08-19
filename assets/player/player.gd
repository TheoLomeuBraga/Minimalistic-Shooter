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
	
	$SubViewportContainer/SubViewport/Camera3D.global_transform = $Camera3D.global_transform
	if delta > 0:
		$Camera3D.rotation_degrees.z = Input.get_axis("left","right")
		
		var wepon_rotation_target = Vector2((Input.get_axis("look_right","look_left") * 10) + max(min(mouse_movement.x,1),-1) * 15,(Input.get_axis("look_down","look_up") * 10) + max(min(mouse_movement.y,1),-1) * 15)
		$SubViewportContainer/SubViewport/Camera3D/player_animations.rotation_degrees.y = lerp($SubViewportContainer/SubViewport/Camera3D/player_animations.rotation_degrees.y,wepon_rotation_target.x,2*delta)
		$SubViewportContainer/SubViewport/Camera3D/player_animations.rotation_degrees.x = lerp($SubViewportContainer/SubViewport/Camera3D/player_animations.rotation_degrees.x,wepon_rotation_target.y,2*delta)


func shoot():
	$SubViewportContainer/SubViewport/Camera3D/player_animations/AnimationPlayer.stop()
	$SubViewportContainer/SubViewport/Camera3D/player_animations/AnimationPlayer.play("shoot")

func movement_plugin(delta) -> void:
	look_around(delta)
	
	move_direction = (basis.z.normalized() * Input.get_axis("foward","back")) + (basis.x.normalized() * Input.get_axis("left","right"))
	
	
	if abs(move_direction.x) + abs(move_direction.y) > 1:
		move_direction = move_direction.normalized()
	
	if Input.is_action_just_pressed("jump") and in_floor:
		jump()
	
	if Input.is_action_just_pressed("fire"):
		shoot()
	
