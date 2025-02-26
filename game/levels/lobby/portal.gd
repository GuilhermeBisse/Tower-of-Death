extends Area2D




func _on_body_entered(body: Node2D) -> void:
	SceneTransition.change_scene("res://game/levels/first_level/first_level.tscn")
