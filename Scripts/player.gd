extends CharacterBody2D

@onready var animation = $animation
@onready var sword_area_side = $SwordSideArea
@onready var sword_area_up = $SwordUpArea

@onready var LifeBar = $ProgressBar

const SPEED = 250.0
const JUMP_VELOCITY = -450.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var life = 100

func _ready():
	Global.global_player = self
	LifeBar.visible = false

func _physics_process(delta):
	LifeBar.value = life
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	handle_animation()
	handle_attack()
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
	if body.name == "Enemy1":
		print("achei")
		body.hurt()


func _on_sword_up_area_body_entered(body):
	if body.name == "Enemy1":
		print("achei")
		body.hurt()

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
