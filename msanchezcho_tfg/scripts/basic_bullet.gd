extends RigidBody2D

@export var damage: int = 10  # Daño del proyectil
@export var lifetime: float = 1.0  # Tiempo antes de destruirse (opcional)

func _ready():
	# Iniciar el temporizador para destruir el proyectil si no impacta
	if has_node("LifetimeTimer"):
		$LifetimeTimer.start(lifetime)
		$LifetimeTimer.timeout.connect(self_destruct)

func _integrate_forces(_state):
	# Destruir el proyectil si sale fuera del área visible
	if position.y > 500 or position.x < -500 or position.x > 1500:
		queue_free()

func _on_body_entered(body: Node) -> void:
	# Comprobar si el proyectil golpea un enemigo
	if body.is_in_group("enemies"):  # Asegúrate de que los enemigos estén en un grupo llamado "enemies"
		body.take_damage(damage)  # Llama a un método en el enemigo para aplicar daño
		queue_free()  # Destruye el proyectil

func self_destruct():
	queue_free()  # Destruir el proyectil después de que expire el temporizador
