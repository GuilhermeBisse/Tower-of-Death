extends State


@onready var animation_player = $"../../AnimationPlayer"

var attack_finished = false
func enter():
	super.enter()
	owner.set_physics_process(false)
	animation_player.play("LeftPunchTest")
	print("left punch!")
	
func exit():
	super.exit()
	#owner.set_physics_process(false)
	
func transition():
	if attack_finished:
		owner.set_physics_process(false)
		attack_finished = false
		get_parent().change_state("Idle")
		print("Now its idling")


func _on_animation_player_animation_finished(anim_name):
	attack_finished = true
