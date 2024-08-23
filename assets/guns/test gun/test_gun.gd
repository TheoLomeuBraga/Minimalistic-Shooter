extends Node3D



func _ready() -> void:
	pass

@export var bullet_asset : PackedScene

var burst_fire_timer : float = 0.0
@export var burst_fire_count : int = 3

var time_between_shots : float = 0.25 / float(burst_fire_count)
var cooldown : float = 0.0

func shoot(delta: float):
	var bullet : Node3D = bullet_asset.instantiate()
	$muzle.look_at(Global.player.target)
	bullet.global_transform = $muzle.global_transform
	bullet.position -= bullet.basis.z.normalized() * (delta + 1)
	bullet.set_distance(delta * bullet.speed)
	get_tree().get_root().add_child(bullet)
	Global.player.shot_animation()



func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("alt_fire") and not Global.is_paused:
		burst_fire_timer = 0.25
	
	if burst_fire_timer > 0:
		burst_fire_timer -= delta
		
		cooldown -= delta
		if cooldown <= 0:
			shoot(delta)
			cooldown = time_between_shots # Reseta o temporizador para o próximo disparo


	
	if Input.is_action_just_pressed("fire") and not Global.is_paused:
		shoot(delta)
