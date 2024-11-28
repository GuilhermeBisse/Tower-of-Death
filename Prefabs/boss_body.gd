extends AnimatedSprite2D
@onready var hands = $"../Hands"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position += global_position.direction_to(hands.global_position)
