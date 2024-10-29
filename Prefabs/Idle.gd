extends State
@onready var animation_player = $"../../AnimationPlayer"

var is_attacking = false

func enter():
	super.enter()
	animation_player.play("Idle")

func _on_attack_timer_timeout():
	is_attacking = true
	
func transition():
	if is_attacking:
		get_parent().change_state("SincPunch")
		is_attacking = false
		
func exit():
	super.exit()
	owner.set_physics_process(false)
