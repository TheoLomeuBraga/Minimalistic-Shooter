extends Sprite3D


func _ready() -> void:
	pass


@export var speed : float = 10
@export var timer : float = 5
func _process(delta: float) -> void:
	$RayCast3D.position.z = (delta * speed)
	$RayCast3D.target_position.z = -(delta * speed)
	position -= basis.z.normalized() * delta * speed
	
	if $RayCast3D.is_colliding() or timer < 0:
		queue_free()
	timer -= delta
