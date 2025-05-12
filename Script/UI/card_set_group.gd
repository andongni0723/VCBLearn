class_name CardSetGroup extends DataGroup

@export var folder_path : String

func _init() -> void:
    signal_prefix = "open_card_"
    data_path = folder_path

func _ready() -> void:
    container.vertical = vertical

func initialize(_folder_path: String):
    data_path = folder_path
    print(_folder_path)
    _generate_data_button(_folder_path)
