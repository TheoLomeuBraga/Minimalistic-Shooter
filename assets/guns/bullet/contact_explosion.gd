extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


var life_time : float = 1.0
func _process(delta: float) -> void:
	if life_time <= 0:
		queue_free() 
	life_time -= delta



func _on_area_3d_body_entered(body: Node3D) -> void:
	if body == Global.player:
		Global.player.hit_damage(10)
		$Area3D.queue_free()
