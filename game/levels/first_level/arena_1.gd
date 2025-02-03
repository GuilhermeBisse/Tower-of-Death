extends Area2D

@export var enemies: int = 5

signal arena_1_cleared

func _on_body_exited(body: Node2D) -> void:
	if body != Global.global_player:
		enemies-=1
		if enemies == 0:
			arena_1_cleared.emit()
