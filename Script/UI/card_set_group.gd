class_name CardSetGroup extends DataGroup

@export var folder_path : String

func _init() -> void:
    signal_prefix = "open_card_set_"
    data_path = folder_path
    generate_mode = Mode.FILE

func _ready() -> void:
    container.vertical = vertical


func initialize(_folder_path: String):
    data_path = folder_path
    _generate_data_button(_folder_path)


func _on_data_button_pressed(id: String):
    if not id.begins_with(signal_prefix): return
    var card_set_name := id.substr(signal_prefix.length())
    GlobalSignal.call_open_card_set.emit(card_set_name.get_basename())