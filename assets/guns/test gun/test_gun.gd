extends Node3D



func _ready() -> void:
	pass

@export var bullet_asset : PackedScene

var burst_fire_timer : float = 0.0
@export var burst_fire_count : int = 3

var time_between_shots : float = 0.25 / float(burst_fire_count)
var burst_firre_cooldown : float = 0.0

var cooldown : float = 0.0

var rng : RandomNumberGenerator = RandomNumberGenerator.new()

func shoot(delta: float,inaccuracy : float = 0.0):
	if inaccuracy > 0:
		var bullet : Node3D = bullet_asset.instantiate()
		$muzle.look_at(Global.player.target)
		bullet.global_transform = $muzle.global_transform
		bullet.position -= bullet.basis.z.normalized() * (delta + 1)
		bullet.rotation_degrees.x += rng.randf_range(-inaccuracy,inaccuracy)
		bullet.rotation_degrees.y += rng.randf_range(-inaccuracy,inaccuracy)
		
		bullet.set_distance(delta * bullet.speed)
		get_tree().get_root().add_child(bullet)
		
	else:
		var bullet : Node3D = bullet_asset.instantiate()
		$muzle.look_at(Global.player.target)
		bullet.global_transform = $muzle.global_transform
		bullet.position -= bullet.basis.z.normalized() * (delta + 1)
		bullet.set_distance(delta * bullet.speed)
		get_tree().get_root().add_child(bullet)
		

enum fire_modes {
	semi_auto = 0,
	burst = 1,
	automatic = 2,
	shotgum = 3,
}

@export var fire_mode : fire_modes

func _physics_process(delta: float) -> void:
	
	
	if Input.is_action_just_pressed("alt_fire") :
		fire_mode += 1
		if fire_mode > 3:
			fire_mode = 0
	
	if fire_mode == 0:
		if Input.is_action_just_pressed("fire") and not Global.is_paused and cooldown < 0:
			shoot(delta)
			Global.player.shot_animation()
	elif fire_mode == 1:
		
		if Input.is_action_just_pressed("fire") and not Global.is_paused and cooldown < 0:
			burst_fire_timer = 0.25
			
		if burst_fire_timer > 0:
			burst_fire_timer -= delta
			
			burst_firre_cooldown -= delta
			if burst_firre_cooldown <= 0:
				shoot(delta)
				Global.player.shot_animation()
				cooldown = 0.5
				burst_firre_cooldown = time_between_shots
				
	elif fire_mode == 2:
		if Input.is_action_pressed("fire") and not Global.is_paused and cooldown < 0:
			shoot(delta)
			Global.player.shot_animation()
			cooldown = 0.1
		
	elif fire_mode == 3:
		if Input.is_action_just_pressed("fire") and not Global.is_paused and cooldown < 0:
			for i in range(0,12):
				shoot(delta, 10)
				Global.player.bump_shot_animation()
			cooldown = 1
	
	cooldown -= delta
