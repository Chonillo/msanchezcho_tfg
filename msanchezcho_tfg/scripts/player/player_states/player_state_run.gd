extends PlayerStateGravityBase

@onready var coyoteRun: Timer = $CoyoteRun
var animationFinished = false
 
func start():
	if player.anim.current_animation == "basic_shot" and player.anim.is_playing():
		pass#espera a que acabe
	else:
		player.play_animation("run")

func end():
	animationFinished = false

func on_physics_process(delta):
	#player.play_animation("run") 
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
	# Comprobar colisiones mientras el personaje se mueve
	for i in player.get_slide_collision_count():
		var collision = player.get_slide_collision(i)
		var collider = collision.get_collider()
		#collider.apply_central_impulse(collision.get_normal() * -PUSH_FORCE)
		# Animacion de empujar
		if collider.is_in_group("pushable_objects") and player.is_on_floor():
			print("caja")
			player.anim.play("push")
		#Solo Paolo puede empujar la caja
		if collider.is_in_group("pushable_objects") and abs(collider.get_linear_velocity().x) < player.movement_stats.max_velocity_push and player.current_character == 2 and player.is_on_floor():
			collider.apply_central_impulse(collision.get_normal() * -player.movement_stats.push_force)