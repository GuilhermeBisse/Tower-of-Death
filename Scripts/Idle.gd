extends State
@onready var animation_player = $"../../AnimationPlayer"
@onready var attack_timer = $"../../AttackTimer"
var rng
var is_attacking = false
var attacks = ["SincPunch", "RightPunch", "LeftPunch"];
func enter():
	randomize()
	super.enter()
	owner.set_physics_process(true)
	print("on idle")
	attack_timer.start()

func _on_attack_timer_timeout():
	is_attacking = true
	attack_timer.wait_time = randf_range(5,10)
	print("it will attack! and its new time for attack is ", attack_timer.wait_time)
	owner.set_physics_process(false)
	
func transition():
	if is_attacking:
		attacks.shuffle()
		get_parent().change_state(attacks.front())
		is_attacking = false
	else:
		owner.move()
func exit():
	super.exit()
	print("it stops idling")
