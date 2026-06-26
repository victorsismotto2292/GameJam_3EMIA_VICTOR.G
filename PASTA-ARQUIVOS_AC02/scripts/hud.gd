extends CanvasLayer

# variável referenciando a label de vidas:
@onready var vida_label: Label = $Control/VidaLabel

# variável referenciando a pontuação
@onready var pontos_label: Label = $Control/PontosLabel

@onready var chave_label: Label = $Control/ChaveLabel

# variável para tempo no cronometro
var tempo: float = 60.0
@onready var timer_label: Label = $Control/TempoLabel

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
		
# função cronômetro:
func _process(delta: float) -> void:
	if tempo > 0:
		tempo -= delta
		timer_label.text = formatar_tempo(tempo) #tempo formatado
	else:
		get_tree().change_scene_to_file("res://scenes/game_over.tscn") #atualizando para cena de game over
		
# função formatar tempo:
func formatar_tempo(segundos: float) -> String:
	var minutos = int(segundos)/60
	var secs = int(segundos) % 60
	# retornando valores:
	return "%02d:%02d" % [minutos, secs]
