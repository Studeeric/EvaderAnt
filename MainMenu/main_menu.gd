extends Control

@onready var button_container: VBoxContainer = $VBoxContainer/MainMenu/ButtonContainer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_play_button_pressed() -> void:
	animation_player.play(&"play_pressed")
	disable_menu()


func _on_leaderboard_button_pressed() -> void:
	animation_player.play(&"leaderboard_pressed")
	disable_menu()


func _on_quit_button_pressed() -> void:
	animation_player.play(&"quit_pressed")
	disable_menu()

func disable_menu() -> void:
	for child: Node in button_container.get_children():
		if child is Button:
			child.disabled = true

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == &"play_pressed":
		get_tree().change_scene_to_file("res://Game/world.tscn")
	if anim_name == &"quit_pressed":
			get_tree().quit()
	if anim_name == &"leaderboard_pressed":
		get_tree().change_scene_to_file("res://Game/UI/Leaderboard/Leaderboard.tscn")
