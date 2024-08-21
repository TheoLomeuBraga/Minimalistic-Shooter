extends Sprite3D


func _ready() -> void:
	pass


@export var speed : float = 100
@export var timer : float = 5
func _physics_process(delta: float) -> void:
	
	
	if $RayCast3D.is_colliding():
		print("bullet is coliding")
	
	if $RayCast3D.is_colliding() or timer < 0:
		queue_free()
	
	$RayCast3D.position.z = (delta * speed)
	$RayCast3D.target_position.z = -(delta * speed)
	position -= basis.z.normalized() * delta * speed
	
	timer -= delta
