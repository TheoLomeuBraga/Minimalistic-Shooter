extends Node3D



func _ready() -> void:
	pass

@export var projectile : bool = false
@export var projectile_speed : float = 20.0
@export var bullet_asset : PackedScene
@export var burst_fire_count : int = 3
@export var range : float = 25.0
@export var damage : int = 5

var burst_fire_timer : float = 0.0

var time_between_shots : float = 0.25 / float(burst_fire_count)
var burst_firre_cooldown : float = 0.0

var cooldown : float = 0.0

var rng : RandomNumberGenerator = RandomNumberGenerator.new()

func spawn_bullet():
	var player_raycast : RayCast3D = Global.player.get_node("Camera3D/RayCast3D")
	var bullet : Node3D = bullet_asset.instantiate()
	
	get_tree().get_root().add_child(bullet)
	bullet.global_transform = player_raycast.global_transform
	bullet.position -= player_raycast.global_basis.z * 2
	bullet.damage = damage
	
	
	bullet.get_node("sprite").global_position = $muzle.global_position
	bullet.speed = projectile_speed
	

func shoot(delta: float,inaccuracy : float = 0.0):
	
	$AnimationPlayer.stop()
	$AnimationPlayer.play("shot")
	
	var player_raycast : RayCast3D = Global.player.get_node("Camera3D/RayCast3D")
	
	var saved_rotation_raycast : Vector3 = player_raycast.rotation
	var saved_target_position_raycast : Vector3 = player_raycast.target_position
	
	if projectile:
		player_raycast.target_position.z = -2
	else:
		player_raycast.target_position.z = -range
	
	if inaccuracy > 0:
		
		player_raycast.rotation_degrees.x += rng.randf_range(-inaccuracy,inaccuracy)
		player_raycast.rotation_degrees.y += rng.randf_range(-inaccuracy,inaccuracy)
		
		player_raycast.force_update_transform()
		player_raycast.force_raycast_update()
		if player_raycast.is_colliding():
			var colider : Node3D = player_raycast.get_collider()
			if colider.has_method("hit_damage"):
				colider.hit_damage(damage)
		elif projectile:
			spawn_bullet()
		
	else:
		player_raycast.force_update_transform()
		player_raycast.force_raycast_update()
		if player_raycast.is_colliding():
			var colider : Node3D = player_raycast.get_collider()
			if colider.has_method("hit_damage"):
				colider.hit_damage(damage)
		elif projectile:
			spawn_bullet()
	
	player_raycast.rotation = saved_rotation_raycast
	player_raycast.target_position = saved_target_position_raycast
	player_raycast.force_update_transform()
	player_raycast.force_raycast_update()
	

enum fire_modes {
	semi_auto = 0,
	burst = 1,
	automatic = 2,
	shotgum = 3,
}

@export var fire_mode : fire_modes

func _physics_process(delta: float) -> void:
	
	
	
	
	
	if Input.is_action_just_pressed("fire") and not Global.is_paused and cooldown < 0:
		shoot(delta)
		Global.player.shot_animation()
		$muzle/MeshInstance3D.visible = true
		
	if Input.is_action_just_pressed("alt_fire") and not Global.is_paused and cooldown < 0:
		burst_fire_timer = 0.25
		$muzle/MeshInstance3D.visible = true
		
	if burst_fire_timer > 0:
		burst_fire_timer -= delta
		
		burst_firre_cooldown -= delta
		if burst_firre_cooldown <= 0:
			shoot(delta,2)
			Global.player.shot_animation()
			cooldown = 0.25
			burst_firre_cooldown = time_between_shots
			
	
	
	cooldown -= delta
