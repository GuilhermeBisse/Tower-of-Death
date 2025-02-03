extends Area2D

@export var enemies: int = 1

signal arena_2_cleared

func _on_body_exited(body: Node2D) -> void:
	if body != Global.global_player:
		enemies-=1
		print("enemy dead, current enemies " + str(enemies))
		if enemies == 0:
			arena_2_cleared.emit()
