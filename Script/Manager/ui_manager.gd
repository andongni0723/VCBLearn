class_name UIManager extends Node

@export var _home_panel: MainPanel
static var home_panel: MainPanel

@export var _library_panel: MainPanel
static var library_panel: MainPanel

@export var _float_panel: PackedScene
static var float_panel: PackedScene

func _enter_tree() -> void:
    home_panel = _home_panel
    library_panel = _library_panel
    float_panel = _float_panel
