extends PlayerStateGravityBase

func on_physics_process(delta):	
	player.play_animation("fall")
	var input_axis = Input.get_axis("ui_left", "ui_right")
	handle_acceleration_jump(input_axis, delta)
	apply_friction_jump(input_axis, delta)
	
	if (Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")) and player.velocity.y >= 0 and player.is_on_floor():
		state_machine.change_to(player.states.Run)
	elif player.velocity.y >= 0 and player.is_on_floor(): 
		state_machine.change_to(player.states.Idle)
	#elif player.velocity.y >= 0 and player.is_on_floor(): 
		#state_machine.change_to(player.states.Idle)
	
	handle_gravity(delta)
	controlled_node.move_and_slide()
