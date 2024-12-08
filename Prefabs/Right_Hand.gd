extends RigidBody2D


func hurt(body, damage):
	var impact:= get_tree().create_tween()
	impact.tween_property(self,"position",position+position.direction_to(body.global_position)  *10,0.1)
