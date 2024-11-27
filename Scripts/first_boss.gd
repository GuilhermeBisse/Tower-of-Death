extends Node2D
var direction : Vector2
var speed = 1000
@onready var left_hand = $Left_Hand
@onready var right_hand = $Right_Hand

func _ready():
	#set_physics_process(false)
	right_hand.position = Vector2(270,70)
	left_hand.position = Vector2(-270,70)
	direction.x = 1
	

func _on_right_detector_area_entered(area):
	if area.get_name() == "RightLimit":
		direction.x = -1


func _on_left_detector_area_entered(area):
	if area.get_name() == "LeftLimit":
		direction.x = 1

func _physics_process(delta):
	position += direction * speed * delta
