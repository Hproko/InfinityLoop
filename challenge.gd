extends Control



var for_code = "#include <stdio.h>

int main(void)
{
	int i;
	for 
}"



func _ready():
	$MarginContainer/Panel/CodeEdit.text = for_code
