extends Node2D

@onready var left_hand = $Left_Hand
@onready var right_hand = $Right_Hand
@onready var sprite_left_hand = $Left_Hand/Sprite_Left_Hand
@onready var sprite_right_hand = $Right_Hand/Sprite_Right_Hand
@onready var juice_anim = $JuiceAnimations

const HIT_PARTICLE = preload("res://game/particles/scene/hit_particle.tscn")

var hand_scale
var direction : Vector2
var speed = 1000
var current_position
var bounce_tween: Tween

signal damaged

func _ready():
	#set_physics_process(false)
	right_hand.position = Vector2(270,70)
	left_hand.position = Vector2(-270,70)
	direction.x = 1
	hand_scale = sprite_left_hand.scale * 1.15
	
	
func _physics_process(delta):
	position += direction * speed * delta
	

func _on_right_detector_area_entered(area):
	if area.get_name() == "RightLimit":
		direction.x = -1


func _on_left_detector_area_entered(area):
	if area.get_name() == "LeftLimit":
		direction.x = 1



func _on_left_detector_body_entered(body):
	pass # Replace with function body.


func _on_hitbox_body_entered(body):
	if body == Global.global_player:
		body.hurt(left_hand,10)


func _on_hitbox_2_body_entered(body):
	if body == Global.global_player:
		body.hurt(right_hand,10)




func _on_hitbox_area_entered(area):
	#hurt(Global.global_player,10)
	current_position = global_position
	


func create_bounce():
	if bounce_tween and bounce_tween.is_running():
		bounce_tween.kill()
	bounce_tween = create_tween()

func _on_hitbox_2_hitted():
	damaged.emit()
	## now i will do the bounce thing:
	create_bounce()
	bounce_tween.tween_property(sprite_right_hand,"scale", Vector2(2.267*1.15,2.267*1.15),0.2) \
				.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	bounce_tween.parallel().tween_property(sprite_right_hand,"rotation_degrees",randf_range(-10.0,10.0),0.2) \
				.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	bounce_tween.tween_property(sprite_right_hand,"scale", Vector2.ONE,0.2) \
				.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	bounce_tween.parallel().tween_property(sprite_right_hand,"rotation_degrees",0,0.2) \
				.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	
	## Now i will spawn particles:
	
	var soul_instance = HIT_PARTICLE.instantiate()
	soul_instance.global_position = sprite_right_hand.global_position
	soul_instance.rotation = (Global.global_player.global_position - right_hand.global_position).angle()
	soul_instance.emitting = true
	print(sprite_right_hand.position)
	print(sprite_right_hand.global_position)
	print(soul_instance.global_position)
	juice_anim.play("right_hurt")
	add_child(soul_instance)
	Global.freeze_time(0.0,0.1)

func _on_hitbox_hitted():
	damaged.emit()
	## now i will do the bounce thing:
	create_bounce()
	bounce_tween.tween_property(sprite_left_hand,"scale", Vector2(2.267*1.15,2.267*1.15),0.2) \
				.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	bounce_tween.parallel().tween_property(sprite_left_hand,"rotation_degrees",randf_range(-10.0,10.0),0.2) \
				.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	bounce_tween.tween_property(sprite_left_hand,"scale", Vector2.ONE,0.2) \
				.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	bounce_tween.parallel().tween_property(sprite_left_hand,"rotation_degrees",0,0.2) \
				.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
