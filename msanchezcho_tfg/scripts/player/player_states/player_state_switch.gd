extends PlayerStateGravityBase

func start():
	player.current_character = (player.current_character + 1) % player.characters.size()
	switch_character(player.current_character)

func switch_character(indice: int):
	for i in range(player.characters.size()):
		player.characters[i].hide()
	player.characters[indice].show()
	player.current_character = indice
	# Ajustar para obtener el AnimationPlayer correcto
	if player.current_character == 0:
		player.anim = player.characters[player.current_character].get_node(player.animation_names[player.current_character])
	elif player.current_character == 1:
		player.anim = player.characters[player.current_character].get_node(player.animation_names[player.current_character])
	elif player.current_character == 2:
		player.anim = player.characters[player.current_character].get_node(player.animation_names[player.current_character])
	player.sprite = player.characters[player.current_character]
	state_machine.change_to_previous_state()  # Volver al estado anterior automáticamente
