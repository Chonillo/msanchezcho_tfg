extends PlayerStateGravityBase

@onready var coyoteRun: Timer = $CoyoteRun
var animationFinished = false
 
func start():
	player.walk_sound.pitch_scale = 1.4
	player.walk_sound.volume_db = -20
	if player.anim.current_animation == "basic_shot" and player.anim.is_playing():
		pass#espera a que acabe
	else:
		player.play_animation("run")

func end():
	animationFinished = false

func on_physics_process(delta):
	# Verificar si está reproduciéndose
	if player.walk_sound.playing:
		pass
	else:
		player.walk_sound.play()
	
	var input_axis = Input.get_axis("ui_left", "ui_right")
	handle_acceleration(input_axis, delta)
	handle_gravity(delta)
	
	##gestiona la animacion despues de tirar la piedra
	if player.anim.current_animation == "" and not player.anim.is_playing() and not animationFinished:
		animationFinished = true
		player.play_animation("run")
	
	##coyote timer
	if not player.is_on_floor():
		if coyoteRun.is_stopped():
			coyoteRun.start()
	
	## manage special skills while run
	pushing_object()
		
	if player.anim.current_animation == "basic_shot" and player.anim.is_playing():
		pass#espera a que acabe
	
	player.move_and_slide()

func on_input(_event):
	if not Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		#print("Changing to Idle. Velocity.x:", player.velocity.x)  # Añade esta línea para depurar
		state_machine.change_to(player.states.Idle)  # Cambia al estado Idle
	elif Input.is_action_just_pressed("ui_select"):
		state_machine.change_to(player.states.SwitchCharacter)
	elif Input.is_action_just_pressed("ui_accept"): 
		state_machine.change_to(player.states.Jump)
	elif Input.is_action_just_pressed("ui_special_skill"):
		state_machine.change_to(player.states.SpecialSkill)

func _on_coyote_run_timeout() -> void:
	if player.is_on_floor() and player.velocity.y >= 0:
		state_machine.change_to(player.states.Idle)
	elif not player.is_on_floor():
		state_machine.change_to(player.states.Fall)

func pushing_object():
	if player.ray_cast_box.is_colliding() and player.is_on_floor() and player.current_character == 2:
		var colider = player.ray_cast_box.get_collider()
		colider.direction = -1 if (player.velocity.x < 0) else 1
		colider.move_and_slide()
		player.anim.play("push")
