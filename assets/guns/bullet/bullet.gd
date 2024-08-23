extends Sprite3D

func set_distance(distance : float):
	$RayCast3D.position.z = -distance * 2
	$RayCast3D.target_position.z = distance * 2

func _ready() -> void:
	set_distance(0)



@export var speed : float = 100
@export var distance : float = 10
@export var damage : int = 5

var first_frame = true

func _physics_process(delta: float) -> void:
	
	
	var obj_coliding : Node3D = $RayCast3D.get_collider()
	if $RayCast3D.is_colliding():
		
		if $RayCast3D.get_collider() != null:
			
			if obj_coliding != null and obj_coliding.has_method("hit_damage"):
				obj_coliding.hit_damage(damage)
			queue_free()
	
	if distance < 0:
		queue_free()
	
	if first_frame:
		first_frame = false
	else:
		set_distance(delta * speed)
		position -= basis.z.normalized() * delta * speed
	
	distance -= delta * speed
