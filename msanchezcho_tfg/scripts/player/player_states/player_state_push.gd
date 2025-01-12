extends PlayerStateGravityBase

func on_physics_process(delta):
	var input_axis = Input.get_axis("ui_left", "ui_right")
	handle_acceleration(input_axis, delta)
	handle_gravity(delta)
	
	if player.ray_cast_box.is_colliding() and player.is_on_floor() and player.current_character == 2:
		var colider = player.ray_cast_box.get_collider()
		#colider.direction = -1 if (player.velocity.x < 0) else 1
		
		if player.colider_direction != input_axis:
			state_machine.change_to(player.states.Run)
			return
		
		colider.move_and_slide()
	
	player.anim.play("push")
	
	player.move_and_slide()

func on_input(_event):
	if not Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		state_machine.change_to(player.states.Idle)  # Cambia al estado Idle
	elif Input.is_action_just_pressed("ui_left") and player.velocity.x > 0:
		state_machine.change_to(player.states.Run)  # Cambia al estado Run
	elif Input.is_action_just_pressed("ui_right") and player.velocity.x < 0:
		state_machine.change_to(player.states.Run)  # Cambia al estado Run
