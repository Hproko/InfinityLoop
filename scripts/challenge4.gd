extends Control

@onready var outForOpt = %OutForOpt
@onready var inForOpt = %InForOpt
@onready var fstIfOpt = %FstIfOpt
@onready var scdIfOpt = %ScndIfOpt
@onready var thrdIfOpt = %ThrdIfOpt
@onready var run_btn = %RunBtn
@onready var close_btn = %CloseBtn
@onready var code_edit = %CodeEdit
@onready var map = $'../map'
@onready var aviso = %Aviso
@onready var camera = get_tree().get_root().get_node("Main/Player/Camera")
@onready var player = get_tree().get_root().get_node("Main/Player")

var max_i := 10 # primeira opcao do outFor
var max_j := 11 # primeira opcao do inFor
var if_flor_branca := "=="
var if_flor_amarela := "=="
var if_flor_vermelha := "=="

var out_for_empty := true
var in_for_empty := true
var fst_if_empty := true
var scd_if_empty := true
var thrd_if_empty := true

func _ready():
	add_items()
	aviso.text = ""

func add_items():
	outForOpt.add_item(" ")
	outForOpt.add_item("i < 10;")
	outForOpt.add_item("i <= 10;")
	
	inForOpt.add_item(" ")
	inForOpt.add_item("j <= 10;")
	inForOpt.add_item("i < 10;")
	inForOpt.add_item("j < 10;")
	
	fstIfOpt.add_item(" ")
	fstIfOpt.add_item("i == j")
	fstIfOpt.add_item("i > j")
	fstIfOpt.add_item("i < j")
	
	scdIfOpt.add_item(" ")
	scdIfOpt.add_item("i == j")
	scdIfOpt.add_item("i > j")
	scdIfOpt.add_item("i < j")
	
	thrdIfOpt.add_item(" ")
	thrdIfOpt.add_item("i == j")
	thrdIfOpt.add_item("i > j")
	thrdIfOpt.add_item("i < j")
	

func _on_close_btn_pressed():
	await camera.reset_camera()
	State.finaliza_interacao()
	queue_free()
	
func disableBtns():
	outForOpt.disable()
	inForOpt.disable()
	fstIfOpt.disable()
	scdIfOpt.disable()
	thrdIfOpt.disable()
	run_btn.disabled = true
	close_btn.disabled = true

func enableBtns():
	outForOpt.enable()
	inForOpt.enable()
	fstIfOpt.enable()
	scdIfOpt.enable()
	thrdIfOpt.enable()
	run_btn.disabled = false
	close_btn.disabled = false
	
func mostra_aviso(text, cor):
	aviso.add_theme_color_override("font_color", cor)
	aviso.text = text
	aviso.show()
	
func _on_run_btn_pressed():
	
	aviso.hide()
	
	if out_for_empty or in_for_empty or fst_if_empty or scd_if_empty or thrd_if_empty:
		mostra_aviso("Não é possível executar o código sem escolher uma opção para os botões!", Color.RED)
		return
		
	disableBtns()
	
	await map.build_garden(max_i, max_j, if_flor_branca, if_flor_amarela, if_flor_vermelha)
	
	if max_j == 20:
		mostra_aviso("Cuidado para não gerar um loop infinito! Olhe atentamente as condições do For interno.", Color.RED)
		player.inc_ms_inf_loop()
		map.clear_garden()
		enableBtns()
		return
		
	if max_j == 11 and (if_flor_branca == '<' or if_flor_amarela == '<' or if_flor_vermelha == '<'):
		mostra_aviso("Cuidado para não acessar posições inválidas da matriz!", Color.RED)
		player.inc_ms_pos_invalid()
		map.clear_garden()
		enableBtns()
		return
		
	if max_i == 11 and (if_flor_branca == '>' or if_flor_amarela == '>' or if_flor_vermelha == '>'):
		mostra_aviso("Cuidado para não acessar posições inválidas da matriz!", Color.RED)
		player.inc_ms_pos_invalid()
		map.clear_garden()
		enableBtns()
		return
		
	if max_i == 11 and max_j == 11:
		if (if_flor_branca == '==' or if_flor_amarela == '==' or if_flor_vermelha == '=='):
			mostra_aviso("Cuidado para não acessar posições inválidas da matriz!", Color.RED)
			player.inc_ms_pos_invalid()
			map.clear_garden()
			enableBtns()
			return
		
	if if_flor_branca != "==":
		mostra_aviso("A flor branca precisa ser plantada na diagonal principal, verifique os índices nessa diagonal!", Color.RED)
		player.inc_ms_rel_oper()
		map.clear_garden()
		enableBtns()
		return

	if if_flor_amarela != "<":
		mostra_aviso("A flor amarela precisa ser plantada na parte superior, verifique a relação entre os índices!", Color.RED)
		player.inc_ms_rel_oper()
		map.clear_garden()
		enableBtns()
		return

	if if_flor_vermelha != ">":
		mostra_aviso("A flor vermelha precisa ser plantada na parte inferior, verifique a relação entre os índices!", Color.RED)
		player.inc_ms_rel_oper()
		map.clear_garden()
		enableBtns()
		return
		

	mostra_aviso("Você conseguiu", Color.GREEN)
	await camera.reset_camera()
	State.start_ballon(State.current_npc.dialogue_file, "sucesso")
	State.finaliza_interacao()
	State.current_npc.challenge_passed = true
	State.current_npc.ponto_excl.hide()
	queue_free()



func _on_out_for_opt_option_selected(index):
	if index == 0:
		out_for_empty = true
		return
	elif index == 1:
		max_i = 10
	elif index == 2:
		max_i = 11
		
	out_for_empty = false


func _on_in_for_opt_option_selected(index):
	if index == 0:
		in_for_empty = true
		return
	elif index == 1:
		max_j = 11
	elif index == 2: 
		max_j = 20
	elif index == 3:
		max_j = 10

	in_for_empty = false

func _on_thrd_if_opt_option_selected(index):
	if index == 0:
		thrd_if_empty = true
		return
	elif index == 1:
		if_flor_amarela = "=="
	elif index == 2:
		if_flor_amarela = ">"
	elif index == 3:
		if_flor_amarela = "<"
		
	thrd_if_empty = false


func _on_scnd_if_opt_option_selected(index):
	if index == 0:
		scd_if_empty = true
		return
	elif index == 1:
		if_flor_vermelha = "=="
	elif index == 2:
		if_flor_vermelha = ">"
	elif index == 3:
		if_flor_vermelha = "<"
		
	scd_if_empty = false

func _on_fst_if_opt_option_selected(index):
	if index == 0:
		fst_if_empty = true
		return
	elif index == 1:
		if_flor_branca = "=="
	elif index == 2:
		if_flor_branca = ">"
	elif index == 3:
		if_flor_branca = "<"
		
	fst_if_empty = false
