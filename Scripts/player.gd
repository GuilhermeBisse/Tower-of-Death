extends CharacterBody2D

@onready var animation = $animation
@onready var sword_area = $Area2D
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
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	handle_animation()
	move_and_slide()

func handle_animation():
	if velocity.x == 0:
		animation.play("Atlas_idle")
	elif velocity.x != 0:
		animation.play("Atlas_run")
	if velocity.x > 0:
		animation.flip_h = false
		sword_area.scale.x = 1
	elif velocity.x < 0:
		animation.flip_h = true
		sword_area.scale.x = -1


func _on_area_2d_body_entered(body):
	if body.name == "Enemy1":
		print("achei")
		body.hurt()
