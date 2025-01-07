extends Node2D

var velocity = Vector2(400, -200)  # Velocidad inicial (x, y)
var gravity = 500                 # Fuerza de gravedad
var air_resistance = 0.98         # Resistencia del aire (reduce la velocidad x)
var max_fall_speed = 1000         # Velocidad terminal
var isFlip = false
signal bullet_destroyed

func _ready():
	$Timer.start()
	if isFlip:
		velocity.x *= -1

func _process(delta):
	# Aplicar gravedad y resistencia del aire
	velocity.y += gravity * delta
	if velocity.y > max_fall_speed:
		velocity.y = max_fall_speed
	velocity.x *= air_resistance

	# Actualizar posición
	position += velocity * delta

	# Agregar rotación
	rotation += velocity.x * delta * 0.01


func _on_body_entered(_body: Node2D) -> void:
	velocity = Vector2(0, 0)
	gravity = 0
	air_resistance = 0
	$AnimationPlayer.stop()
	$StoneSprite.play("disappear")

func _on_stone_sprite_animation_finished() -> void:
	destroy_myself()
	
func _on_timer_timeout() -> void:
	destroy_myself()
	
func destroy_myself():
	bullet_destroyed.emit()
	self.queue_free()
