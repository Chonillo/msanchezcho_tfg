extends CharacterBody2D
class_name mouseEnemy

@export_category("Config")

@export_group("Options")
@export var health: int = 1
#@export var score: int = 1 ##para dar puntos al personaje

@export_group("Montions")
@export var speed: int = 100
@export var gravity: int = 16

var direction: int = 1

func _process(_delta):
	if health >0:
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

## funcion 
func damage_control(damage: int):
	health -= damage
	
	if health <= 0:
		$AnimatedSprite2D.play("Die")
		speed = 0

## detecta cuando le disparan
func _on_damage_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("g_bullet"):
		damage_control(1)


func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "Die":
		self.queue_free()

## detecta si ataca al personaje
func _on_damage_area_body_entered(body: Node2D) -> void:
	if body is MainCharacter and health > 0:
		body.player_damage_control(1)
	pass # Replace with function body.
