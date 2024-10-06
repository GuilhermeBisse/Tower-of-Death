extends CharacterBody2D

const SPEED = 10000.0
var player
var chasing = false
var is_dashing = false
var knockback_vector = Vector2.ZERO
var dash_vector = Vector2.ZERO
@onready var sight_area = $SightArea

func _ready():
	player = Global.global_player

func _physics_process(delta):
	
	if knockback_vector != Vector2.ZERO: #(0,0)
		velocity = knockback_vector * 25
	elif dash_vector != Vector2.ZERO:
		velocity = dash_vector * 10
	elif chasing:
		chase(delta)
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


func _on_dash_area_body_entered(body):
	if body == player and not is_dashing:
		chasing = false
		is_dashing = true
		dash()



func dash():
	chasing = false
	velocity = position.direction_to(player.global_position) * -200
	var player_last_pos = player.global_position
	await get_tree().create_timer(0.7).timeout
	dash_vector = player_last_pos - global_position
	var dash_tween:= get_tree().create_tween()
	dash_tween.tween_property(self,"dash_vector",Vector2.ZERO, 0.2)
	await get_tree().create_timer(0.5).timeout
	chasing = true
	is_dashing = false
