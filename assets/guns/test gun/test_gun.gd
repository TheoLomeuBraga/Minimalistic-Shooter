extends Node3D



func _ready() -> void:
	pass

@export var bullet_asset : PackedScene
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("fire") and not Global.is_paused:
		
		
		if Global.player.wepon_presentation < 0:
			var bullet : Node3D = bullet_asset.instantiate()
			$muzle.look_at(Global.player.target)
			bullet.global_transform = $muzle.global_transform
			bullet.position -= bullet.basis.z.normalized() * delta * bullet.speed
			get_tree().get_root().add_child(bullet)
		
		Global.player.shot_animation()
