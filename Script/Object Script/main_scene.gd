extends Node

@export var ui_root: Control
var current_panel: MainPanel

func _enter_tree() -> void:
    GlobalSignal.footer_button_pressed.connect(_on_footer_button_pressed)
    GlobalSignal.call_create_folder_panel.connect(create_folder_panel)

func _exit_tree() -> void:
    GlobalSignal.footer_button_pressed.disconnect(_on_footer_button_pressed)
    GlobalSignal.call_create_folder_panel.disconnect(create_folder_panel)


func _ready() -> void:
    current_panel = UIManager.home_panel
    current_panel.visible = true
    pass

func change_panel(target: Control):
    # Pass same Panel
    if current_panel == target: return
    await current_panel.fade_out()
    current_panel = target
    await current_panel.fade_in()

func add_float_panel(target: PackedScene, data: FloatPanelResource):
    var p: FloatPanel = target.instantiate()
    ui_root.add_child(p)
    p.initialize(data)
    p.fade_in()

func create_folder_panel():
    var p: FloatPanel = UIManager.create_folder_panel.instantiate()
    ui_root.add_child(p)
    p.fade_in()

func _on_footer_button_pressed(id):
    match id:
        "home":
            change_panel(UIManager.home_panel)
        "library":
            change_panel(UIManager.library_panel)
        "add":
            add_float_panel(UIManager.float_panel, DataManager.add_card_and_folder_resource)
