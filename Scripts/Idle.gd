extends State
@onready var animation_player = $"../../AnimationPlayer"
@onready var attack_timer = $"../../AttackTimer"
var rng
var is_attacking = false
var attacks = ["SincPunch", "RightPunch", "LeftPunch", "LeftPush", "RightPush", "PressAttack"];
func enter():
	randomize()
	super.enter()
	owner.set_physics_process(true)
	print("on idle")
	attack_timer.start()
	is_attacking = false

func _on_attack_timer_timeout():
	is_attacking = true
	attack_timer.wait_time = randf_range(3,5)
	print("it will attack! and its new time for attack is ", attack_timer.wait_time)
	
func transition():
	if is_attacking:
		attacks.shuffle()
		get_parent().change_state(attacks.front())
func exit():
	super.exit()
	print("it stops idling")
