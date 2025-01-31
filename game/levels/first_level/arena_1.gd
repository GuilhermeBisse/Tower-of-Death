extends Area2D

var enemies: int = 10




func _on_body_exited(body: Node2D) -> void:
	if body != Global.global_player:
		enemies-=1
		print(enemies)
