extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body is MainCharacter:
		$AnimatedSprite2D.play("off")
		$SCollectPoint.play()
		##pte puntos

func _on_s_collect_point_finished() -> void:
	queue_free()
