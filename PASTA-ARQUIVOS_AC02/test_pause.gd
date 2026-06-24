extends SceneTree

func _initialize():
	print("=== PAUSE MENU IN REAL LEVEL ===")

	# Carregar level - vai dar erro de tile, mas tudo bem
	# Vou só pegar o PauseMenu já instanciado no level
	var level = load("res://scenes/level.tscn")
	var level_inst = level.instantiate()

	# Não dar add_child (pra evitar erros de tile processando)
	# Em vez disso, instanciar manualmente a estrutura

	# Primeiro verificar o level_inst só no parse
	print("Level inst created: ", level_inst)

	# Tentar carregar level mesmo com erros
	root.add_child(level_inst)
	# Esperar 1 frame
	await physics_frame

	var pm = null
	for c in level_inst.get_children():
		if c.name == "PauseMenu":
			pm = c
			break

	if pm == null:
		print("[ERROR] PauseMenu not found in level")
		quit()
		return

	print("PauseMenu found in level")
	print("  size: ", pm.size)
	print("  position: ", pm.position)
	print("  global_rect: ", pm.get_global_rect())
	print("  viewport: ", pm.get_viewport().get_visible_rect().size if pm.get_viewport() else "no viewport")

	# Mostrar
	pm.show()
	await physics_frame
	print("After show(): size=", pm.size, " global_rect=", pm.get_global_rect())
	print("  visible: ", pm.visible)

	# Print full tree under PauseMenu
	print("PauseMenu children:")
	for c in pm.get_children():
		print("  - ", c.name, " type=", c.get_class(), " pos=", c.position, " size=", c.size)

	# Verificar pai
	var parent = pm.get_parent()
	print("PauseMenu parent: ", parent.name, " (", parent.get_class(), ")")
	if parent is Control:
		var parent_ctrl = parent as Control
		print("  parent size: ", parent_ctrl.size)

	print("=== DONE ===")
	level_inst.queue_free()
	quit()