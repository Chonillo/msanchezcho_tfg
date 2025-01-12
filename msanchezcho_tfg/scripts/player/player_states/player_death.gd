extends PlayerStateGravityBase


func start():
	player.game_over.play()
	player.anim.play("death")
	player.velocity.x = 0 

func on_physics_process(delta):
	
	handle_gravity(delta)
	controlled_node.move_and_slide()
