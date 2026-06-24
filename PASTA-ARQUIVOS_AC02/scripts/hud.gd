extends CanvasLayer

# variável referenciando a label de vidas:
@onready var vida_label: Label = $Control/VidaLabel

# variável referenciando a pontuação
@onready var pontos_label: Label = $Control/PontosLabel

# funções:
func _ready() -> void:
	atualizar_vidas()
	atualizar_pontuação()
	
# função atualizar_vidas:
func atualizar_vidas() -> void:
	vida_label.text = "Vidas: " + str(GameManager.vida)
	
# função atualizar_pontuação:
func atualizar_pontuação() -> void:
	pontos_label.text = "Pontos: " + str(GameManager.pontos)
