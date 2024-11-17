extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const HIGH_JUMP_VELOCITY = -550.0  # Velocidad de salto mayor

@onready var personajes: Array[Sprite2D] = [$SpriteGroup2D/Edward, $SpriteGroup2D/Miguel, $SpriteGroup2D/Paolo]
var personaje_actual: int = 0

var anim: AnimationPlayer
var sprite: Sprite2D

func _ready():
	cambiar_personaje(0)

func cambiar_personaje(indice: int) -> void:
	for i in range(personajes.size()):
		personajes[i].hide()
	personajes[indice].show()
	personaje_actual = indice
	# Ajustar para obtener el AnimationPlayer correcto
	if personaje_actual == 0:
		anim = personajes[personaje_actual].get_node("AnimationPlayer")
	elif personaje_actual == 1:
		anim = personajes[personaje_actual].get_node("AnimationPlayer2")
	elif personaje_actual == 2:
		anim = personajes[personaje_actual].get_node("AnimationPlayer3")
	sprite = personajes[personaje_actual]

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_select"):
		personaje_actual = (personaje_actual + 1) % personajes.size()
		cambiar_personaje(personaje_actual)
	elif event.is_action_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
	elif event.is_action_pressed("ui_jump_high"):
		if is_on_floor():
			velocity.y = HIGH_JUMP_VELOCITY

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	var direction: float = Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * SPEED
		# Flip the sprite based on the direction
		sprite.flip_h = direction < 0
		anim.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		anim.play("idle")

	move_and_slide()
