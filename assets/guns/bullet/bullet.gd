extends Sprite3D

func set_distance(distance : float):
	$RayCast3D.position.z = -distance
	$RayCast3D.target_position.z = distance

func _ready() -> void:
	set_distance(0)


@export var speed : float = 100
@export var timer : float = 5
@export var damage : int = 5

var first_frame = true

func _physics_process(delta: float) -> void:
	
	
	var obj_coliding : Node3D = $RayCast3D.get_collider()
	if $RayCast3D.is_colliding() or timer < 0:
		
		if $RayCast3D.get_collider() != null:
			
			if obj_coliding != null and obj_coliding.has_method("hit_damage"):
				obj_coliding.hit_damage(damage)
			queue_free()
			
	
	if first_frame:
		first_frame = false
	else:
		set_distance(delta * speed)
		position -= basis.z.normalized() * delta * speed
	
	timer -= delta
