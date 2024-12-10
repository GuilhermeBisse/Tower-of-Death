extends AnimatedSprite2D
@onready var hands = $"../Hands"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position = lerp(global_position,hands.global_position,delta * 3)
