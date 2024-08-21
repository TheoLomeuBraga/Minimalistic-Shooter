extends Sprite3D


func _ready() -> void:
	pass


@export var speed : float = 100
@export var timer : float = 5
@export var damage : int = 5

func _physics_process(delta: float) -> void:
	
	var obj_coliding : Node3D = $RayCast3D.get_collider()
	if $RayCast3D.is_colliding() or timer < 0:
		
		if $RayCast3D.get_collider() != null:
			
			if obj_coliding != null and obj_coliding.has_method("hit_damage"):
				obj_coliding.hit_damage(damage)
			queue_free()
			
	
	$RayCast3D.position.z = (delta * speed)
	$RayCast3D.target_position.z = -(delta * speed)
	position -= basis.z.normalized() * delta * speed
	
	timer -= delta
