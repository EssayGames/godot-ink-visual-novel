# warning-ignore-all:return_value_discarded

extends Control

var InkPlayer = load("res://addons/inkgd/ink_player.gd")
@onready var choice_btn = load("res://Scenes/Dialog_Button.tscn")
@onready var f_happy_icon = load("res://Sprites/female_01_smile.png")
@onready var f_neutral_icon = load("res://Sprites/female_01_neutral.png")

var _ink_player = InkPlayer.new()
@onready var _btn = []

func _ready():
	add_child(_ink_player)
	_ink_player.ink_file = load("res://INK/Tutorial_example.json")
	
	_ink_player.loads_in_background = true
	_ink_player.connect("loaded", Callable(self, "_story_loaded"))
	_ink_player.create_story()

func _story_loaded(successfully: bool):
	if !successfully:
		print("Not loaded")
		return

	_observe_variables()
	# _bind_externals()

	_continue_story()

func _continue_story():
	while _ink_player.can_continue:
		var text = _ink_player.continue_story()
		
		var dialog_text = get_node("ColorRect/Dialog")
		dialog_text.text = text
		dialog_text.text = dialog_text.text.replace("`",  "\n")
		
	if _ink_player.has_choices:
		# 'current_choices' contains a list of the choices, as references.
		for choice in _ink_player.current_choices:
			#print(choice.text)
			
			var button = choice_btn.instantiate()
			button.text = choice.text
			
			button.connect("pressed", Callable(self, "_index_choose").bind(button))
			
			_btn.append(button)
			$ColorRect/Choice_Container.add_child(button)
			
	else:
		$ColorRect/Close.visible = true
		$ColorRect/Close.connect("pressed", Callable(self, "_close_btn"))
		print("The End")

func _index_choose(button):
	var index = _btn.find(button)
	if index != -1:
		_select_choice(index)		


func _select_choice(index):
	for button in $ColorRect/Choice_Container.get_children():
		$ColorRect/Choice_Container.remove_child(button)
		_btn.erase(button)
	_ink_player.choose_choice_index(index)
	_continue_story()
	
func _close_btn():
	$ColorRect.visible = false
	$Male.visible = false
	$Female.visible = false
	$ColorRect/Close.visible = false


# Uncomment to bind an external function.
#
# func _bind_externals():
# 	_ink_player.bind_external_function("<function_name>", self, "_external_function")
#
# func _external_function(arg1, arg2):
# 	pass

func _observe_variables():
	_ink_player.observe_variables(["f_happy", "f_nervous", "f_neutral"], self, "_variable_changed")

func _variable_changed(variable_name, new_value):
	if variable_name == "f_happy" and new_value == true:
		$Female.texture = f_happy_icon
	elif variable_name == "f_happy" and new_value == false:
		$Female.texture = f_neutral_icon
	print("Variable '%s' changed to: %s" %[variable_name, new_value])

func _on_save_pressed():
	_ink_player.save_state_to_path("res://saves/save.save")
#	print(_ink_player.get_state())

	var file = FileAccess.open("res://saves/dialog_text.save", FileAccess.WRITE)
	file.store_string($ColorRect/Dialog.text)
	file.close()
	pass # Replace with function body.

func _on_load_pressed():
	if FileAccess.file_exists("res://saves/save.save"):
		_ink_player.load_state_from_path("res://saves/save.save")
		for child in $ColorRect/Choice_Container.get_children():
				child.queue_free()
				_btn.erase(child)
		var file = FileAccess.open("res://saves/dialog_text.save", FileAccess.READ)
		$ColorRect/Dialog.text = file.get_as_text()
		_continue_story()
	pass # Replace with function body.
