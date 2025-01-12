extends CanvasLayer

@onready var color_rect: ColorRect = $Control/ColorRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Asegúrate de que el ColorRect esté visible y la opacidad inicial sea 0
	color_rect.visible = true
	color_rect.modulate.a = 0
	
	var tween: Tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property(color_rect, "modulate:a", 0.8, 1.0)


func _on_button_pressed() -> void:
	get_tree().quit()
