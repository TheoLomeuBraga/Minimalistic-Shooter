extends ShapeCast3D

@export var damage := 10

var death_timer := 0.25
var death_timer_runing := false

func _physics_process(delta: float) -> void:
	if not death_timer_runing:
		if is_colliding():
			var count := get_collision_count()
			var i := 0
			while i < count:
				if get_collider(i) == Global.player:
					get_collider(i).hit_damage(damage)
					
				i+=1
		death_timer_runing = true
	else:
		if death_timer <= 0:
			queue_free()
		death_timer -= delta
	
