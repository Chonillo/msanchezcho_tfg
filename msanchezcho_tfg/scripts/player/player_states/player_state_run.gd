extends PlayerStateGravityBase

@onready var coyoteRun: Timer = $CoyoteRun
 

func on_physics_process(delta):
	player.play_animation("run")
	var input_axis = Input.get_axis("ui_left", "ui_right")
	handle_acceleration(input_axis, delta)
	handle_gravity(delta)
	if not player.is_on_floor():
		if coyoteRun.is_stopped():
			coyoteRun.start()
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
