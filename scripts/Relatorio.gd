extends Control

@onready var player = get_tree().get_root().get_node("Main/Player")


func _ready():
	$VBoxContainer/Lbl_inf_loop.text = "    Quantidade de loops infinitos: " + str(player.miss_cncptn_inf_loop)
	$VBoxContainer/Lbl_pos_invalid.text = "    Quantidade de acesso a posições inválidas do vetor ou matriz: " + str(player.miss_cncptn_pos_invalid)
	$VBoxContainer/Lbl_rel_oper.text = "    Quantidade de uso incorreto de operadores relacionais: " + str(player.miss_cncptn_rel_oper)
	$VBoxContainer/Lbl_rel_logic.text = "    Quantidade de uso incorreto de operadores lógicos: " + str(player.miss_cncptn_rel_logic)

	var ms_list = [[player.miss_cncptn_inf_loop, "Loops e variáveis de controle"], 
				   [player.miss_cncptn_pos_invalid, "Matrizes e vetores"], 
				   [player.miss_cncptn_rel_oper, "Operadores relacionais"], 
				   [player.miss_cncptn_rel_logic, "Operadores lógicos"]]
	
	ms_list.sort()
	ms_list.reverse()
	
	$VBoxContainer/ListaDicas.text = "\n"
	
	for i in range(0, 2):
		$VBoxContainer/ListaDicas.text += "    - " + ms_list[i][1] + "\n"
		
			
	
	
	
	
