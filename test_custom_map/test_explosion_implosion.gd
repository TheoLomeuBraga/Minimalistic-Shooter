extends Node3D



func _ready() -> void:
	$GPUParticlesAttractorSphere3D.set_process(false)


var timer := 0.0
func _process(delta: float) -> void:
	timer += delta
	if timer > 0.5:
		$GPUParticlesAttractorSphere3D.set_process(true)
