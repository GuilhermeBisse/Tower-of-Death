extends CharacterBody2D

var dir: float
const speed = 900.0
const JUMP_VELOCITY = -400.0
var is_chasing = false
var player
var player_on_spear_range = false
@onready var walk_time = $WalkTime
@onready var sight_ray_1 = $SightRay1
@onready var spear_range = $SpearRange
@onready var hit_box = $HitBox
@onready var attack_delay = $AttackDelay

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	player = Global.global_player

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	
	velocity.x = dir * speed * delta
	#print(velocity.x)
	handle_movement()
	handle_animation()
	move_and_slide()


func _on_walk_time_timeout():
	if !is_chasing:
		dir = 0
		await get_tree().create_timer(3).timeout
		walk_time.wait_time = choose([1,1.5,2])
		dir = choose([-1,1])
	
func choose(array):
	array.shuffle()
	return array.front()
	
func handle_animation():
	if velocity.x < 0:
		spear_range.scale.x = -1
		sight_ray_1.scale.x = -1
		hit_box.scale.x = -1
	elif velocity.x > 0:
		spear_range.scale.x = 1
		sight_ray_1.scale.x = 1
		hit_box.scale.x = 1

func handle_movement():
	if sight_ray_1.is_colliding():
		if sight_ray_1.get_collider() == player:
			is_chasing = true
	
	if is_chasing and !player_on_spear_range:
		dir = position.direction_to(player.global_position).x * 5
	elif player_on_spear_range:
		dir = 0;

func _on_spear_range_body_entered(body):
	if body == player:
		player_on_spear_range = true
		attack_delay.start()

func _on_spear_range_body_exited(body):
	if body == player:
		player_on_spear_range = false


func _on_attack_delay_timeout():
	if player_on_spear_range:
		var collision_shape = hit_box.get_node("CollisionShape2D")
		await get_tree().create_timer(.1).timeout
		collision_shape.disabled = false
		await get_tree().create_timer(.1).timeout
		collision_shape.disabled = true
		attack_delay.start()
