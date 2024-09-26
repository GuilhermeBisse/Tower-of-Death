extends CharacterBody2D

const SPEED = 10000.0
var player
var chasing = false
var knockback_vector = Vector2.ZERO
@onready var sight_area = $SightArea

func _ready():
	player = Global.global_player

func _physics_process(delta):
	if chasing and knockback_vector == Vector2.ZERO:
		chase(delta)
	elif knockback_vector != Vector2.ZERO: #(0,0)
		velocity = knockback_vector * 25
	move_and_slide()
	
func chase(delta):
	velocity = global_position.direction_to(player.global_position) * SPEED * delta


func _on_sight_area_body_entered(body):
	if body == player:
		chasing = true

func hurt():
	knockback_vector = global_position - player.global_position
	var knockback_tween:= get_tree().create_tween()
	knockback_tween.tween_property(self,"knockback_vector", Vector2.ZERO,0.25)
