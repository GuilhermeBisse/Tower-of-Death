extends Area2D


@onready var enemies: Node2D = $Enemies
@onready var enemy_summoners: Node = $EnemySummoners

var started: bool = false
var finished: bool = false

signal arena_1_cleared


func _process(delta: float) -> void:
	if started and enemies.get_child_count(false) == 0 and not finished:
		finished = true
		arena_1_cleared.emit()


func _on_arenas_arena_1_start() -> void:
	for summoner in enemy_summoners.get_children(false):
		summoner.spawn_enemy()
	started = true
