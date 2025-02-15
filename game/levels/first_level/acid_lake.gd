extends Area2D
@onready var marker_2d: Marker2D = $Marker2D




func _on_body_entered(body: Node2D) -> void:
	body.hurt(self,10);
	body.knockback_vector = Vector2.ZERO
	await get_tree().create_timer(.1).timeout
	body.global_position = marker_2d.global_position
	
