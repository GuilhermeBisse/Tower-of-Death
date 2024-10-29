extends State
@onready var animation_player = $"../../AnimationPlayer"
var attack_finished = false
func enter():
	super.enter()
	owner.set_physics_process(true)
	animation_player.play("SincPunch")
	
func exit():
	super.exit()
	#owner.set_physics_process(false)
	
func transition():
	if attack_finished:
		get_parent().change_state("Idle")
		print("Now its idling")
		attack_finished = false


func _on_animation_player_animation_finished(anim_name):
	attack_finished = true
	

