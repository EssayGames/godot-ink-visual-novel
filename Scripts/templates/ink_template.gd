extends Node

# ############################################################################ #
# Imports
# ############################################################################ #

var InkPlayer = load("res://addons/inkgd/ink_player.gd")
@export var _loaded_story : Resource

var choice_button = load("res://Scenes/choice_button.tscn")
var story_vars = [
	"had_lunch",
]

# ############################################################################ #
# Public Nodes
# ############################################################################ #

@onready var _ink_player = InkPlayer.new()

# ############################################################################ #
# Lifecycle
# ############################################################################ #

func _ready():
	# Adds the player to the tree.
	add_child(_ink_player)

	# Replace the example path with the path to your story.
	# Remove this line if you set 'ink_file' in the inspector.
	_ink_player.ink_file = _loaded_story

	# It's recommended to load the story in the background. On platforms that
	# don't support threads, the value of this variable is ignored.
	_ink_player.loads_in_background = true

	_ink_player.loaded.connect(_story_loaded)

	# Creates the story. 'loaded' will be emitted once Ink is ready
	# continue the story.
	_ink_player.create_story()


# ############################################################################ #
# Signal Receivers
# ############################################################################ #

func _story_loaded(successfully: bool):
	if !successfully:
		return

	_observe_variables()
	# _bind_externals()

	_continue_story()


# ############################################################################ #
# Private Methods
# ############################################################################ #

func _continue_story():
	while _ink_player.can_continue:
		var text = _ink_player.continue_story()
		# This text is a line of text from the ink story.
		# Set the text of a Label to this value to display it in your game.
		print(text)
		
		$Text.text = text
		
	if _ink_player.has_choices:
		# 'current_choices' contains a list of the choices, as strings.
		for choice in _ink_player.current_choices:
			
			print(choice.text)
			print(choice.tags)
			
			var btn = choice_button.instantiate()
			btn.text = choice.text
			$VBoxContainer.add_child(btn)
			
			btn.pressed.connect(_select_choice.bind(choice.index))
			# '_select_choice' is a function that will take the index of
			# your selection and continue the story.
			#_select_choice(0)
	else:
		# This code runs when the story reaches it's end.
		print("The End")


func _select_choice(index):
	_ink_player.choose_choice_index(index)
	for choice in $VBoxContainer.get_children():
		choice.queue_free()
	_continue_story()


# Uncomment to bind an external function.
#
# func _bind_externals():
# 	_ink_player.bind_external_function("<function_name>", self, "_external_function")
#
#
# func _external_function(arg1, arg2):
#	 pass


# Uncomment to observe the variables from your ink story.
# You can observe multiple variables by putting adding them in the array.
func _observe_variables():
	_ink_player.observe_variables(story_vars, self, "_variable_changed")
#
#
func _variable_changed(variable_name, new_value):
	if story_vars.has(variable_name) and new_value == true:
		$Hungry_Text.visible = new_value
	print("Variable '%s' changed to: %s" %[variable_name, new_value])
