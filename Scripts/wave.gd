extends Area2D

var speed

func _physics_process(delta):
	position.x+= speed * delta


func _on_timer_timeout():
	queue_free()
