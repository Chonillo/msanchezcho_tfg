extends PlayerStateGravityBase

var is_new_state: bool = false
var count_shot = 0
var can_shot = true

func start():
	can_shot = true
	if player.current_character == 0:
		#print("Edward")
		is_new_state = true
		state_machine.change_to(player.states.SpecialDoubleJump)
	elif player.current_character == 1:
		#print("Miguel")
		shoot_bullet()
	elif player.current_character == 2:
		print("Paolo")
	
	if is_new_state or state_machine.current_state.name != player.states.SpecialDoubleJump:
		state_machine.change_to_previous_state()
		

func shoot_bullet():
	if count_shot == 0: can_shot = true
	if count_shot < 3 and can_shot:
		count_shot += 1
		player.anim.play("basic_shot")
		var newShot = player.projectile_scene.instantiate()

		# Ajusta la posición inicial de la piedra
		var offset = Vector2(-20, -20)  # Ajuste hacia adelante (x) y hacia arriba (y)
		if player.body.scale.x == -1:  # Si el jugador está mirando a la izquierda
			offset.x *= -1  # Invertir el desplazamiento horizontal
		newShot.position = player.position + offset
		# Determina la dirección de disparo
		newShot.isFlip = player.body.scale.x == -1
		newShot.connect("bullet_destroyed", _on_bullet_destroyed)

		add_sibling(newShot)
	else: can_shot = false

func _on_bullet_destroyed():
	count_shot -= 1

func end():
	is_new_state = false
