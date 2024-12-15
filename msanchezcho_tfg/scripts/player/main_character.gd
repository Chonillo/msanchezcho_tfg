extends CharacterBody2D

@export var move_speed: float
@export var jump_speed: float
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const HIGH_JUMP_VELOCITY = -550.0  # Velocidad de salto mayor
const PUSH_FORCE = 350
const MAX_VELOCITY_PUSH = 150

@onready var characters: Array[Sprite2D] = [$SpriteGroup2D/Edward, $SpriteGroup2D/Miguel, $SpriteGroup2D/Paolo]
var current_character: int = 0
var is_facing_right = true

var anim: AnimationPlayer
var sprite: Sprite2D

#shot
@export var projectile_scene: PackedScene  # Arrastra aquí la escena "res://scenes/basicBullet.tscn"
@export var projectile_speed: float = 300.0  # Velocidad del proyectil

func _ready():
	switch_character(0)

func switch_character(indice: int) -> void:
	for i in range(characters.size()):
		characters[i].hide()
	characters[indice].show()
	current_character = indice
	# Ajustar para obtener el AnimationPlayer correcto
	if current_character == 0:
		anim = characters[current_character].get_node("AnimationEdward")
	elif current_character == 1:
		anim = characters[current_character].get_node("AnimationMiguel")
	elif current_character == 2:
		anim = characters[current_character].get_node("AnimationPaolo")
	sprite = characters[current_character]

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_select"):
		current_character = (current_character + 1) % characters.size()
		switch_character(current_character)
	elif event.is_action_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = -jump_speed
	elif event.is_action_pressed("ui_jump_high"):
		if is_on_floor() and current_character == 0:
			velocity.y = HIGH_JUMP_VELOCITY
		if current_character == 1:#dispara pte animacion no work
			shoot_projectile()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_x()
	flip()
	manage_animations()
	handle_box_push()
	move_and_slide()

func flip():
	if (is_facing_right and velocity.x < 0) or (not is_facing_right and velocity.x > 0):
		scale.x *= -1
		is_facing_right = not is_facing_right

func move_x():
	var input_axis = Input.get_axis("ui_left", "ui_right")
	velocity.x = input_axis * move_speed

func manage_animations():
	if is_on_floor():
		if velocity.x == 0:
			anim.play("idle")
		elif abs(velocity.x) > 0:
			anim.play("run")
	else:
		if velocity.y < 0:
			anim.play("jump")
		else:
			anim.play("fall")


func handle_box_push():
	# Comprobar colisiones mientras el personaje se mueve
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		#collider.apply_central_impulse(collision.get_normal() * -PUSH_FORCE)
		# Animacion de empujar
		if collider.is_in_group("pushable_objects") and is_on_floor():
			anim.play("push")
		#Solo Paolo puede empujar la caja
		if collider.is_in_group("pushable_objects") and abs(collider.get_linear_velocity().x) < MAX_VELOCITY_PUSH and current_character == 2 and is_on_floor():
			collider.apply_central_impulse(collision.get_normal() * -PUSH_FORCE)

func shoot_projectile():
	anim.play("basic_shot")
	# Verifica si el recurso del proyectil está asignado
	if projectile_scene == null:
		print("¡No se ha asignado la escena del proyectil!")
		return

	# Instanciar el proyectil
	var projectile_instance = projectile_scene.instantiate()
	projectile_instance.position = $projectileSpawn.global_position  # Posición inicial

	# Configura la velocidad del proyectil según la dirección del personaje
	projectile_instance.linear_velocity = Vector2(projectile_speed, 0) * (1 if is_facing_right else -1)

	# Añadir el proyectil al árbol de la escena
	get_tree().root.add_child(projectile_instance)
