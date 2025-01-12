extends Area2D

@export var hud: CanvasLayer

func _on_body_entered(body: Node2D) -> void:
	if body is MainCharacter:
		$AnimatedSprite2D.play("off")
		$SCollectPoint.play()
		if GLOBAL.game_data["score"] >= 7:
			GLOBAL.final_bueno = true
		hud.update_gems(1)
		##pte puntos

func _on_s_collect_point_finished() -> void:
	queue_free()
