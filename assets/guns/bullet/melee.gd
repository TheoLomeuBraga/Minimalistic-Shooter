extends ShapeCast3D

@export var damage := 5 
func _physics_process(delta: float) -> void:
	if is_colliding():
		var count := get_collision_count()
		var i := 0
		while i < count:
			if get_collider(i) == Global.player:
				get_collider(i).hit_damage(damage)
				
			i+=1
	queue_free()
