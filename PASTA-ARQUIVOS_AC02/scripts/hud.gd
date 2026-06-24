extends CanvasLayer

# variável referenciando a label de vidas:
@onready var vida_label: Label = $Control/VidaLabel

# função:
func _ready() -> void:
	atualizar_vidas()
	
# função atualizar_vidas:
func atualizar_vidas() -> void:
	vida_label.text = "Vidas: " + str(GameManager.vida)
