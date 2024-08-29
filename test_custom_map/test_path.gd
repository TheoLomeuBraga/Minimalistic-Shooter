extends Path3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


var timer : float = 0.0
func _process(delta: float) -> void:
	var sample_pos : Vector3 = curve.sample(int(timer),timer - int(timer))
	$MeshInstance3D.position = sample_pos
	
	print(timer,curve.point_count - 1)
	timer += delta
	if timer > curve.point_count - 1:
		timer = 0
