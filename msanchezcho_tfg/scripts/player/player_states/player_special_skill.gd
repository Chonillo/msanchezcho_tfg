extends PlayerStateGravityBase

var is_new_state: bool = false

func start():
	if player.current_character == 0:
		print("Edward")
		is_new_state = true
		state_machine.change_to(player.states.SpecialDoubleJump)
	elif player.current_character == 1:
		print("Miguel")
	elif player.current_character == 2:
		print("Paolo")
	
	if is_new_state or state_machine.current_state.name != player.states.SpecialDoubleJump:
		state_machine.change_to_previous_state()
		

func end():
	is_new_state = false
