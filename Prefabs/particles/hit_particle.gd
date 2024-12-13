extends GPUParticles2D


# Called when the node enters the scene tree for the first time.
func _ready():
	self.emitting = true
	await get_tree().create_timer(3.5).timeout
	queue_free()

func _process(delta):
	global_position = get_parent().global_position
