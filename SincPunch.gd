extends State
@onready var animation_player = $"../../AnimationPlayer"
var attack_finished = false
@onready var left_hand = $"../../Left_Hand"
@onready var right_hand = $"../../Right_Hand"
const WAVE = preload("res://Prefabs/wave.tscn")



func enter():
	attack_finished = false
	super.enter()
	owner.set_physics_process(false)
	animation_player.play("SincPunch")
	print("sinc punch!")
	await get_tree().create_timer(1.3).timeout
	var new_wave_right = WAVE.instantiate()
	var new_wave_left = WAVE.instantiate()
	new_wave_right.position = right_hand.global_position
	new_wave_right.speed = 100
	new_wave_left.position = left_hand.global_position
	new_wave_left.speed = -100
	new_wave_left.position.y+=40
	new_wave_right.position.y+=40
	owner.add_child(new_wave_left)
	owner.add_child(new_wave_right)
	
func exit():
	
	super.exit()
	#owner.set_physics_process(false)
	
func transition():
	if attack_finished:
		attack_finished = false
		get_parent().change_state("Idle")
		print("Now its idling")
		


func _on_animation_player_animation_finished(anim_name):
	attack_finished = true
	

