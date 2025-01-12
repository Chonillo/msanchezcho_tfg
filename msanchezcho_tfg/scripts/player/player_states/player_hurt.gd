extends PlayerStateGravityBase


func start():
	player.hit_dmg_sound.play()
	player.anim.play("hurt")

func on_process(_delta):
	
	if player.anim.current_animation == "hurt" and player.anim.is_playing():
		pass
	if not player.anim.is_playing():
		if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"): 
			state_machine.change_to(player.states.Run)
		elif Input.is_action_just_pressed("ui_accept"):
			state_machine.change_to(player.states.Jump)
		else:
			state_machine.change_to(player.states.Idle)

func end():
	pass
