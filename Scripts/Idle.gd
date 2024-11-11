extends State
@onready var animation_player = $"../../AnimationPlayer"
@onready var attack_timer = $"../../AttackTimer"
var rng
var is_attacking = false
var attacks = ["SincPunch", "RightPunch", "LeftPunch", "LeftPush", "RightPush", "PressAttack"];
var penalty = (100 / attacks.size()) / 4 
var attack_chance = [(100 / attacks.size()),100 / attacks.size(),100 / attacks.size(),100 / attacks.size(),100 / attacks.size(),100 / attacks.size()]

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
		var choice = randf_range(1,100)
		if choice >= 0 and choice < attacks[0]:
			get_parent().change_state("SincPunch")
			attacks[0]-= penalty
			for a in attack_chance:
				if a==0:
					continue
				attack_chance[a]+=(penalty/attack_chance.size() - 1)
		elif choice >= attack_chance[0] and choice < attack_chance[0] + attack_chance[1]:
			get_parent().change_state("SincPunch")
			attack_chance[1]-= penalty
			for a in attack_chance:
				if a==1:
					continue
				attack_chance[a]+=(penalty/attack_chance.size() - 1)
		elif choice >= attack_chance[0] + attack_chance[1] and choice < attack_chance[0] + attack_chance[1] + attack_chance[3]:
			get_parent().change_state("SincPunch")
			attack_chance[2]-= penalty
			for a in attack_chance:
				if a==2:
					continue
				attack_chance[a]+=(penalty/attack_chance.size() - 1)
			
		elif choice >= attack_chance[0] + attack_chance[1] and choice < attack_chance[0] + attack_chance[1] + attack_chance[3]:
			get_parent().change_state("SincPunch")
			attack_chance[3]-= penalty
			for a in attack_chance:
				if a==3:
					continue
				attack_chance[a]+=(penalty/attack_chance.size() - 1)
						
func exit():
	super.exit()
	print("it stops idling")
