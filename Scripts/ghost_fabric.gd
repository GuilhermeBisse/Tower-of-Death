extends Node2D

@export var ghost_scene: PackedScene
@export var sprite: AnimatedSprite2D
@export var color: Color

func start_spawn()->void:
	$Timer.start()
func stop_spawn()->void:
	$Timer.stop()



func _on_timer_timeout():
	var instance = ghost_scene.instantiate()
	get_tree().get_current_scene().add_child(instance)
	instance.global_position = sprite.global_position
	instance.rotation = sprite.rotation
	instance.texture = sprite.sprite_frames.get_frame_texture(sprite.animation,sprite.frame)
	instance.flip_h = sprite.flip_h
	instance.self_modulate = color
	instance.scale = sprite.scale
	instance.z_index = -1
