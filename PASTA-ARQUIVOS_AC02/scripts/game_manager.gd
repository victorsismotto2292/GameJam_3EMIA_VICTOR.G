extends Node2D

var vida_inicial: int = 1 # valor de vida com que o jogador começa
var vida: int = vida_inicial # apenas uma vida, adicionará mais uma dependendo do
# boost de escudo ou de vida bônus

var pontos: int = 0 # variável dos pontos para contabilizar a cada moeda

func adicionar_ponto():
	pontos += 1
	print("Pontos: ", pontos)
	# Tenta encontrar o HUD na cena atual para atualizar a pontuação visualmente
	var hud = get_tree().current_scene.find_child("Hud", true, false)
	if hud and hud.has_method("atualizar_pontuação"):
		hud.atualizar_pontuação()

func resetar_pontos():
	pontos = 0
	# Tenta encontrar o HUD para zerar visualmente se necessário
	var hud = get_tree().current_scene.find_child("Hud", true, false)
	if hud and hud.has_method("atualizar_pontuação"):
		hud.atualizar_pontuação()
