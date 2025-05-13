class_name UIManager extends Node

@export var _home_panel: MainPanel
static var home_panel: MainPanel

@export var _library_panel: MainPanel
static var library_panel: MainPanel

@export var _float_panel: PackedScene
static var float_panel: PackedScene

@export var _create_folder_panel: PackedScene
static var create_folder_panel: PackedScene

@export var _folder_panel: PackedScene
static var folder_panel: PackedScene

@export var _card_set_panel: PackedScene
static var card_set_panel: PackedScene

@export var _create_card_set_panel: PackedScene
static var create_card_set_panel: PackedScene

func _enter_tree() -> void:
    home_panel = _home_panel
    library_panel = _library_panel
    float_panel = _float_panel
    create_folder_panel = _create_folder_panel
    folder_panel = _folder_panel
    card_set_panel = _card_set_panel
    create_card_set_panel = _create_card_set_panel
