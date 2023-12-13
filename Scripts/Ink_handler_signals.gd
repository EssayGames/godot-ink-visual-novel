# warning-ignore-all:return_value_discarded

extends Control

# ############################################################################ #
# Imports
# ############################################################################ #

var InkPlayer = load("res://addons/inkgd/ink_player.gd")


# ############################################################################ #
# Public Nodes
# ############################################################################ #

# Alternatively, it could also be retrieved from the tree.
# onready var _ink_player = $InkPlayer
@onready var _ink_player = InkPlayer.new()

# ############################################################################ #
# Lifecycle
# ############################################################################ #

func _ready():
	# Replace the example path with the path to your story.
	# Remove this line if you set 'ink_file' in the inspector.
	_ink_player.ink_file = load("res://INK/Tutorial_example.ink.json")

	# It's recommended to load the story in the background. On platforms that
	# don't support threads, the value of this variable is ignored.
	_ink_player.loads_in_background = true

	_ink_player.connect("loaded", Callable(self, "_story_loaded"))
	_ink_player.connect("continued", Callable(self, "_continued"))
	_ink_player.connect("prompt_choices", Callable(self, "_prompt_choices"))
	_ink_player.connect("ended", Callable(self, "_ended"))

	# Creates the story. 'loaded' will be emitted once Ink is ready
	# continue the story.
	_ink_player.create_story()

# ############################################################################ #
# Signal Receivers
# ############################################################################ #

func _story_loaded(successfully: bool):
	if !successfully:
		return

	# _observe_variables()
	# _bind_externals()

	# Here, the story is started immediately, but it could be started
	# at a later time.
	_ink_player.continue_story()


func _continued(text, tags):
	print(text)
	# Here you could yield for an hypothetical signal, before continuing.
	# yield(self, "event")
	_ink_player.continue_story()


# ############################################################################ #
# Private Methods
# ############################################################################ #

func _prompt_choices(choices):
	if !choices.is_empty():
		print(choices)

		# In a real world scenario, _select_choice' could be
		# connected to a signal, like 'Button.pressed'.
		_select_choice(0)


func _ended():
	print("The End")


func _select_choice(index):
	_ink_player.choose_choice_index(index)
	_ink_player.continue_story()


# Uncomment to bind an external function.
#
# func _bind_externals():
# 	_ink_player.bind_external_function("<function_name>", self, "_external_function")
#
#
# func _external_function(arg1, arg2):
# 	pass


# Uncomment to observe the variables from your ink story.
# You can observe multiple variables by putting adding them in the array.
# func _observe_variables():
# 	_ink_player.observe_variables(["var1", "var2"], self, "_variable_changed")
#
#
# func _variable_changed(variable_name, new_value):
# 	print("Variable '%s' changed to: %s" %[variable_name, new_value])
