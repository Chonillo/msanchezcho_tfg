extends PlayerStateGravityBase

var has_special_jumped: bool = false## Variable para controlar si el personaje ya ha saltado

# Función que se llama cuando el estado de salto comienza
func start():
	# Reinicia la variable has_special_jumped a false cuando el estado de salto comienza
	player.double_jump_sound.volume_db = -15
	player.double_jump_sound.pitch_scale = 0.5
	player.double_jump_sound.play()
	player.play_animation("special_jump")
	has_special_jumped = false

# Función que se llama en cada frame de física
func on_physics_process(delta):
	# Obtiene el eje de entrada del jugador (izquierda/derecha)
	var input_axis = Input.get_axis("ui_left", "ui_right")
	
	# Maneja la aceleración y la fricción durante el salto
	handle_acceleration_jump(input_axis, delta)
	apply_friction_jump(input_axis, delta)
	
	# Si el personaje no ha saltado aún, establece la velocidad vertical para que salte
	if not has_special_jumped:
		player.velocity.y = -player.movement_stats.jump_speed * 1.5
		has_special_jumped = true
	
	# Si la velocidad vertical es mayor que 0 (el personaje está cayendo), cambia al estado de caída
	if player.velocity.y > 0:
		state_machine.change_to(player.states.Fall)
	
	# Maneja la gravedad y mueve al personaje
	handle_gravity(delta)
	player.move_and_slide()
