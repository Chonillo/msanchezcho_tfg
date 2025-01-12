extends CharacterBody2D

@export_group("Montions")
@export var speed: int = 100
@export var gravity: int = 16

var direction: int = 1


func _process(_delta):
	motion_control()

## Patron basico
func motion_control():
	$AnimatedSprite2D.scale.x = direction
	
	##movimiento entre pared y precipicio
	if not $AnimatedSprite2D/RayGround.is_colliding() or is_on_wall():
		direction *= -1
	
	velocity.x = direction * speed
	velocity.y += gravity
	move_and_slide()

func _on_damage_area_body_entered(body: Node2D) -> void:
	if body is MainCharacter:
		body.player_damage_control(3)
