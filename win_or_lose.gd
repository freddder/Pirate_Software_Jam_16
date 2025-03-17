extends Control

@onready var win_screen: Control = $Win
@onready var lose_screen: Control = $Lose

func _ready():
	if Level.did_player_win:
		win_screen.visible = true
		lose_screen.visible = false
	else:
		win_screen.visible = false
		lose_screen.visible = true


func _on_play_again_button_pressed():
	Level.scene = "map"
	Level.play_game()


func _on_main_menu_button_pressed():
	Level.scene = "title"
	Level.exit_game()
