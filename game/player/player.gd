extends CharacterBody2D

@onready var lobby = $".."
@onready var animation = $animation
@onready var sword_area_side = $SwordSideArea
@onready var sword_area_up = $SwordUpArea
@onready var LifeBar = $ProgressBar
@onready var animation_player = $AnimationPlayer
#@onready var label: Label = $"../HUD/Moedas"
@onready var knockback_vector:= Vector2.ZERO
@onready var ghost_spawner = $GhostSpawner

const SPEED = 250.0
const JUMP_VELOCITY = -450.0
const CROSS_HIT = preload("res://game/particles/scene/cross_hit.tscn")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var life = 100
var cont_moedas = 0
var direction
var can_dash = false

func _ready():
	Global.global_player = self
	LifeBar.visible = false

func _physics_process(delta):
	if is_on_floor():
		can_dash = true
	LifeBar.value = life
	if knockback_vector != Vector2.ZERO:
		velocity = knockback_vector * 20
	
	elif not is_on_floor():
		velocity.y += gravity * delta
		

	# Handle jump.
	elif Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	direction = Input.get_axis("left", "right")
	if knockback_vector == Vector2.ZERO:
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	handle_animation()
	handle_attack()
	handle_dash()
	move_and_slide()

func handle_animation():
	if velocity.x == 0:
		animation.play("Atlas_idle")
	elif velocity.x != 0:
		animation.play("Atlas_run")
	if velocity.x > 0:
		animation.flip_h = false
		sword_area_side.scale.x = 1
	elif velocity.x < 0:
		animation.flip_h = true
		sword_area_side.scale.x = -1


func _on_area_2d_body_entered(body):
	if body.has_method("hurt"):
		print("achei")
		body.hurt(self,10)


func _on_sword_up_area_body_entered(body):
	if body.has_method("hurt"):
		print("achei")
		body.hurt(self,10)

func handle_attack():
	var damage_zone_side = sword_area_side.get_node("CollisionShape2D")
	var damage_zone_up = sword_area_up.get_node("CollisionShape2D")
	if Input.is_action_just_pressed("attack"):
		if Input.is_action_pressed("up"):
			damage_zone_up.disabled = false
			await get_tree().create_timer(0.3).timeout
			damage_zone_up.disabled = true
		else:
			damage_zone_side.disabled = false
			await get_tree().create_timer(0.3).timeout
			damage_zone_side.disabled = true

func hurt(body,damage):
	if(life > damage):
			life -= damage
			LifeBar.visible = true
			var hurt_particle_instance = CROSS_HIT.instantiate()
			hurt_particle_instance.global_position = global_position
			hurt_particle_instance.scale = Vector2(0.7,0.7)
			hurt_particle_instance.rotation_degrees = choose([5,7.5,10,12.5,15,17.5,20,-5,-7.5,-10,-12.5,-15.0,-17.5,-20])
			owner.add_child(hurt_particle_instance)
			animation_player.play("hurt_animation")
			Global.freeze_time(0.04,0.3)
			knockback_vector = (global_position - body.global_position)
			var knockback_tween:= get_tree().create_tween()
			knockback_tween.tween_property(self,"knockback_vector", Vector2.ZERO,0.25)
			
	else:
		## TODO: GAME OVER
		#queue_free()
		#gameOver()
		pass



func _on_sword_side_area_area_entered(area):
	if area.has_method("hurt"):
		print("achei")
		area.hurt(self,10)

func collect_coin():
	cont_moedas += 1
	#label.text = "Moedas: %d" % cont_moedas

func gameOver():
	queue_free()
	get_tree().change_scene_to_file("res://game/UI/GameOver/GameOver.tscn")

func choose(array):
	array.shuffle()
	return array[0]

func handle_dash():
	if Input.is_action_just_pressed("dash") and can_dash:
		ghost_spawner.start_spawn()
		can_dash = false
		knockback_vector = Vector2(direction,0) * 100
		var knockback_tween = get_tree().create_tween()
		knockback_tween.tween_property(self,"knockback_vector",Vector2.ZERO,0.2)
		self.set_collision_mask_value(3,false)
		await get_tree().create_timer(0.2).timeout
		ghost_spawner.stop_spawn()
		self.set_collision_mask_value(3,true)
