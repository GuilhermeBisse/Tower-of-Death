extends Marker2D

enum Enemies{NONE, STANDING, FLYING }

@export var enemy_type: Enemies

const FLYING_ENEMY = preload("res://game/enemies/flying_enemy/flying_enemy.tscn")
const STANDING_ENEMY = preload("res://game/enemies/standing_enemy/standing_enemy.tscn")


func spawn_enemy() -> void:
	var instance
	if enemy_type == Enemies.NONE:
		return
	if enemy_type == Enemies.STANDING:
		instance = STANDING_ENEMY.instantiate()
	if enemy_type == Enemies.FLYING:
		instance = FLYING_ENEMY.instantiate()
	instance.position = Vector2.ZERO
	get_parent().add_child(instance)
