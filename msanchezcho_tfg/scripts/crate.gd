extends CharacterBody2D


const SPEED = 100.0
var direction: int = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		move_and_slide()
		
	velocity.x = direction * SPEED
