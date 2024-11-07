extends Node2D
var direction : Vector2
var speed = 1000
func _ready():
	#set_physics_process(false)
	direction.x = 1
	

func _on_right_detector_area_entered(area):
	if area.get_name() == "RightLimit":
		direction.x = -1


func _on_left_detector_area_entered(area):
	if area.get_name() == "LeftLimit":
		direction.x = 1

func _physics_process(delta):
	position += direction * speed * delta
