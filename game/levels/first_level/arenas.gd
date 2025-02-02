extends Node


@onready var platform: AnimatableBody2D = $platform
@onready var platform_path_follower: PathFollow2D = $Path2D/PathFollow2D
@onready var floor_1: CollisionShape2D = $Floor/Floor1

enum PlatformStatus {WAITING,STOP, UP, DOWN}
var arenas_cleared = 0;
var current_platform_status: PlatformStatus

func _ready() -> void:
	floor_1.disabled = true


func _physics_process(delta: float) -> void:
	platform.global_position = platform_path_follower.global_position
	if arenas_cleared == 0:
		if current_platform_status == PlatformStatus.UP:
			if platform_path_follower.progress_ratio <= 0.169:
				platform_path_follower.progress_ratio += 0.001
			else:
				current_platform_status = PlatformStatus.STOP
				floor_1.disabled = false
				print("floor 1 turned on")
		

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == Global.global_player and current_platform_status == PlatformStatus.WAITING:
		current_platform_status = PlatformStatus.UP
		print(current_platform_status)
		print(platform_path_follower.progress_ratio)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == Global.global_player and current_platform_status != PlatformStatus.STOP:
		current_platform_status = PlatformStatus.WAITING
		print(current_platform_status)
