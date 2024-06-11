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

var max_i := 10 # primeira opcao do outFor
var max_j := 20 # primeira opcao do inFor
var if_flor_branca := "=="
var if_flor_amarela := "=="
var if_flor_vermelha := "=="

func _ready():
	add_items()
	aviso.text = ""

func add_items():
	outForOpt.add_item("i < 10;")
	outForOpt.add_item("i <= 10;")
	inForOpt.add_item("j <= 10;")
	inForOpt.add_item("i < 10;")
	inForOpt.add_item("j < 10;")
	fstIfOpt.add_item("i == j")
	fstIfOpt.add_item("i > j")
	fstIfOpt.add_item("i < j")
	scdIfOpt.add_item("i == j")
	scdIfOpt.add_item("i > j")
	scdIfOpt.add_item("i < j")
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
	
	if max_i == 11:
		mostra_aviso("Cuidado para não acessar posições inválidas do vetor!", Color.RED)
		return
		
	if max_j == 20:
		mostra_aviso("Cuidado para não gerar um loop infinito! Olhe atentamente as condições do For interno.", Color.RED)
		return
		
	if if_flor_branca != "==":
		mostra_aviso("A flor branca precisa ser plantada na diagonal principal, verifique os índices nessa diagonal!", Color.RED)
		return

	if if_flor_amarela != "<":
		mostra_aviso("A flor amarela precisa ser plantada na parte superior, verifique a relação entre os índices!", Color.RED)
		return

	if if_flor_vermelha != ">":
		mostra_aviso("A flor vermelha precisa ser plantada na parte inferior, verifique a relação entre os índices!", Color.RED)
		return
		

	mostra_aviso("Você conseguiu", Color.GREEN)
	await camera.reset_camera()
	State.finaliza_interacao()
	State.current_npc.challenge_passed = true
	State.current_npc.ponto_excl.hide()
	queue_free()



func _on_out_for_opt_option_selected(index):
	if index == 0:
		max_i = 10
	elif index == 1:
		max_i = 11


func _on_in_for_opt_option_selected(index):
	if index == 0:
		max_j = 11
	elif index == 1: 
		max_j = 20
	elif index == 2:
		max_j = 10


func _on_thrd_if_opt_option_selected(index):
	if index == 0:
		if_flor_amarela = "=="
	elif index == 1:
		if_flor_amarela = ">"
	elif index == 2:
		if_flor_amarela = "<"


func _on_scnd_if_opt_option_selected(index):
	if index == 0:
		if_flor_vermelha = "=="
	elif index == 1:
		if_flor_vermelha = ">"
	elif index == 2:
		if_flor_vermelha = "<"

func _on_fst_if_opt_option_selected(index):
	if index == 0:
		if_flor_branca = "=="
	elif index == 1:
		if_flor_branca = ">"
	elif index == 2:
		if_flor_branca = "<"
