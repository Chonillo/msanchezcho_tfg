extends PlayerStateGravityBase

@onready var coyoteIdle: Timer = $CoyoteIdle

func on_physics_process(delta):
	handle_gravity(delta)
	
	## aplica friccion si tiene velocidad despues de correr
	if abs(player.velocity.x) > 0:
		apply_friction_on_floor(0, delta)
	elif player.anim.current_animation == "basic_shot" and player.anim.is_playing():
		pass#espera a que acabe
	else:
		player.play_animation("idle")
	
	if not player.is_on_floor():
		if coyoteIdle.is_stopped():
			coyoteIdle.start()
	
	player.move_and_slide()
	
func on_input(_event):
	if player.can_move:
		# seria mejor usar el parametro _event para obtener la información del evento
		if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"): 
			state_machine.change_to(player.states.Run)
		elif Input.is_action_just_pressed("ui_select"):
			state_machine.change_to(player.states.SwitchCharacter)
		elif Input.is_action_just_pressed("ui_accept"):
			state_machine.change_to(player.states.Jump)
		elif Input.is_action_just_pressed("ui_special_skill"):
			state_machine.change_to(player.states.SpecialSkill)


func _on_coyote_idle_timeout() -> void:
	if not player.is_on_floor() and player.velocity.y > 0:
		state_machine.change_to(player.states.Fall)
