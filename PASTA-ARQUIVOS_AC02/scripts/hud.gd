extends CanvasLayer

# variável referenciando a label de vidas:
@onready var vida_label: Label = $Control/VidaLabel

# variável referenciando a pontuação
@onready var pontos_label: Label = $Control/PontosLabel

@onready var chave_label: Label = $Control/ChaveLabel

# funções:
func _ready() -> void:
	atualizar_vidas()
	atualizar_pontuação()
	atualizar_chave()
	
# função atualizar_vidas:
func atualizar_vidas() -> void:
	vida_label.text = "Vidas: " + str(GameManager.vida)
	
# função atualizar_pontuação:
func atualizar_pontuação() -> void:
	pontos_label.text = "Pontos: " + str(GameManager.pontos)

# função atualizar_chave:
func atualizar_chave() -> void:
	if GameManager.tem_chave:
		chave_label.text = "Chave: Sim"
	else:
		chave_label.text = "Chave: Não"
