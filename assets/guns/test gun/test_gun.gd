extends Node3D



func _ready() -> void:
	pass

@export var bullet_asset : PackedScene
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("fire"):
		
		
		if Global.player.wepon_presentation == false:
			var bullet : Node3D = bullet_asset.instantiate()
			bullet.global_transform = $muzle.global_transform
			get_tree().get_root().add_child(bullet)
		Global.player.shot_animation()
